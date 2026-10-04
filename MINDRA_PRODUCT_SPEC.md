# Đặc tả sản phẩm Mindra

Phiên bản: 2.0  
Trạng thái: Định hướng sản phẩm MVP+  
Nền tảng: iOS  
Ngôn ngữ chính: Giao diện tiếng Việt, sẵn sàng bản địa hóa  
Người dùng mục tiêu: Người trưởng thành 18-35 tuổi muốn hiểu cảm xúc và giảm căng thẳng hằng ngày.

## 1. Tổng quan sản phẩm

Mindra là ứng dụng riêng tư hỗ trợ người dùng phản tư cảm xúc bằng AI. Ứng dụng giúp người dùng nhận biết mình đang cảm thấy gì, hiểu mối liên hệ giữa tình huống, suy nghĩ, cảm xúc và hành vi, rồi chọn một hành động nhỏ tiếp theo.

Cam kết cốt lõi:

> Hiểu cảm xúc. Chủ động chọn cách phản hồi.

Vòng lặp cốt lõi:

```text
Check-in -> Phản tư có hướng dẫn -> Hành động nhỏ hoặc bài tập ngắn -> Follow-up -> Insight
```

Mindra phục vụ việc tự nhận thức và quản lý căng thẳng hằng ngày. Ứng dụng không phải công cụ chẩn đoán, nhà trị liệu, dịch vụ khủng hoảng hay phương án thay thế chăm sóc chuyên môn.

## 2. Nguyên tắc sản phẩm

1. **Phản tư trước lời khuyên**: thu thập bối cảnh trước khi đề xuất bài tập.
2. **Người dùng là người quyết định**: gợi ý AI mang tính xác suất và có thể chỉnh sửa.
3. **Có cơ sở tâm lý, không mang tính lâm sàng**: dùng phản tư lấy cảm hứng từ CBT, grounding và self-compassion nhưng không chẩn đoán.
4. **Hành động nhỏ**: phần lớn phiên sử dụng chỉ nên mất 1-5 phút.
5. **Riêng tư theo mặc định**: tối thiểu hóa dữ liệu, giải thích việc xử lý bằng AI, hỗ trợ xuất và xóa dữ liệu.
6. **Tạo động lực nhẹ nhàng**: streak và huy hiệu ghi nhận sự đều đặn, không phạt người dùng bỏ ngày.
7. **Đa dạng nhưng không gây nhiễu**: ứng dụng có thể thay đổi prompt và điểm bắt đầu nhưng vẫn giữ mô hình sử dụng ổn định.
8. **Ngôn ngữ dễ tiếp cận**: bình tĩnh, trực tiếp, không phán xét, phù hợp người trưởng thành và có thể thích ứng văn hóa.

## 3. Phạm vi

### Các tầng phát hành

Sản phẩm được chia thành các tầng có chủ đích để bản phát hành đầu tiên vẫn dễ kiểm thử, đồng thời trải nghiệm có thể phát triển vượt khỏi việc ghi mood lặp lại.

#### P0 - MVP cốt lõi

- Onboarding và chọn mục tiêu.
- Quick Check-in (cảm xúc + cường độ, dưới 30 giây).
- Full Check-in (tình huống, tác nhân, suy nghĩ và phản ứng).
- Pause Mode cho lúc người dùng quá tải và không muốn viết.
- Phản tư có cấu trúc lấy cảm hứng từ CBT.
- AI phân tích cảm xúc, tác nhân, suy nghĩ và bước tiếp theo, kèm giải thích lý do đề xuất.
- Phản hồi của người dùng về gợi ý AI: đúng, chỉnh sửa hoặc chưa phù hợp.
- Bốn bài tập ngắn.
- So sánh mood trước và sau.
- Một micro-goal hoặc kế hoạch ý định sau phiên phản tư.
- Check-in theo dõi xem người dùng đã thử hành động chưa.
- Lịch cảm xúc theo tháng và chi tiết từng ngày.
- Tiến trình theo tuần và weekly review có hướng dẫn.
- Streak nhẹ nhàng và bốn huy hiệu.
- Nhắc nhở, khóa Face ID, kiểm soát riêng tư, xuất/xóa dữ liệu.
- Luồng hỗ trợ an toàn theo cấp độ khi có nội dung nguy hiểm.

#### P1 - Lớp duy trì và insight

