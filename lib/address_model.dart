class Province {
  final String code; // Mã tỉnh/thành phố
  final String name;
  final String slug;
  final String type;
  final String nameWithType; // Tên đầy đủ với loại (ví dụ: "Thành phố Hà Nội")

  Province({
    required this.code,
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
  });

  // Factory constructor để tạo đối tượng Province từ Map
  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      code: json['code'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      type: json['type'] as String,
      nameWithType: json['name_with_type'] as String,
    );
  }
}

// Lớp mô hình cho Phường/Xã
class Ward {
  final String code; // Mã phường/xã
  final String name;
  final String type;
  final String slug;
  final String nameWithType; // Tên đầy đủ với loại (ví dụ: "Phường Vĩnh Phúc")
  final String path;
  final String pathWithType;
  final String parentCode; // Mã tỉnh/thành phố cha

  Ward({
    required this.code,
    required this.name,
    required this.type,
    required this.slug,
    required this.nameWithType,
    required this.path,
    required this.pathWithType,
    required this.parentCode,
  });

  // Factory constructor để tạo đối tượng Ward từ Map
  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      code: json['code'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      slug: json['slug'] as String,
      nameWithType: json['name_with_type'] as String,
      path: json['path'] as String,
      pathWithType: json['path_with_type'] as String,
      parentCode: json['parent_code'] as String,
    );
  }
}