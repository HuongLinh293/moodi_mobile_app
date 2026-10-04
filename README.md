# Mindra – bản mẫu iOS (HTML/CSS/JS thuần)

Mở `index.html` bằng trình duyệt là chạy được, không cần cài đặt hay build.
Cần kết nối mạng để tải phông Be Vietnam Pro và Newsreader từ Google Fonts.

## Cấu trúc

| File | Nội dung |
|---|---|
| `index.html` | Khung trang: thiết bị iPhone, bảng chuyển màn hình, nạp CSS và JS |
| `style.css` | Design token (màu, phông), giao diện phần ứng dụng và bảng điều khiển |
| `js/data.js` | Dữ liệu và logic: cảm xúc, khuôn mặt SVG, biểu tượng, bài tập, sinh phản tư, dữ liệu mẫu, thống kê, lọc từ khóa an toàn |
| `js/core.js` | State `S`, điều hướng `nav/back`, `render`, bảng trượt và hộp thoại, các thành phần dùng chung |
| `js/screens-flow.js` | Màn hình S01–S14: onboarding, trang chủ, check-in, phản tư, bài tập |
| `js/screens-more.js` | Màn hình S15–S21 (lịch, chi tiết ngày, tiến trình, huy hiệu, cài đặt, riêng tư, an toàn), bảng trượt `SHEETS`, hộp thoại `MODALS` |
| `js/main.js` | Xử lý sự kiện `ACT`, bảng điều khiển bên phải, khởi tạo |

## Cách hoạt động

- Mỗi màn hình là một hàm trong `SCR` (ví dụ `SCR.S06`) trả về `{ top, body, footer, tab }`.
- Mọi nút dùng `data-act="tên"`; hàm tương ứng nằm trong `ACT` ở `main.js`.
- Ô nhập dùng `data-bind="đường.dẫn"` để ghi thẳng vào state `S`.
- Toàn bộ dữ liệu nằm trong bộ nhớ, tải lại trang là về trạng thái ban đầu. Chưa có backend.
- Bộ lọc an toàn (`safetyHit` trong `data.js`) chỉ là danh sách từ khóa để minh họa.
- Số 115 và 113 trong màn hình hỗ trợ là nội dung mẫu, cần được xác minh trước khi phát hành.
