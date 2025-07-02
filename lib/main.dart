import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'address_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AddressSelectionScreen(),
    );
  }
}




class AddressSelectionScreen extends StatefulWidget {
  const AddressSelectionScreen({super.key});

  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  List<Province> _provinces = []; // Danh sách các tỉnh/thành phố
  List<Ward> _wards = []; // Danh sách các phường/xã
  Province? _selectedProvince; // Tỉnh/thành phố được chọn
  List<Ward> _filteredWards = []; // Danh sách phường/xã đã lọc theo tỉnh

  @override
  void initState() {
    super.initState();
    _loadAddressData(); // Tải dữ liệu khi khởi tạo State
  }

  // Hàm tải dữ liệu từ tệp JSON trong assets
  Future<void> _loadAddressData() async {
    try {
      // Tải tệp province.json
      final String provinceResponse = await rootBundle.loadString('assets/province.json');
      final Map<String, dynamic> provinceMap = json.decode(provinceResponse);
      _provinces = provinceMap.values.map((json) => Province.fromJson(json)).toList();

      // Tải tệp ward.json
      final String wardResponse = await rootBundle.loadString('assets/ward.json');
      final Map<String, dynamic> wardMap = json.decode(wardResponse);
      _wards = wardMap.values.map((json) => Ward.fromJson(json)).toList();

      setState(() {
        // Cập nhật UI sau khi tải dữ liệu thành công
      });
    } catch (e) {
      // Xử lý lỗi nếu không thể tải hoặc phân tích cú pháp tệp JSON
      print('Lỗi khi tải dữ liệu địa chỉ: $e');
      // Hiển thị một thông báo lỗi cho người dùng nếu cần
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể tải dữ liệu địa chỉ.')),
      );
    }
  }

  // Hàm hiển thị bottom sheet để chọn tỉnh/thành phố
  void _showProvinceSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép bottom sheet chiếm toàn bộ chiều cao nếu cần
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Chiều cao ban đầu của bottom sheet
          minChildSize: 0.25, // Chiều cao tối thiểu
          maxChildSize: 0.9, // Chiều cao tối đa
          expand: false, // Không mở rộng toàn bộ màn hình ngay lập tức
          builder: (_, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Chọn Tỉnh/Thành phố',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: _provinces.length,
                    itemBuilder: (context, index) {
                      final province = _provinces[index];
                      return ListTile(
                        title: Text(province.nameWithType), // Hiển thị tên đầy đủ
                        onTap: () {
                          setState(() {
                            _selectedProvince = province;
                            // Lọc danh sách phường/xã dựa trên mã tỉnh đã chọn
                            _filteredWards = _wards
                                .where((ward) => ward.parentCode == province.code)
                                .toList();
                          });
                          Navigator.pop(context); // Đóng bottom sheet
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Địa chỉ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nút để mở bottom sheet chọn tỉnh
            ElevatedButton(
              onPressed: _provinces.isEmpty ? null : _showProvinceSelectionSheet,
              child: const Text('Chọn Tỉnh/Thành phố'),
            ),
            const SizedBox(height: 20),
            // Hiển thị tỉnh đã chọn
            Text(
              'Tỉnh/Thành phố đã chọn: ${_selectedProvince?.nameWithType ?? 'Chưa chọn'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            // Hiển thị danh sách phường/xã tương ứng
            Text(
              'Phường/Xã tương ứng:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredWards.isEmpty
                  ? Center(
                child: Text(
                  _selectedProvince == null
                      ? 'Vui lòng chọn một tỉnh/thành phố để xem phường/xã.'
                      : 'Không có phường/xã nào cho tỉnh này.',
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                itemCount: _filteredWards.length,
                itemBuilder: (context, index) {
                  final ward = _filteredWards[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(ward.nameWithType), // Hiển thị tên đầy đủ
                      subtitle: Text('Mã: ${ward.code}, Loại: ${ward.type}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
