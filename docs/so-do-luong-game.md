# SƠ ĐỒ LUỒNG GAME

> File này được sinh tự động từ `lib/story/*.dart` — hình chữ nhật: cảnh truyện; hình thoi: trận đánh (⚔) / căn cứ (🏯); hình tròn: kết thúc. Nét đứt: nhánh khi thua trận.

## Tổng quan 6 Hồi

```mermaid
flowchart LR
  A1[Hồi 1<br/>Sụp Đổ 1777] --> A2[Hồi 2<br/>Bôn Ba 1777–87] --> A3[Hồi 3<br/>Phương Tây 1787]
  A3 --> A4[Hồi 4<br/>Tái chiếm Gia Định 1788] --> A5[Hồi 5<br/>Chiến Tây Sơn 1792–1801] --> A6[Hồi 6<br/>Thống Nhất 1802]
```

## Hồi 1 — Sụp Đổ Và Chạy Trốn

```mermaid
flowchart TD
  a1_start["Đêm Gia Định thất thủ"]
  a1_granary["Kho lương mở cửa"]
  a1_wait["Tin dữ từ Long Xuyên"]
  a1_breakout["Phá vây"]
  a1_river["Trạm gác trên sông"]
  a1_mangrove["Túp lều giữa rừng đước"]
  a1_dash["Vượt trạm gác"]
  a1_island["Đảo hoang"]
  a1_oath["Lời thề trên cát"]
  a1_start -->|"Theo đường sông trốn đi ngay trong đêm"| a1_river
  a1_start -->|"Ở lại chờ tin Định vương và viện binh"| a1_wait
  a1_start -->|"Mở kho lương phát cho dân rồi mới đi"| a1_granary
  a1_granary -->|"Theo cậu bé ra bến rạch"| a1_river
  a1_wait -->|"Nuốt nước mắt, lập tức rời thành"| a1_river
  a1_wait -->|"Dẫn vài trăm quân liều chết phá vây"| a1_breakout
  a1_breakout -->|"Xuống xuồng, xuôi theo kênh rạch"| a1_river
  a1_river -->|"Nấp trong rừng đước chờ trời tối"| a1_mangrove
  a1_river -->|"🔒 Lao xuồng vượt trạm gác đúng lúc địc…"| a1_dash
  a1_mangrove -->|"Nhận sự che chở của Bá Đa Lộc"| a1_island
  a1_mangrove -->|"Cảm ơn nhưng từ chối — tự tìm đường …"| a1_island
  a1_dash -->|"Hướng mũi xuồng ra đảo"| a1_island
  a1_island -->|"Chia đều từng bát gạo cho mọi người,…"| a1_oath
  a1_island -->|"Giữ phần gạo cho các tướng để còn sứ…"| a1_oath
  a1_oath -->|"Hồi 2 — Những Năm Bôn Ba"| a2_start
  a2_start["→ Trở lại Gia Định (Hồi 2)"]:::ext
  classDef ext stroke-dasharray: 4 3
```

## Hồi 2 — Những Năm Bôn Ba

