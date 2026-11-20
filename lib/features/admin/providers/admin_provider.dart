import 'package:flutter/material.dart';
import '../models/admin_models.dart';

class AdminProvider extends ChangeNotifier {
  static final AdminProvider _instance = AdminProvider._internal();
  factory AdminProvider() => _instance;
  AdminProvider._internal() {
    _service.addListener(notifyListeners);
  }

  final AdminDataService _service = AdminDataService();
  AdminDataService get service => _service;

  List<AdminBook> get books => _service.books;
  List<AdminOrder> get orders => _service.orders;
  List<AdminUser> get users => _service.users;
  List<AdminCategory> get categories => _service.categories;

  int get totalUsersCount => _service.users.length;
  int get totalBooksCount => _service.books.length;
  int get pendingApprovalsCount => _service.pendingApprovalsCount;
  double get totalRevenue => _service.totalRevenue;

  void approveBook(String bookId) {
    _service.updateBookStatus(bookId, BookApprovalStatus.approved);
  }

  void rejectBook(String bookId) {
    _service.updateBookStatus(bookId, BookApprovalStatus.rejected);
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    _service.updateOrderStatus(orderId, status);
  }

  void toggleUserStatus(String userId) {
    _service.toggleUserStatus(userId);
  }
}