- Daily Prompt và Weekly Theme luân phiên.
- Bộ chọn chế độ: Gọi tên, Trút ra, Hiểu rõ, Reset hoặc Lên bước tiếp.
- Pattern Explorer hiển thị thận trọng mối liên hệ giữa cảm xúc, tác nhân, thời gian và bài tập.
- Prompt Memory Lane gợi lại entry cũ khi phù hợp.
- Reflection Remix với các góc nhìn như “điều mình có thể kiểm soát” hoặc “điều mình có thể đang cần”.
- Phản hồi sau bài tập để cải thiện đề xuất về sau.

#### P2 - Lớp khám phá tùy chọn

- Personal Experiments: kiểm thử một giả thuyết nhỏ qua nhiều lần check-in.
- Mindra Garden, không gian hình ảnh riêng tư phát triển theo các hành động có ý nghĩa.
- Prompt, biến thể bài tập và theme hình ảnh có thể mở khóa.

P1 và P2 không được cản trở luồng check-in cốt lõi và có thể tắt trong chế độ giảm kích thích.

### Chủ động nằm ngoài phạm vi MVP

- Chatbot trị liệu mở.
- Chẩn đoán trầm cảm, lo âu hoặc bất kỳ tình trạng nào khác.
- Tuyên bố về điều trị y khoa.
- Marketplace nhà trị liệu hoặc tư vấn trực tiếp.
- Cộng đồng xã hội hoặc bảng xếp hạng.
- Nhật ký giọng nói, Apple Health, Apple Watch, cảm biến wearable.
- Subscription/thanh toán.
- Hàng trăm bài học hoặc quá nhiều hành trình riêng biệt.
- Nhận diện cảm xúc bằng khuôn mặt, giọng nói hoặc sinh trắc học.
- Kinh tế điểm cạnh tranh, bảng xếp hạng, hồ sơ công khai hoặc chia sẻ xã hội.
- Cơ chế game phạt việc bỏ ngày hoặc khiến người dùng cảm thấy mình thất bại về sức khỏe tinh thần.

## 4. Chân dung người dùng và nhu cầu cần giải quyết

Chân dung chính: người trưởng thành 18-35 tuổi đang xử lý công việc, học tập, các mối quan hệ và sự bất định hằng ngày. Họ có ít thời gian, coi trọng riêng tư và thường biết mình không ổn nhưng khó gọi tên điều đang xảy ra hoặc bước tiếp theo.

Nhu cầu:

- “Giúp tôi gọi tên cảm xúc của mình.”
- “Giúp tôi hiểu điều gì kích hoạt phản ứng của tôi.”
- “Giúp tôi dừng lại trước khi phản hồi bốc đồng.”
- “Cho tôi một bài tập thực tế có thể làm ngay.”
- “Giúp tôi nhìn thấy pattern mà không phán xét.”
- “Cho tôi một bước hữu ích khi tôi không đủ năng lượng để viết.”
- “Giúp tôi nhận ra một thay đổi nhỏ có thực sự hiệu quả theo thời gian hay không.”

## 5. Mô hình tâm lý

Mô hình phản tư chính lấy cảm hứng từ CBT:

```text
Tình huống -> Suy nghĩ tự động -> Cảm xúc và cường độ -> Hành vi/Phản ứng -> Kết quả
```

Ứng dụng cũng có thể sử dụng:

- Nhận biết cảm xúc: gọi tên và chấm mức độ cảm xúc.
- Tái cấu trúc nhận thức: xem xét bằng chứng và tạo một suy nghĩ cân bằng.
- Grounding và thở: giảm mức kích hoạt tức thời.
- Self-compassion: đối xử với bản thân như với một người bạn thân.
- Tự theo dõi: so sánh pattern theo thời gian và mood trước/sau bài tập.
- Implementation intention: nối một tình huống tương lai với phản ứng cụ thể bằng kế hoạch “Nếu... thì...”.
- Nguyên tắc kích hoạt hành vi ở dạng phi lâm sàng: đề xuất một hành động nhỏ, khả thi thay vì danh sách nhiệm vụ lớn.

Sử dụng “có thể”, “khả năng là” và “một cách diễn giải có thể”. Không bao giờ trình bày suy luận như chẩn đoán hoặc sự thật chắc chắn.

## 6. Kiến trúc thông tin

Thanh điều hướng dưới có bốn tab:

1. **Trang chủ**: hành động trong ngày, chế độ hiện tại, trạng thái check-in, micro-goal, streak và bài tập đề xuất.
2. **Lịch**: lịch sử theo tháng, chi tiết ngày, bộ lọc.
3. **Khám phá**: weekly review, pattern, experiment, thay đổi trước/sau và huy hiệu.
4. **Cài đặt**: nhắc nhở, riêng tư, đồng ý dùng AI, kiểm soát dữ liệu và thông tin an toàn.