```mermaid
flowchart TD
  a2_start["Trở lại Gia Định"]
  a2_court["Quyền thần"]
  a2_fall["Mất Gia Định lần nữa"]
  a2_retake["Vòng lặp được — mất"]
  a2_guerrilla["Rừng tràm U Minh"]
  a2_siam["Triều đình Xiêm La"]
  a2_siam_army["Đồng minh cướp bóc"]
  a2_siam_food["Viện binh không mời"]
  a2_rachgam{{"⚔ Sông Tiền"}}
  a2_rachgam_after["Mặt sông đỏ lửa"]
  a2_exile["Những năm lưu vong"]
  a2_end["Tin từ phương Tây"]
  a2_start -->|"Trọng dụng Đỗ Thanh Nhơn, giao thêm …"| a2_court
  a2_start -->|"Âm thầm phân tán bớt quyền của Nhơn"| a2_court
  a2_court -->|"Xử tử Đỗ Thanh Nhơn để giữ vương quyền"| a2_fall
  a2_court -->|"🔒 Triệu Nhơn vào, thẳng thắn phân định…"| a2_fall
  a2_fall -->|"Rút về Ba Giồng, gom góp tàn quân"| a2_retake
  a2_retake -->|"Cử người sang Xiêm La cầu viện"| a2_siam
  a2_retake -->|"Bám trụ đánh du kích trong rừng U Minh"| a2_guerrilla
  a2_guerrilla -->|"Lên thuyền sang Xiêm"| a2_siam
  a2_siam -->|"Nhận hai vạn quân Xiêm"| a2_siam_army
  a2_siam -->|"Chỉ xin lương thực, vũ khí — không đ…"| a2_siam_food
  a2_siam_army -->|"Nghiêm trị kẻ cướp bóc, dù mất lòng …"| a2_rachgam
  a2_siam_army -->|"Làm ngơ để giữ liên minh"| a2_rachgam
  a2_siam_food -->|"Theo đoàn quân tiến về Mỹ Tho"| a2_rachgam
  a2_rachgam -->|"thắng"| a2_rachgam_after
  a2_rachgam_after -->|"Sống lưu vong ở Xiêm"| a2_exile
  a2_exile -->|"Đem quân giúp Xiêm đánh Miến để trả ơn"| a2_end
  a2_exile -->|"Khéo léo từ chối, âm thầm tích trữ l…"| a2_end
  a2_end -->|"Hồi 3 — Liên Minh Với Phương Tây"| a3_start
  a3_start["→ Phong thư xi đỏ (Hồi 3)"]:::ext
  classDef ext stroke-dasharray: 4 3
```

## Hồi 3 — Liên Minh Với Phương Tây

```mermaid
flowchart TD
  a3_start["Phong thư xi đỏ"]
  a3_letter["Hiệp ước Versailles"]
  a3_view_bishop["Góc nhìn thứ nhất"]
  a3_view_scholar["Góc nhìn thứ hai"]
  a3_view_history["Góc nhìn thứ ba"]
  a3_court["Hiệp ước trên giấy"]
  a3_officers["Những người tình nguyện"]
  a3_prince["Hoàng tử trở về"]
  a3_end["Sức mình là chính"]
  a3_start -->|"Đọc tiếp bức thư"| a3_letter
  a3_letter -->|"Nghe thêm các ý kiến khác trước khi …"| a3_view_bishop
  a3_letter -->|"Chấp thuận các điều khoản — viện bin…"| a3_court
  a3_letter -->|"Viết thư đề nghị bớt các điều khoản …"| a3_court
  a3_view_bishop -->|"Hỏi ý các nho thần trong triều"| a3_view_scholar
  a3_view_scholar -->|"Suy ngẫm"| a3_view_history
  a3_view_history -->|"Quay lại bức thư"| a3_letter
  a3_court -->|"Đón tiếp các sĩ quan phương Tây, trọ…"| a3_officers
  a3_court -->|"Chỉ nhận vũ khí, cảm ơn và gửi họ về"| a3_prince
  a3_officers -->|"Giao Olivier thiết kế thành lũy kiên…"| a3_prince
  a3_officers -->|"Giao Dayot, Vannier huấn luyện thủy …"| a3_prince
  a3_prince -->|"Ôn tồn giảng giải cho con về đạo hiế…"| a3_end
  a3_prince -->|"Nghiêm khắc buộc con làm tròn lễ ngh…"| a3_end
  a3_end -->|"Hồi 4 — Tái Chiếm Gia Định"| a4_start
  a4_start["→ Thời cơ (Hồi 4)"]:::ext
  classDef ext stroke-dasharray: 4 3
```

## Hồi 4 — Tái Chiếm Gia Định

```mermaid
flowchart TD
  a4_start["Thời cơ"]
  a4_assault["Đêm công thành"]
  a4_negotiate["Vòng vây im lặng"]
  a4_retaken["Mười một năm"]
  a4_base{{"🏯 Xây dựng Gia Định"}}
  a4_after_base["Thành Bát Quái"]
  a4_end["Sét đánh ngang trời"]
  a4_start -->|"Đánh thẳng vào thành Gia Định khi đị…"| a4_assault
  a4_start -->|"🔒 Cắt đường tiếp tế, gửi thư chiêu dụ,…"| a4_negotiate
  a4_assault -->|"Tiến vào thành"| a4_retaken
  a4_negotiate -->|"Tiến vào thành"| a4_retaken
  a4_retaken -->|"Bắt tay xây dựng căn cứ"| a4_base
  a4_base --> a4_after_base
  a4_after_base -->|"Khoan hồng: cho tù binh gia nhập quâ…"| a4_end
  a4_after_base -->|"Xử nghiêm để răn đe kẻ còn chống đối"| a4_end
  a4_end -->|"Hồi 5 — Cuộc Chiến Với Tây Sơn"| a5_start
  a5_start["→ Triều Tây Sơn mục ruỗng (Hồi 5)"]:::ext
  classDef ext stroke-dasharray: 4 3
```

