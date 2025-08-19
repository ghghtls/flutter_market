class Product {
  final String id;
  final String name;
  final int price;
  final String location;
  final String timeAgo;
  final int viewCount;
  final int likeCount;
  final String description;
  final String sellerName;
  final double sellerTemperature;
  final String imagePath;
  bool isLiked;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.timeAgo,
    required this.viewCount,
    required this.likeCount,
    required this.description,
    required this.sellerName,
    required this.sellerTemperature,
    required this.imagePath,
    this.isLiked = false,
  });

  Product copyWith({
    String? id,
    String? name,
    int? price,
    String? location,
    String? timeAgo,
    int? viewCount,
    int? likeCount,
    String? description,
    String? sellerName,
    double? sellerTemperature,
    String? imagePath,
    bool? isLiked,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      location: location ?? this.location,
      timeAgo: timeAgo ?? this.timeAgo,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      description: description ?? this.description,
      sellerName: sellerName ?? this.sellerName,
      sellerTemperature: sellerTemperature ?? this.sellerTemperature,
      imagePath: imagePath ?? this.imagePath,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
