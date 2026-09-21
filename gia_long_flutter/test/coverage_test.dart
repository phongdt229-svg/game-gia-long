import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/game/battle_engine.dart';
import 'package:gia_long_flutter/game/game_controller.dart';
import 'package:gia_long_flutter/models/player_state.dart';
import 'package:gia_long_flutter/models/scene.dart';
import 'package:gia_long_flutter/services/save_service.dart';
import 'package:gia_long_flutter/story/story_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'battle_engine_test.dart' show run, smartPolicy;

/// "Chơi thử toàn bộ các nhánh" bằng mô phỏng: hàng nghìn ván với người chơi ngẫu nhiên
/// (lúc khôn lúc dở) để chắc chắn không có cảnh/lựa chọn/kết thúc nào không thể đạt tới.
void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('mô phỏng 2000 ván: mọi cảnh, mọi lựa chọn, mọi kết thúc đều đạt được', () {
    final seenScenes = <String>{};
    final availableChoices = <String>{};
    final endings = <String>{};
    var hiddenQuest = 0;

    for (var seed = 0; seed < 2000; seed++) {
      final rng = Random(seed);
      final c = GameController.newGame(SaveService());
      var steps = 0;
      while (c.scene.type != SceneType.ending) {
        expect(++steps, lessThan(1500), reason: 'seed $seed kẹt ở ${c.scene.id}');
        final scene = c.scene;
        seenScenes.add(scene.id);
        switch (scene.type) {
          case SceneType.story:
            final open = c.visibleChoices.where(c.isUnlocked).toList();
            for (final ch in open) {
              availableChoices.add('${scene.id}|${ch.text}');
            }
            c.choose(open[rng.nextInt(open.length)]);
          case SceneType.battle:
            final def = battlesById[scene.battleId]!;
            final e = BattleEngine(
              def: def,
              army: c.state.stat('army'),
              food: c.state.stat('food'),
              morale: c.state.stat('morale'),
              weakened: c.isWeakened(def),
            );
            final careless = rng.nextDouble() < 0.4; // 40% ván chỉ bấm "Tấn công"
            while (!e.finished) {
              e.act(careless ? PlayerAction.attack : smartPolicy(e));
            }
            c.finishBattle(def, e.result);
          case SceneType.base:
            final def = basesById[scene.baseId]!;
            final work = PlayerState.fromJson(c.state.toJson());
            for (var i = 0; i < def.turns; i++) {
              final open = def.actions
                  .where((a) => a.requiresFlag == null || work.flags.contains(a.requiresFlag))
                  .toList();
              work.applyEffect(open[rng.nextInt(open.length)].effect);
            }
            c.finishBase(def, work.stats);
          case SceneType.ending:
            break;
        }
      }
      seenScenes.add(c.scene.id);
      for (final f in ['khoan_dung', 'bao_thu']) {
        if (c.state.flags.contains(f)) endings.add(f);
      }
      if (c.state.completedQuests.contains('Q3_DaChieu')) hiddenQuest++;
    }

    final allChoices = {
      for (final s in allScenes)
        for (final ch in s.choices) '${s.id}|${ch.text}',
    };
    expect(sceneById.keys.toSet().difference(seenScenes), isEmpty, reason: 'cảnh không bao giờ tới được');
    expect(allChoices.difference(availableChoices), isEmpty, reason: 'lựa chọn không bao giờ chọn được');
    expect(endings, {'khoan_dung', 'bao_thu'});
    expect(hiddenQuest, greaterThan(0), reason: 'quest ẩn không bao giờ hoàn thành được');
  });

  test('cân bằng: người chơi khôn luôn thắng trận giữa; bấm "Tấn công" mãi thì phải chuẩn bị quân lực', () {
    for (final id in ['b_quynhon', 'b_thinai']) {
      final def = battlesById[id]!;
      expect(run(def, smartPolicy).won, isTrue, reason: '$id: chơi khôn phải thắng dù quân lực thấp');
      expect(run(def, (_) => PlayerAction.attack).won, isFalse,
          reason: '$id: chỉ tấn công với quân lực thấp phải thua');
      expect(run(def, (_) => PlayerAction.attack, army: 40).won, isTrue,
          reason: '$id: chuẩn bị quân lực tốt thì thắng dễ');
    }
  });
}