CTA chính là `Check in` trên Trang chủ. Điểm bắt đầu phụ là `Pause Mode`.

## 7. Danh sách màn hình và luồng

### S01 Chào mừng

Mục đích: giới thiệu thương hiệu và cam kết sản phẩm.

Nội dung:

```text
Mindra
Hiểu cảm xúc. Chủ động chọn cách phản hồi.
Không gian riêng tư để phản tư cảm xúc, hiểu pattern và giảm căng thẳng hằng ngày.
Bắt đầu
Mindra hoạt động như thế nào?
```

Hành động: Bắt đầu -> S02. Tìm hiểu thêm -> giải thích ngắn về sản phẩm.

### S02 Chọn mục tiêu

Prompt: “Bạn muốn tập trung vào điều gì?”

Tùy chọn:

- Hiểu cảm xúc của tôi.
- Giảm căng thẳng hằng ngày.
- Phản hồi bình tĩnh hơn.
- Xây dựng khả năng nhận biết cảm xúc.

Lưu một hoặc nhiều mục tiêu. Tiếp tục -> S03.

### S03 Cài đặt nhắc nhở

Tùy chọn: Buổi sáng, Buổi chiều, Buổi tối, giờ tùy chỉnh, Không nhắc.

Lưu lựa chọn nhắc nhở. Tiếp tục -> S04.

### S04 Giới thiệu an toàn

Hiển thị:

```text
Mindra hỗ trợ tự phản tư và quản lý căng thẳng hằng ngày.
Ứng dụng không chẩn đoán tình trạng sức khỏe tinh thần, không cung cấp trị liệu và không thay thế hỗ trợ chuyên môn.
Các nội dung phản tư thuộc về bạn.
```

Hành động: Tôi hiểu -> S05. Chi tiết riêng tư -> S20.

### S05 Trang chủ

Hiển thị lời chào, trạng thái check-in hôm nay, streak hiện tại, số ngày check-in trong tuần, bài tập đề xuất và phản tư gần nhất.

Hiển thị một Daily Prompt hoặc Weekly Theme hiện tại khi có. Prompt là tùy chọn và không bao giờ được thay thế hành động check-in chính.

Khu vực bắt đầu chính cung cấp năm chế độ nhẹ. Chế độ được chọn chỉ thay đổi câu hỏi đầu tiên, không thay đổi data model bên dưới:

- **Gọi tên**: xác định cảm xúc và cường độ.
- **Trút ra**: viết một câu mà không cần phân tích.
- **Hiểu rõ**: hoàn thành luồng Tình huống -> Suy nghĩ -> Cảm xúc -> Phản ứng.
- **Reset**: mở Pause Mode ngay.
- **Lên bước tiếp**: xem lại micro-goal hoặc follow-up đang mở.

Hành động chính: `Check in` -> S06.

Hành động phụ: `Pause Mode` -> S06-P.

Trạng thái trống: giải thích rằng một lần check-in mất chưa đến một phút.

### S06 Check-in cảm xúc

Hỗ trợ hai hướng:

- **Quick Check-in**: chọn một cảm xúc chính và cường độ 1-5 rồi lưu.
- **Full Check-in**: tiếp tục đến tình huống và tác nhân, sau đó là suy nghĩ và phản ứng.

Các cảm xúc mặc định:

- Bình tĩnh, Vui, Buồn, Tức giận, Lo lắng, Căng thẳng, Xấu hổ, Mệt mỏi.

“Thêm cảm xúc” có thể mở một tập từ vựng có kiểm soát lớn hơn, nhưng MVP không bắt buộc nhập tên cảm xúc tự do.

Quick Check-in lưu về Trang chủ sau khi xác nhận cảm xúc và cường độ. Full Check-in -> S07.

### S06-P Pause Mode

Pause Mode là luồng có tải nhận thức thấp dành cho người dùng đang quá tải hoặc không muốn viết.

1. Dừng lại và nhận biết một cảm giác trong cơ thể.
2. Thực hiện một nhịp thở có hướng dẫn hoặc chọn “bỏ qua thở”.
3. Gọi tên cảm xúc gần nhất, hoặc chọn “Tôi không chắc”.
4. Chọn một hành động tiếp theo: nghỉ một chút, nhờ hỗ trợ, tiếp tục sau, hoặc quay lại full check-in.

Pause Mode chỉ lưu những gì người dùng xác nhận. Không được hàm ý rằng một nhịp thở có thể giải quyết tình huống.

### S07 Tình huống và tác nhân

Thu thập:

- Tình huống: “Điều gì đã xảy ra?”
- Nhóm tác nhân: Công việc hoặc học tập, Mối quan hệ, Gia đình, Tiền bạc, Sức khỏe, Tình huống xã hội, Bất định, Khác.
- Công tắc tùy chọn “Cảm giác này từng xảy ra trước đây”.

Tiếp tục -> S08. Có thể bỏ qua.

### S08 Suy nghĩ và phản ứng

Thu thập:

- Suy nghĩ tự động: “Điều gì đã lướt qua tâm trí bạn?”
- Hành vi/phản ứng: “Sau đó bạn đã làm gì?”

Các trường này có thể bỏ qua trong check-in nhanh, nhưng cần có cho phản tư AI đầy đủ.

Tiếp tục -> S09.

### S09 Đang tạo phản tư bằng AI

Giải thích rằng Mindra đang tạo các prompt phản tư có thể phù hợp. Không bao giờ hàm ý sự chắc chắn lâm sàng.

Nếu AI lỗi, hiển thị trạng thái S09-E và vẫn giữ check-in đã lưu.

### S10 Kết quả phản tư AI

Hiển thị:

- Các cảm xúc có thể có.
- Tác nhân có thể có.
- Suy nghĩ có thể làm cảm xúc mạnh hơn.
- Một câu hỏi phản tư.
- Một suy nghĩ thay thế cân bằng hơn.
- Bài tập được đề xuất.
- Giải thích bằng ngôn ngữ đơn giản về lý do đề xuất bài tập.

Hành động:

- Điều này đúng với tôi.
- Chỉnh sửa phản tư.
- Chưa phù hợp.
- Yêu cầu phiên bản ngắn hơn hoặc nhẹ nhàng hơn.
- Tiếp tục.

Mọi trường AI phải có thể chỉnh sửa hoặc loại bỏ. Tiếp tục -> S11.

### S11 Đề xuất bước tiếp theo

Đề xuất đúng một bước tiếp theo dựa trên phiên phản tư. Bước tiếp theo có thể là một bài tập hoặc một hành động nhỏ. Giải thích đề xuất trong một câu.

Ví dụ:

- Bài tập: “Thử Response Pause vì tình huống có vẻ gấp và bạn chưa quyết định cách phản hồi.”
- Micro-goal: “Trước tin nhắn tiếp theo, hãy dừng 30 giây và gọi tên điều bạn cần.”

Cho phép `Chọn bài tập khác`, `Tạo micro-goal` và `Bỏ qua lúc này`.

### S11-G Micro-goal và kế hoạch follow-up

Người dùng có thể lưu một kế hoạch cụ thể, không bắt buộc:

```text
Khi [tình huống] xảy ra, tôi sẽ [hành động nhỏ] vì [giá trị hoặc nhu cầu].
```

Kế hoạch hỗ trợ khung thời gian như hôm nay, tuần này hoặc không nhắc. Ứng dụng hỏi follow-up sau đó nhưng không coi việc chưa hoàn thành kế hoạch là thất bại.

### S12 Chi tiết bài tập

Chạy một trong bốn bài tập:

1. **Grounding**: định hướng giác quan 5-4-3-2-1, khoảng 2 phút.
2. **Thought Reframing**: suy nghĩ, bằng chứng ủng hộ, bằng chứng phản biện, góc nhìn của người bạn, suy nghĩ cân bằng, khoảng 3 phút.
3. **Self-Compassion**: viết điều bạn sẽ nói với một người bạn rồi dành lời đó cho chính mình, khoảng 2 phút.
4. **Response Pause**: dừng lại, thở, gọi tên cảm xúc, xác định điều quan trọng và chọn hành động tiếp theo, khoảng 1 phút.

Hiển thị tiêu đề, mục đích, thời lượng, bộ đếm bước, chỉ báo tiến độ, Tiếp tục, Thoát và placeholder âm thanh tùy chọn. Âm thanh không bắt buộc trong MVP.

### S13 Hoàn thành bài tập

Xác nhận tên và thời lượng bài tập. Hành động: Check-in lại -> S14; Xem phản tư; Xong -> S05.

### S14 Check-in mood sau bài tập

Thu thập cảm xúc hiện tại và cường độ 1-5. Hiển thị so sánh trước/sau ở giọng điệu trung tính.

Ví dụ:

```text
Trước: Căng thẳng 4/5
Sau: Căng thẳng 3/5
Một thay đổi nhỏ cũng đáng ghi nhận.
```

Lưu một ExerciseSession. Không bao giờ tuyên bố bài tập đã chữa khỏi hoặc giải quyết căng thẳng.

