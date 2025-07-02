Ứng dụng Chọn Địa chỉ Việt NamỨng dụng Flutter này cho phép người dùng chọn Tỉnh/Thành phố và xem danh sách các Phường/Xã tương ứng, sử dụng dữ liệu từ các tệp JSON cục bộ.Tính năngHiển thị danh sách các Tỉnh/Thành phố từ tệp province.json.Sử dụng Bottom Sheet để chọn Tỉnh/Thành phố một cách trực quan.Lọc và hiển thị danh sách các Phường/Xã tương ứng với Tỉnh/Thành phố đã chọn từ tệp ward.json.Giao diện người dùng sạch sẽ, dễ sử dụng với các thành phần Material Design.Cài đặt và Chạy ứng dụngĐể chạy ứng dụng này trên máy cục bộ của bạn, hãy làm theo các bước sau:1. Yêu cầuFlutter SDK (phiên bản ổn định)Một trình soạn thảo mã (ví dụ: VS Code, Android Studio)2. Thiết lập dự ánClone repository (hoặc tạo dự án mới):Nếu bạn chưa có dự án, hãy tạo một dự án Flutter mới:flutter create address_app
cd address_app
Đặt tệp JSON:Tạo một thư mục có tên assets ở cấp độ gốc của dự án của bạn (ngang hàng với lib/ và pubspec.yaml).Đặt hai tệp JSON (province.json và ward.json) vào thư mục assets này.Cấu trúc thư mục:your_project_name/
├── lib/
│   └── main.dart
├── assets/
│   ├── province.json
│   └── ward.json
└── pubspec.yaml
Cập nhật pubspec.yaml:Mở tệp pubspec.yaml và đảm bảo rằng phần assets được khai báo chính xác để Flutter có thể tìm thấy các tệp JSON của bạn. Đảm bảo thụt lề chính xác (sử dụng dấu cách, không phải tab).flutter:
  uses-material-design: true
  assets:
    - assets/province.json
    - assets/ward.json
Tải các gói và tài nguyên:Chạy lệnh sau trong terminal của dự án để tải các dependency và cập nhật tài nguyên:flutter pub get
Chạy ứng dụng:Kết nối thiết bị di động hoặc khởi động trình giả lập, sau đó chạy ứng dụng:flutter run
Cấu trúc dữ liệu JSONỨng dụng được thiết kế để đọc dữ liệu từ hai tệp JSON: province.json và ward.json.province.jsonTệp này dự kiến chứa một đối tượng JSON, nơi mỗi khóa là mã của tỉnh/thành phố và giá trị là một đối tượng chứa thông tin chi tiết về tỉnh/thành phố đó.Ví dụ về cấu trúc (dựa trên dữ liệu bạn đã cung cấp):{
  "11": {
    "name": "Hà Nội",
    "slug": "ha-noi",
    "type": "thanh-pho",
    "name_with_type": "Thành phố Hà Nội",
    "code": "11"
  },
  "12": {
    "name": "Hồ Chí Minh",
    "slug": "ho-chi-minh",
    "type": "thanh-pho",
    "name_with_type": "Thành phố Hồ Chí Minh",
    "code": "12"
  }
  // ... các tỉnh/thành phố khác
}
ward.jsonTệp này cũng dự kiến chứa một đối tượng JSON, nơi mỗi khóa là mã của phường/xã và giá trị là một đối tượng chứa thông tin chi tiết về phường/xã đó, bao gồm parent_code để liên kết với tỉnh/thành phố cha.Ví dụ về cấu trúc (dựa trên dữ liệu bạn đã cung cấp):{
  "267": {
    "name": "Minh Châu",
    "type": "xa",
    "slug": "minh-chau",
    "name_with_type": "Xã Minh Châu",
    "path": "Minh Châu, Hà Nội",
    "path_with_type": "Xã Minh Châu, Thành phố Hà Nội",
    "code": "267",
    "parent_code": "11"
  },
  "268": {
    "name": "Thạnh An",
    "type": "xa",
    "slug": "thanh-an",
    "name_with_type": "Xã Thạnh An",
    "path": "Thạnh An, Hồ Chí Minh",
    "path_with_type": "Xã Thạnh An, Thành phố Hồ Chí Minh",
    "code": "268",
    "parent_code": "12"
  }
  // ... các phường/xã khác
}
Lưu ý về dữ liệu Vietmap:Nếu dữ liệu JSON của Vietmap có cấu trúc là một mảng (List) thay vì một đối tượng (Map) như ví dụ trên, bạn sẽ cần điều chỉnh cách đọc dữ liệu trong hàm _loadAddressData() của main.dart như đã được ghi chú trong mã nguồn.Đóng gópĐóng góp được hoan nghênh! Vui lòng fork repository và tạo một pull request với các thay đổi của bạn.