## Hồi 5 — Cuộc Chiến Với Tây Sơn

```mermaid
flowchart TD
  a5_start["Triều Tây Sơn mục ruỗng"]
  a5_spies["Mật thư từ Phú Xuân"]
  a5_campaign["Những mùa gió"]
  a5_quynhon{{"⚔ Hạ thành Quy Nhơn"}}
  a5_regroup_qn["Lui quân"]
  a5_quynhon_won["Mật thư của Võ Tánh"]
  a5_rescue["Vòng vây thép"]
  a5_thinai{{"⚔ Thủy chiến Thị Nại"}}
  a5_regroup_tn["Chờ con nước"]
  a5_phuxuan["Phú Xuân"]
  a5_end["Nhìn về phương Bắc"]
  a5_start -->|"Cài mật thám, khai thác mâu thuẫn nộ…"| a5_spies
  a5_start -->|"Dồn toàn lực Bắc tiến, không để địch…"| a5_campaign
  a5_spies -->|"Tung tin gây chia rẽ giữa các phe Tâ…"| a5_campaign
  a5_spies -->|"Mở rộng cửa chiêu hàng, trọng đãi ng…"| a5_campaign
  a5_campaign -->|"Dùng thủy quân phong tỏa cửa biển, c…"| a5_quynhon
  a5_campaign -->|"Để bộ binh vây chặt các ngả đường núi"| a5_quynhon
  a5_quynhon -->|"thắng"| a5_quynhon_won
  a5_quynhon -.->|"thua"| a5_regroup_qn
  a5_regroup_qn -->|"Chỉnh đốn và tấn công lần nữa"| a5_quynhon
  a5_quynhon_won -->|"Nghe theo Võ Tánh — dồn lực đánh Phú…"| a5_thinai
  a5_quynhon_won -->|"Không bỏ người trung thần — đem quân…"| a5_rescue
  a5_rescue -->|"Chuyển hướng: đánh thủy quân Tây Sơn…"| a5_thinai
  a5_thinai -->|"thắng"| a5_phuxuan
  a5_thinai -.->|"thua"| a5_regroup_tn
  a5_regroup_tn -->|"Chờ thủy triều lên và tấn công lần nữa"| a5_thinai
  a5_phuxuan -->|"Lập đàn tế các trung thần đã khuất"| a5_end
  a5_phuxuan -->|"Thề sẽ kết thúc chiến tranh thật nha…"| a5_end
  a5_end -->|"Hồi 6 — Thống Nhất Đất Nước"| a6_start
  a6_start["→ Niên hiệu Gia Long (Hồi 6)"]:::ext
  classDef ext stroke-dasharray: 4 3
```

## Hồi 6 — Thống Nhất Đất Nước

```mermaid
flowchart TD
  a6_start["Niên hiệu Gia Long"]
  a6_march["Đường ra Bắc"]
  a6_battle{{"⚔ Trận Thăng Long"}}
  a6_regroup["Trước cửa thành"]
  a6_victory["Cờ trên thành Thăng Long"]
  a6_epilogue(("Non sông thu về một mối"))
  a6_start -->|"Tiến quân ra Bắc Hà"| a6_march
  a6_march -->|"Ban lệnh hiểu dụ: quan lại cũ quy th…"| a6_battle
  a6_march -->|"Tiến quân thần tốc, không dừng lại đ…"| a6_battle
  a6_battle -->|"thắng"| a6_victory
  a6_battle -.->|"thua"| a6_regroup
  a6_regroup -->|"Tập hợp lại và tổng công kích"| a6_battle
  a6_victory -->|"Khoan dung — kết thúc hận thù, tha c…"| a6_epilogue
  a6_victory -->|"Trừng trị theo luật đương thời — báo…"| a6_epilogue
  classDef ext stroke-dasharray: 4 3
```