Sau khi lưu, hỏi phản hồi tùy chọn:

- Điều này có hữu ích không?
- Bài tập có đủ dễ để thực hiện không?
- Bạn có muốn dùng lại không?

Phản hồi ảnh hưởng đến thứ tự đề xuất về sau nhưng không thay đổi mood đã lưu trước đó.

### S15 Lịch theo tháng

Mỗi ngày hiển thị màu/icon mood và số lượng tùy chọn nếu có nhiều entry. Chạm vào một ngày -> S16. Hỗ trợ chuyển tháng và Thêm check-in.

Màu không được là cách mã hóa duy nhất; cần có nhãn/icon để hỗ trợ khả năng tiếp cận.

### S16 Chi tiết ngày

Hiển thị các entry của ngày đã chọn: mood/cường độ chính, tác nhân, tình huống, suy nghĩ, phản ứng, phản tư AI, phiên bài tập và mood sau bài tập nếu có.

Hành động: Sửa, Xóa, Thêm check-in, Làm lại bài tập.

### S17 Tiến trình theo tuần

Hiển thị:

- Số ngày check-in trên tổng 7 ngày.
- Cảm xúc xuất hiện nhiều nhất.
- Tác nhân phổ biến nhất.
- Cường độ trung bình.
- Số bài tập đã hoàn thành.
- So sánh trước/sau bài tập khi có đủ dữ liệu.
- Một hoặc hai card “Pattern nhận thấy” ở dạng phi lâm sàng.
- Prompt phản tư hằng tuần.
- Micro-goal đang mở và tình trạng follow-up.
- Tổng hợp phản hồi recommendation khi có đủ dữ liệu.

Ví dụ pattern: “Căng thẳng liên quan đến công việc xuất hiện 3 lần trong tuần này.”

Ngôn ngữ pattern phải thận trọng: “Điều này xuất hiện 3 lần” hoặc “Bạn có thể muốn khám phá thêm...” thay vì khẳng định quan hệ nhân quả hoặc chẩn đoán.

### S17-P Khám phá pattern (Pattern Explorer)

Pattern Explorer cho phép người dùng chọn khoảng thời gian và xem từng mối liên hệ một:

- Cảm xúc theo nhóm tác nhân.
- Cường độ trung bình theo ngày hoặc khung giờ.
- Bài tập và mức hữu ích do người dùng tự đánh giá.
- Số lần thử micro-goal và phản hồi follow-up.

Mỗi view phải hiển thị kích thước mẫu và lưu ý bằng ngôn ngữ đơn giản khi chưa đủ dữ liệu. Không suy luận quan hệ nhân quả từ tương quan.

### S17-W Đánh giá tuần (Weekly Review)

Weekly review là phiên phản tư ba bước:

1. Điều gì xuất hiện nhiều nhất?
2. Điều gì đã giúp bạn, dù chỉ một chút?
3. Tuần tới bạn muốn thử điều gì?

Người dùng có thể lưu, sửa hoặc bỏ qua review. Một review đã lưu chỉ được tính vào Mindra Garden như một hành động có ý nghĩa tùy chọn.

### S17-M Prompt và Nhìn lại (Memory Lane)

Daily Prompt và Weekly Theme luân phiên điểm bắt đầu mà không thay đổi data model cốt lõi. Memory Lane chỉ gợi lại entry cũ khi người dùng chủ động đồng ý xem lại.

Ví dụ:

- “Một tháng trước bạn từng ghi lại tình huống tương tự. Bây giờ có điều gì khác không?”
- “Chủ đề tuần này là phản hồi chậm hơn. Bạn có thể thử điều đó ở đâu?”

Người dùng có thể bỏ qua, tạm hoãn hoặc tắt các prompt này.

### S17-X Thí nghiệm cá nhân (Personal Experiment, P2)

Người dùng có thể đặt một giả thuyết nhỏ, phi lâm sàng và thử trong khoảng thời gian giới hạn:

```text
Nếu tôi [hành động nhỏ] khi [tình huống], tôi muốn quan sát xem [thay đổi có thể nhận biết] hay không.
```

Experiment liên kết các check-in liên quan và tạo một bản tổng hợp thận trọng. Bản tổng hợp phải nói rõ khi chưa đủ dữ liệu và không được trình bày experiment cá nhân như bằng chứng khoa học.

### S18 Huy hiệu

Huy hiệu MVP:

- Phản tư đầu tiên: hoàn thành check-in đầu tiên.
- Có mặt ba ngày: check-in trong 3 ngày.
- Một tuần nhận biết: check-in trong 7 ngày.
- Thử công cụ mới: hoàn thành bài tập đầu tiên.

