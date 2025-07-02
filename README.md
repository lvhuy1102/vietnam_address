<div style="background-color:#f0f8ff; padding:20px; border-radius:10px;">
<h1 style="color:#4682b4;">Ứng dụng Chọn Địa chỉ Việt Nam</h1>
<p style="color:#333;">Ứng dụng Flutter này cho phép người dùng chọn Tỉnh/Thành phố và xem danh sách các Phường/Xã tương ứng từ dữ liệu JSON.</p>
</div>

<h2 style="color:#556b2f; border-bottom: 2px solid #8fbc8f; padding-bottom: 5px; margin-top: 20px;">Tính năng chính</h2>
<ul style="list-style-type:square; color:#333; line-height:1.6;">
<li>Chọn Tỉnh/Thành phố từ danh sách.</li>
<li>Hiển thị Phường/Xã tương ứng.</li>
<li>Tích hợp Gemini AI để cung cấp thông tin thú vị về tỉnh đã chọn.</li>
</ul>

<h2 style="color:#556b2f; border-bottom: 2px solid #8fbc8f; padding-bottom: 5px; margin-top: 20px;">Cài đặt và Chạy</h2>
<ol style="color:#333; line-height:1.6;">
<li>
<strong style="color:#008000;">Cấu trúc thư mục:</strong> Đặt <code>province.json</code> và <code>ward.json</code> vào thư mục <code>assets/</code> trong dự án của bạn.
<pre style="background-color:#e0e0e0; padding:10px; border-radius:5px; overflow-x:auto;"><code>your_project_name/
├── lib/
│   └── main.dart
├── assets/
│   ├── province.json
│   └── ward.json
└── pubspec.yaml</code></pre>
</li>
<li>
<strong style="color:#008000;">Cập nhật <code>pubspec.yaml</code>:</strong> Đảm bảo <code>assets/</code> được khai báo:
<pre style="background-color:#e0e0e0; padding:10px; border-radius:5px;"><code>flutter:
uses-material-design: true
assets:
- assets/province.json
- assets/ward.json</code></pre>
</li>
<li>
<strong style="color:#008000;">Chạy lệnh:</strong>
<pre style="background-color:#e0e0e0; padding:10px; border-radius:5px;"><code>flutter clean
flutter pub get
flutter run</code></pre>
</li>
</ol>

<h2 style="color:#556b2f; border-bottom: 2px solid #8fbc8f; padding-bottom: 5px; margin-top: 20px;">Dữ liệu JSON</h2>
<p style="color:#333;">Ứng dụng sử dụng <code>province.json</code> và <code>ward.json</code>. Cả hai tệp đều có cấu trúc là một đối tượng JSON, nơi mỗi khóa là mã của đơn vị hành chính và giá trị là một đối tượng chứa thông tin chi tiết.</p>

<h3 style="color:#2e8b57;">Ví dụ <code>province.json</code></h3>
<pre style="background-color:#f5f5f5; padding:10px; border-radius:5px; overflow-x:auto;"><code>{
"11": {
"name": "Hà Nội",
"slug": "ha-noi",
"type": "thanh-pho",
"name_with_type": "Thành phố Hà Nội",
"code": "11"
}
}</code></pre>

<h3 style="color:#2e8b57;">Ví dụ <code>ward.json</code></h3>
<pre style="background-color:#f5f5f5; padding:10px; border-radius:5px; overflow-x:auto;"><code>{
"267": {
"name": "Minh Châu",
"type": "xa",
"slug": "minh-chau",
"name_with_type": "Xã Minh Châu",
"path": "Minh Châu, Hà Nội",
"path_with_type": "Xã Minh Châu, Thành phố Hà Nội",
"code": "267",
"parent_code": "11"
}
}</code></pre>
