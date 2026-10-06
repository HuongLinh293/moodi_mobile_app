# Kế Hoạch Triển Khai Backend Mindra (Cho Team 2 Người)

Với tech stack là **Firebase** và team có 2 thành viên, cách phân chia tối ưu nhất là một người chuyên phụ trách cấu hình hạ tầng Firebase & Cloud Functions (Tạm gọi là **Thành viên A**), và người còn lại chuyên phụ trách cấu trúc dữ liệu, kết nối API và UI ở phía Flutter (Tạm gọi là **Thành viên B**).

Hai bạn có thể làm việc song song mà không bị chặn nhau (block) quá nhiều.

---

## 👨‍💻 Thành viên A: Phụ trách Infrastructure & Cloud Logic (Backend Focus)
*Vai trò: Thiết lập Firebase, bảo mật, và viết script xử lý AI trên Cloud.*

### 1. Khởi tạo & Cấu hình Project (Ngày 1)
- Tạo project trên Firebase Console.
- Thiết lập **Firestore Database** (bật mode Production).
- Thiết lập **Firebase Auth** (bật đăng nhập Email/Password, hoặc Google/Apple tùy nhu cầu).
- Mời Thành viên B vào project Firebase.

### 2. Thiết lập Bảo mật Firestore (Security Rules) (Ngày 1-2)
- Viết file `firestore.rules` đảm bảo:
  - User chỉ được đọc/ghi dữ liệu của chính mình (kiểm tra `request.auth.uid`).
  - Phân quyền các collection: `users`, `journal_entries`, `garden_moments`, `micro_goals`.

### 3. Phát triển Cloud Functions cho AI Reflection (Ngày 2-3)
- Cài đặt Firebase CLI và khởi tạo thư mục `functions` (bằng Node.js/TypeScript hoặc Python).
- Viết API endpoint (Callable Function) có tên ví dụ `generateReflection`.
  - Input: `emotionKey`, `intensity`, `situation`, `thought`.
  - Xử lý: Gọi API của Gemini (hoặc OpenAI) với Prompt phù hợp. Trả về cấu trúc JSON khớp với model `AIReflection` của Flutter.
- Deploy function lên Firebase.

---

## 👨‍💻 Thành viên B: Phụ trách Flutter & Data Binding (Frontend Focus)
*Vai trò: Chuẩn bị Models, cấu trúc Repository, và cập nhật giao diện xử lý async.*

### 1. Chuẩn bị Models & Setup Firebase Client (Ngày 1)
- Thạy lệnh cài các thư viện `firebase_core`, `cloud_firestore`, `firebase_auth`.
- Cấu hình FlutterFire CLI (`flutterfire configure`).
- Viết hàm `fromJson` và `toJson` cho tất cả các file trong `lib/models/` (Đặc biệt là `JournalEntry`, `GardenMoment`, `MicroGoal`).
  *Lưu ý: Chuyển đổi `DateTime` thành `Timestamp` của Firestore.*

### 2. Xây dựng Repository Pattern (Ngày 2)
- Tạo thư mục `lib/repositories/`.
- **`AuthRepository`**: Các hàm `signIn`, `signOut`, `getCurrentUser()`.
- **`JournalRepository`**: Các hàm `addEntry()`, `getEntriesByUserId()`.
- **`GardenRepository`**: Các hàm `plantMoment()`, `fetchMoments()`.
- *Mẹo:* Trong khi Thành viên A chưa làm xong Backend, bạn có thể cho các hàm này `await Future.delayed` và trả về Mock Data để code UI tiếp.

### 3. Refactor MindraState & UI Loading (Ngày 3)
- Sửa lại `lib/state/mindra_state.dart`: Không dùng List nội bộ nữa mà dùng các Repository để lấy dữ liệu.
- Xử lý trạng thái Loading (`isLoading = true`):
  - Hiển thị xoay loading trên màn hình `CheckinView` khi đang lưu nhật ký.
  - Hiển thị Skeleton loading trên màn hình `AiReflectionView` khi chờ kết quả AI.
- Cập nhật luồng Auth (thêm màn hình Đăng nhập/Đăng ký nếu cần, kết nối vào logic AuthRepository).

---

## 🤝 Giai đoạn Tích hợp & Testing (Cả 2 thành viên)
*(Sau khi 2 người hoàn thành phần việc cá nhân)*

- **Ghép nối hàm AI**: Thành viên B gọi Cloud Function do Thành viên A viết qua thư viện `cloud_functions` của Flutter.
- **Kiểm thử Offline**: Tắt wifi trên máy ảo, thử viết nhật ký xem Firestore có lưu offline không, bật wifi lại xem có đồng bộ thành công không.
- **Kiểm thử Security**: Test bằng tài khoản A xem có đọc được nhật ký của tài khoản B không.