Không có bảng xếp hạng, điểm cạnh tranh hoặc reset streak mang tính trừng phạt.

### S18-G Khu vườn Mindra (Mindra Garden)

Khu vườn là không gian riêng tư giữ những khoảnh khắc người dùng muốn nhớ. Nhật ký lưu những gì đã ghi nhận; khu vườn giữ những gì được chọn giữ lại.

- Sau check-in, người dùng có thể trồng một bông hoa từ entry đó. Không bắt buộc.
- Mỗi hoa gắn một entry. Nội dung hoa lấy từ tình huống hoặc suy nghĩ; không tự viết lời kể.
- Hoa thuộc tháng của entry. Tối đa 20 hoa mỗi luống; hoa thứ 21 mở luống mới trong cùng tháng.
- Vị trí hoa cố định. Thêm hoặc bỏ hoa không sắp xếp lại các hoa khác.
- Bỏ hoa khỏi vườn không xóa entry. Xóa entry thì xóa hoa liên quan.
- Bỏ một ngày không xóa hoặc làm hỏng khu vườn.
- Không có điểm số, so sánh công khai hay hình phạt vì nghỉ.

### S19 Cài đặt

Các mục: tùy chọn chế độ bắt đầu, giờ nhắc, thông báo, mục tiêu, Face ID, đồng ý dùng AI, chế độ giảm kích thích, hiển thị Garden, xuất dữ liệu, xóa dữ liệu, Giới thiệu, riêng tư, điều khoản, hỗ trợ và nguồn lực an toàn.

### S20 Riêng tư và dữ liệu

Giải thích dữ liệu nào được lưu cục bộ, dữ liệu nào được gửi để xử lý bằng AI, thời gian lưu giữ, cách xóa và xuất dữ liệu. Việc xử lý bằng AI phải do người dùng chủ động bật hoặc đồng ý rõ ràng.

### S21 Hỗ trợ an toàn

Nếu nội dung có khả năng liên quan đến tự làm hại bản thân, làm hại người khác hoặc nguy hiểm tức thời, dừng luồng phản tư thông thường và hiển thị hướng dẫn hỗ trợ khủng hoảng. Cung cấp liên hệ người tin tưởng và nguồn hỗ trợ khẩn cấp tại địa phương. Không chẩn đoán, tranh luận hoặc tiếp tục game hóa.

## 8. Hợp đồng AI

### Dữ liệu đầu vào

Chỉ gửi phần văn bản và trường có cấu trúc tối thiểu cần thiết:

```json
{
  "emotion": "stressed",
  "intensity": 4,
  "trigger": "work_or_study",
  "situation": "string|null",
  "thought": "string|null",
  "response": "string|null",
  "entry_mode": "quick|full|pause|plan_next",
  "locale": "vi"
}
```

Không gửi tên, email, danh bạ, vị trí chính xác hoặc dữ liệu cá nhân không liên quan.

### Dữ liệu đầu ra

```json
{
  "possible_emotions": [
    {"name": "embarrassed", "confidence": 0.61},
    {"name": "stressed", "confidence": 0.82}
  ],
  "possible_trigger": "performance_feedback",
  "intensifying_thought": "Tôi không đủ tốt.",
  "reflection_question": "Ngoài năng lực tổng thể của bạn, còn cách giải thích nào khác cho feedback này không?",
  "balanced_thought": "Feedback này mô tả một khoảnh khắc, không phải toàn bộ năng lực của tôi.",
  "recommended_exercise": "thought_reframing",
  "recommended_action": null,
  "recommendation_reason": "Tình huống có vẻ gấp và bạn chưa quyết định cách phản hồi.",
  "micro_goal_prompt": "Khi nhận feedback, tôi sẽ dừng 30 giây trước khi trả lời.",
  "safety_flag": false,
  "safety_reason": null
}
```

Backend phải kiểm tra schema, giới hạn confidence trong khoảng 0-1, từ chối exercise ID không được hỗ trợ và cung cấp fallback an toàn khi thiếu trường. Backend không bao giờ được trả về chẩn đoán, tuyên bố điều trị hoặc quan hệ nhân quả chắc chắn. Feedback về recommendation được lưu tách khỏi mood entry để người dùng có thể không đồng ý mà không phải viết lại lịch sử.

### Chính sách ngôn ngữ AI

Được phép: “Bạn có thể đang cảm thấy...”, “Điều này có thể liên quan đến...”, “Một cách diễn giải có thể là...”.

