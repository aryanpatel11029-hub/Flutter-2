import 'package:flutter/material.dart';
import '../../../shared/models/cart_item_model.dart';
import '../../../shared/models/book_model.dart';

class CartProvider extends ChangeNotifier {
  static final CartProvider _instance = CartProvider._internal();
  factory CartProvider() => _instance;
  CartProvider._internal();

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => _items.isEmpty ? 0.0 : 40.0;
  double get total => subtotal + deliveryFee;

  void addItem(BookModel book) {
    final existingIndex = _items.indexWhere((item) => item.book.id == book.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(
        CartItemModel(
          id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
          book: book,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void updateQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(cartItemId);
      return;
    }
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
