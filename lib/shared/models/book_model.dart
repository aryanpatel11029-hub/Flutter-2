class BookModel {
  final String id;
  final String title;
  final String author;
  final double price;
  final double originalPrice;
  final String condition; // 'Like New', 'Good', 'Fair', etc.
  final String rating;
  final int soldCount;
  final String imagePath;
  final String category;
  final String description;
  final String sellerId;
  final String sellerName;
  final String isbn;
  final bool isFavorite;
  final DateTime? createdAt;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.originalPrice,
    required this.condition,
    this.rating = '4.5',
    this.soldCount = 0,
    required this.imagePath,
    this.category = 'General',
    this.description = '',
    this.sellerId = '',
    this.sellerName = '',
    this.isbn = '',
    this.isFavorite = false,
    this.createdAt,
  });

  double get discountPercentage {
    if (originalPrice <= 0 || price >= originalPrice) return 0;
    return ((originalPrice - price) / originalPrice) * 100;
  }

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    double? originalPrice,
    String? condition,
    String? rating,
    int? soldCount,
    String? imagePath,
    String? category,
    String? description,
    String? sellerId,
    String? sellerName,
    String? isbn,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      condition: condition ?? this.condition,
      rating: rating ?? this.rating,
      soldCount: soldCount ?? this.soldCount,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      description: description ?? this.description,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      isbn: isbn ?? this.isbn,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'price': price,
      'originalPrice': originalPrice,
      'condition': condition,
      'rating': rating,
      'soldCount': soldCount,
      'imagePath': imagePath,
      'category': category,
      'description': description,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'isbn': isbn,
      'isFavorite': isFavorite,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  factory BookModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return BookModel(
      id: docId ?? map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      price: _parseDouble(map['price']),
      originalPrice: _parseDouble(map['originalPrice']),
      condition: map['condition'] ?? 'Good',
      rating: map['rating']?.toString() ?? '4.5',
      soldCount: _parseInt(map['soldCount']),
      imagePath: map['imagePath'] ?? 'assets/images/books/rich_dad.jpg',
      category: map['category'] ?? 'General',
      description: map['description'] ?? '',
      sellerId: map['sellerId'] ?? '',
      sellerName: map['sellerName'] ?? '',
      isbn: map['isbn'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
    );
  }
}