Cấm: “Bạn bị lo âu”, “Bạn đang trầm cảm”, chẩn đoán, tư vấn thuốc, khẳng định về sang chấn hoặc tuyên bố về hiệu quả điều trị.

## 9. Mô hình dữ liệu

```text
User
- id
- createdAt
- goals[]
- reminderTime|null
- notificationsEnabled
- faceIdEnabled
- aiConsent
- lowStimulationMode
- gardenVisible
- preferredEntryMode

MoodEntry
- id
- userId
- createdAt
- localDate
- primaryMood
- intensity (1-5)
- triggerCategory|null
- situationText|null
- thoughtText|null
- responseText|null
- entryMode (quick|full|pause|plan_next)
- aiReflectionId|null
- deletedAt|null

AIReflection
- id
- moodEntryId
- possibleEmotions[]
- possibleTrigger|null
- intensifyingThought|null
- reflectionQuestion
- balancedThought|null
- recommendedExerciseId|null
- recommendedAction|null
- recommendationReason|null
- microGoalPrompt|null
- userFeedback (accurate|edited|not_quite_right|null)
- createdAt

Exercise
- id
- type (grounding|reframing|self_compassion|response_pause)
- title
- description
- durationSeconds
- steps[]

ExerciseSession
- id
- moodEntryId
- exerciseId
- startedAt
- completedAt|null
- preMood
- preIntensity
- postMood|null
- postIntensity|null
- usefulnessRating (1-5|null)
- easeRating (1-5|null)
- repeatPreference (yes|no|null)

MicroGoal
- id
- userId
- sourceMoodEntryId|null
- triggerText
- actionText
- valueText|null
- dueWindow (today|this_week|none)
- reminderAt|null
- status (open|attempted|completed|skipped)
- followUpNote|null
- createdAt
- completedAt|null

Prompt
- id
- type (daily|weekly|memory_lane|remix)
- text
- theme|null
- activeFrom
- activeUntil

PersonalExperiment
- id
- userId
- hypothesisText
- actionText
- durationDays
- status (draft|active|complete|stopped)
- checkInIds[]
- resultSummary|null
- createdAt
- completedAt|null

GardenState
- userId
- level
- unlockedItems[]
- lastMeaningfulActionAt

Progress
- currentStreak
- longestStreak
- totalCheckInDays
- totalExercisesCompleted
- lastCheckInDate

Badge
- id
- unlockedAt|null
```

## 10. Yêu cầu về trạng thái và lỗi

Mọi màn hình tải hoặc lưu dữ liệu cần có trạng thái: đang tải, thành công, trống, lỗi, offline và thử lại khi phù hợp.

Lỗi AI:

```text
Hiện chưa thể hoàn thành phản tư.
Check-in của bạn vẫn đã được lưu. Hãy thử lại hoặc tiếp tục không dùng AI.
```

Khi offline: cho phép check-in và hoàn thành bài tập cục bộ. Xếp hàng xử lý AI đến khi online hoặc cho phép người dùng tiếp tục không dùng AI.

Khi xóa: yêu cầu xác nhận rõ ràng và nói cụ thể rằng thao tác xóa không thể hoàn tác.

## 11. Nguyên tắc game hóa

- Tính một ngày khi người dùng hoàn thành ít nhất một check-in.
- Hiển thị streak hiện tại, tổng số ngày check-in và streak dài nhất.
- Streak là lời khích lệ, không phải điểm sức khỏe.
- Không khiến người dùng xấu hổ khi bỏ một ngày.
- Tránh bảng xếp hạng, thứ hạng, nền kinh tế điểm và animation quá mức.
- Sự phát triển của Garden mang tính biểu tượng và gắn với hành động có ý nghĩa, không phải số phiên thô.
- Bỏ một ngày không bao giờ xóa tiến trình hoặc làm hỏng khu vườn.
- Có thể ẩn các yếu tố game bằng chế độ giảm kích thích.

## 12. Yêu cầu accessibility và UX

- Hỗ trợ Dynamic Type và xuống dòng văn bản.
- Kích thước vùng chạm tối thiểu phải thoải mái.
- Có nhãn VoiceOver cho cảm xúc, ô lịch, slider và icon.
- Không truyền đạt mood chỉ bằng màu sắc.
- Không phụ thuộc vào animation hoặc âm thanh để truyền đạt ý nghĩa.
- Giữ hành động chính hiển thị rõ và dễ đoán.
- Dùng ngôn ngữ đơn giản và đoạn văn ngắn.
- Giữ nội dung nhạy cảm riêng tư và dễ xóa.

## 13. Tiêu chí nghiệm thu MVP

