import 'book_model.dart';

class CartItemModel {
  final String id;
  final BookModel book;
  int quantity;
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.book,
    this.quantity = 1,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  double get totalPrice => book.price * quantity;

  CartItemModel copyWith({
    String? id,
    BookModel? book,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      book: book ?? this.book,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book': book.toMap(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      book: BookModel.fromMap(map['book'] ?? {}),
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      addedAt: map['addedAt'] != null
          ? DateTime.tryParse(map['addedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
