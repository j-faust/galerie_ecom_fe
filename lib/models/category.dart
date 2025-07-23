
class Category {
  final String categoryId;
  final String categoryName;

  Category({
    required this.categoryId,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'].toString(),
      categoryName: json['categoryName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'categoryName': categoryName,
  };

}