MVP được xem là hoàn thành khi người dùng thử có thể:

1. Hoàn thành onboarding và chọn mục tiêu.
2. Hoàn thành một check-in trong dưới hai phút.
3. Lưu tình huống, suy nghĩ, cảm xúc và phản ứng.
4. Nhận phản tư AI có cấu trúc hoặc fallback an toàn.
5. Chỉnh sửa hoặc từ chối gợi ý AI.
6. Hoàn thành một trong bốn bài tập.
7. Ghi nhận mood sau bài tập.
8. Nhìn thấy entry trên lịch tháng.
9. Mở chi tiết ngày và sửa/xóa entry.
10. Xem pattern và tiến trình theo tuần.
11. Nhận một huy hiệu và thấy streak.
12. Thay đổi nhắc nhở và cài đặt riêng tư.
13. Xóa dữ liệu cá nhân.
14. Mở được hỗ trợ an toàn khi luồng an toàn được kích hoạt.

Định hướng MVP+ được xác thực khi người dùng thử cũng có thể:

15. Hoàn thành Quick Check-in, Full Check-in hoặc Pause Mode mà không bị nhầm lẫn.
16. Tạo một micro-goal và ghi nhận follow-up không mang tính trừng phạt.
17. Hiểu vì sao bài tập hoặc hành động được AI đề xuất và gửi phản hồi.
18. Hoàn thành weekly review và đọc ít nhất một insight pattern thận trọng.
19. Tắt chế độ giảm kích thích và các yếu tố game mà không mất chức năng cốt lõi.

## 14. Ưu tiên và đo lường

### Chỉ số sức khỏe sản phẩm

- Tỷ lệ hoàn thành Quick Check-in và thời gian hoàn thành trung vị.
- Tỷ lệ hoàn thành Full Check-in mà không bỏ dở ở từng bước.
- Tỷ lệ hoàn thành Pause Mode và tỷ lệ quay lại luồng.
- Tỷ lệ recommendation AI nhận được feedback rõ ràng.
- Tỷ lệ tạo micro-goal và phản hồi follow-up.
- Tỷ lệ hoàn thành weekly review.
- Điểm hữu ích và độ dễ của bài tập.
- Tỷ lệ người dùng có thể giải thích dữ liệu được lưu ở đâu và cách xóa dữ liệu.

Các chỉ số dùng để học hỏi và cải thiện sản phẩm, không dùng để đánh giá sức khỏe tinh thần hoặc mức độ tuân thủ của người dùng.

### Câu hỏi nghiên cứu

- Nhiều chế độ bắt đầu có làm giảm trở ngại khi bắt đầu check-in không?
- Giải thích recommendation có làm tăng niềm tin vào AI không?
- Micro-goal có tạo follow-up có ý nghĩa hơn so với chỉ dùng streak không?
- Người dùng có hiểu ngôn ngữ pattern mà không diễn giải nó thành chẩn đoán không?
- Mindra Garden có tạo động lực mà không khiến việc bỏ ngày mang cảm giác bị phạt không?

## 15. Mở rộng tương lai

Sau khi xác thực MVP, các hướng nghiên cứu/sản phẩm có thể mở rộng gồm:

- Bộ ngữ cảnh bổ sung: mối quan hệ, kiệt sức công việc, giấc ngủ, sự tự tin.
- Phiên bản bài tập có hướng dẫn bằng âm thanh.
- Công cụ đánh giá có cơ sở bằng chứng và được giám sát học thuật phê duyệt.
- Nghiên cứu dọc về mood và phản ứng với can thiệp.
- Báo cáo dành cho nhà trị liệu với sự đồng ý rõ ràng của người dùng.
- Recommendation cá nhân hóa dựa trên feedback đã được xác nhận.
- Tích hợp Apple Health hoặc wearable chỉ sau khi đánh giá riêng tư.

## 16. Tóm tắt bàn giao một câu

> Xây dựng Mindra như một ứng dụng iOS riêng tư cho người trưởng thành 18-35 tuổi: người dùng có thể nhanh chóng gọi tên cảm xúc, dừng lại khi quá tải hoặc hoàn thành phản tư có cấu trúc; họ nhận được gợi ý lấy cảm hứng từ CBT có thể chỉnh sửa và giải thích được, chọn một hành động nhỏ hoặc bài tập, xem lại pattern follow-up và tùy chọn phát triển một khu vườn biểu tượng riêng tư; ứng dụng phải phi lâm sàng, ưu tiên riêng tư, nhẹ nhàng, đa dạng và không bao giờ mang tính trừng phạt.
