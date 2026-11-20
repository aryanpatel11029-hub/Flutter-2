import 'package:flutter/material.dart';
import '../models/seller_models.dart';

class SellerProvider extends ChangeNotifier {
  static final SellerProvider _instance = SellerProvider._internal();
  factory SellerProvider() => _instance;
  SellerProvider._internal() {
    _service.addListener(notifyListeners);
  }

  final SellerDataService _service = SellerDataService();
  SellerDataService get service => _service;

  List<SellerBookListing> get listings => _service.listings;
  List<SellerOrder> get orders => _service.orders;
  List<SellerPayoutRecord> get payouts => _service.payouts;
  List<SellerReview> get reviews => _service.reviews;

  int get activeListingsCount => _service.activeListingsCount;
  int get pendingOrdersCount => _service.pendingOrdersCount;
  int get totalSoldBooksCount => _service.totalSoldBooksCount;
  double get availableBalance => _service.availableBalance;
  double get pendingBalance => _service.pendingBalance;
  double get totalLifetimeEarnings => _service.totalLifetimeEarnings;

  void addListing(SellerBookListing listing) {
    _service.addListing(listing);
  }

  void updateListing(SellerBookListing listing) {
    _service.updateListing(listing);
  }

  void deleteListing(String id) {
    _service.deleteListing(id);
  }

  void updateOrderStatus(String orderId, SellerOrderStatus status) {
    _service.updateOrderStatus(orderId, status);
  }
}
