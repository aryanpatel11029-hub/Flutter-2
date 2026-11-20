import 'package:flutter/material.dart';

enum SellerBookStatus {
  active,
  sold,
  paused,
  pendingApproval,
}

enum SellerOrderStatus {
  pending,
  packed,
  inTransit,
  delivered,
  cancelled,
}

enum SellerPayoutStatus {
  completed,
  processing,
  failed,
}

class SellerBookListing {
  final String id;
  String title;
  String author;
  String category;
  double price;
  double originalPrice;
  String condition;
  String imagePath;
  String description;
  SellerBookStatus status;
  int stock;
  int viewsCount;
  int favoritesCount;
  String listedDate;
  String isbn;

  SellerBookListing({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.condition,
    required this.imagePath,
    required this.description,
    this.status = SellerBookStatus.active,
    this.stock = 1,
    this.viewsCount = 0,
    this.favoritesCount = 0,
    required this.listedDate,
    this.isbn = '978-0-123456-78-9',
  });

  double get discountPercentage {
    if (originalPrice <= 0 || price >= originalPrice) return 0;
    return ((originalPrice - price) / originalPrice) * 100;
  }
}

class SellerOrder {
  final String orderId;
  final String bookId;
  final String bookTitle;
  final String bookAuthor;
  final String imagePath;
  final String buyerName;
  final String buyerPhone;
  final String buyerAddress;
  final double bookPrice;
  final double shippingFee;
  final double platformFee;
  SellerOrderStatus status;
  final String orderDate;
  String trackingId;
  String courierPartner;
  final String paymentMode;

  SellerOrder({
    required this.orderId,
    required this.bookId,
    required this.bookTitle,
    required this.bookAuthor,
    required this.imagePath,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.bookPrice,
    this.shippingFee = 40.0,
    this.platformFee = 0.0, // 0% promotion for student/resellers!
    this.status = SellerOrderStatus.pending,
    required this.orderDate,
    this.trackingId = 'TRK-982348',
    this.courierPartner = 'Delhivery Express',
    this.paymentMode = 'UPI Pre-paid',
  });

  double get netEarnings => (bookPrice + shippingFee) - platformFee;
}

class SellerPayoutRecord {
  final String payoutId;
  final double amount;
  final String method; // 'UPI: aryan@okaxis' or 'HDFC Bank - 5421'
  final String requestedDate;
  SellerPayoutStatus status;
  final String referenceNumber;

  SellerPayoutRecord({
    required this.payoutId,
    required this.amount,
    required this.method,
    required this.requestedDate,
    this.status = SellerPayoutStatus.completed,
    required this.referenceNumber,
  });
}

class SellerReview {
  final String reviewerName;
  final double rating;
  final String comment;
  final String date;
  final String bookPurchased;

  SellerReview({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.bookPurchased,
  });
}

class SellerStoreProfile {
  String storeName;
  String ownerName;
  String email;
  String phone;
  String pickupAddress;
  String upiId;
  String bankAccountNumber;
  String ifscCode;
  String bankName;
  double rating;
  int totalReviews;
  bool isVerified;
  bool isVacationMode;
  bool autoAcceptOrders;

  SellerStoreProfile({
    this.storeName = 'Aryan Book Hub',
    this.ownerName = 'Aryan Patel',
    this.email = 'aryanpatel11029@gmail.com',
    this.phone = '+91 98765 43210',
    this.pickupAddress = 'B-402, Shivalik Residency, Science City Road, Ahmedabad, 380060',
    this.upiId = 'aryan@upi',
    this.bankAccountNumber = '987654321098',
    this.ifscCode = 'HDFC0001234',
    this.bankName = 'HDFC Bank Ltd',
    this.rating = 4.9,
    this.totalReviews = 142,
    this.isVerified = true,
    this.isVacationMode = false,
    this.autoAcceptOrders = true,
  });
}

/// Central In-Memory Data Service for Seller Panel (singleton)
class SellerDataService extends ChangeNotifier {
  static final SellerDataService _instance = SellerDataService._internal();
  factory SellerDataService() => _instance;

  SellerDataService._internal() {
    _initDefaultData();
  }

  late SellerStoreProfile profile;
  final List<SellerBookListing> _listings = [];
  final List<SellerOrder> _orders = [];
  final List<SellerPayoutRecord> _payouts = [];
  final List<SellerReview> _reviews = [];

  double _availableBalance = 4250.0;
  double _pendingBalance = 1150.0;

  List<SellerBookListing> get listings => List.unmodifiable(_listings);
  List<SellerOrder> get orders => List.unmodifiable(_orders);
  List<SellerPayoutRecord> get payouts => List.unmodifiable(_payouts);
  List<SellerReview> get reviews => List.unmodifiable(_reviews);

  double get availableBalance => _availableBalance;
  double get pendingBalance => _pendingBalance;
  double get totalLifetimeEarnings =>
      _listings.where((b) => b.status == SellerBookStatus.sold).fold(
            0.0,
            (sum, item) => sum + item.price,
          ) + 14850.0;

  int get activeListingsCount =>
      _listings.where((b) => b.status == SellerBookStatus.active).length;

  int get pendingOrdersCount => _orders
      .where((o) =>
          o.status == SellerOrderStatus.pending ||
          o.status == SellerOrderStatus.packed)
      .length;

  int get totalSoldBooksCount =>
      _listings.where((b) => b.status == SellerBookStatus.sold).length + 38;

  void _initDefaultData() {
    profile = SellerStoreProfile();

    _listings.addAll([
      SellerBookListing(
        id: 'LST-101',
        title: 'Think and Grow Rich',
        author: 'Napoleon Hill',
        category: 'Self Help',
        price: 180.0,
        originalPrice: 350.0,
        condition: 'Like New',
        imagePath: 'assets/images/money.jpg',
        description: 'Excellent condition, crisp pages, no annotations. Read once.',
        status: SellerBookStatus.active,
        viewsCount: 142,
        favoritesCount: 28,
        listedDate: '2026-10-18',
      ),
      SellerBookListing(
        id: 'LST-102',
        title: 'NCERT Physics Class 12 (Part 1 & 2)',
        author: 'NCERT Editorial',
        category: 'Textbooks',
        price: 100.0,
        originalPrice: 180.0,
        condition: 'Good',
        imagePath: 'assets/images/physics.webp',
        description: 'Complete syllabus with solved numericals. Moderate wear.',
        status: SellerBookStatus.active,
        viewsCount: 215,
        favoritesCount: 39,
        listedDate: '2026-10-15',
      ),
      SellerBookListing(
        id: 'LST-103',
        title: 'Accountancy Class 12 - T.S. Grewal',
        author: 'T.S. Grewal',
        category: 'Textbooks',
        price: 50.0,
        originalPrice: 110.0,
        condition: 'Normal',
        imagePath: 'assets/images/accounts.jpg',
        description: 'Clean textbook, neat pencil underlines in two chapters only.',
        status: SellerBookStatus.active,
        viewsCount: 95,
        favoritesCount: 12,
        listedDate: '2026-10-12',
      ),
      SellerBookListing(
        id: 'LST-104',
        title: 'Dune Deluxe Collector Edition',
        author: 'Frank Herbert',
        category: 'Novels',
        price: 250.0,
        originalPrice: 499.0,
        condition: 'Brand New',
        imagePath: 'assets/images/dune.jpg',
        description: 'Brand new, unopened paperback with premium cover art.',
        status: SellerBookStatus.active,
        viewsCount: 380,
        favoritesCount: 64,
        listedDate: '2026-10-09',
      ),
      SellerBookListing(
        id: 'LST-105',
        title: 'Demon Slayer Manga Vol. 1',
        author: 'Koyoharu Gotouge',
        category: 'Comics',
        price: 120.0,
        originalPrice: 249.0,
        condition: 'Like New',
        imagePath: 'assets/images/demon_slayer.jpg',
        description: 'Original English edition. Collector owned in protective plastic sleeve.',
        status: SellerBookStatus.active,
        viewsCount: 420,
        favoritesCount: 78,
        listedDate: '2026-10-05',
      ),
      SellerBookListing(
        id: 'LST-106',
        title: 'Rich Dad Poor Dad',
        author: 'Robert T. Kiyosaki',
        category: 'Self Help',
        price: 150.0,
        originalPrice: 299.0,
        condition: 'Good',
        imagePath: 'assets/images/rich_dad.jpg',
        description: 'All pages intact, well taken care of.',
        status: SellerBookStatus.sold,
        viewsCount: 520,
        favoritesCount: 82,
        listedDate: '2026-09-28',
      ),
      SellerBookListing(
        id: 'LST-107',
        title: 'Attack on Titan Vol. 1',
        author: 'Hajime Isayama',
        category: 'Comics',
        price: 140.0,
        originalPrice: 290.0,
        condition: 'Like New',
        imagePath: 'assets/images/aot.jpg',
        description: 'Manga collector item in prime condition.',
        status: SellerBookStatus.paused,
        viewsCount: 190,
        favoritesCount: 31,
        listedDate: '2026-09-20',
      ),
      SellerBookListing(
        id: 'LST-108',
        title: 'Python Crash Course 3rd Ed.',
        author: 'Eric Matthes',
        category: 'Textbooks',
        price: 320.0,
        originalPrice: 650.0,
        condition: 'Like New',
        imagePath: 'assets/images/python.jpg',
        description: 'Hands-on programming book with project codes.',
        status: SellerBookStatus.pendingApproval,
        viewsCount: 40,
        favoritesCount: 5,
        listedDate: '2026-10-22',
      ),
    ]);

    _orders.addAll([
      SellerOrder(
        orderId: 'ORD-78219',
        bookId: 'LST-101',
        bookTitle: 'Think and Grow Rich',
        bookAuthor: 'Napoleon Hill',
        imagePath: 'assets/images/money.jpg',
        buyerName: 'Rohan Sharma',
        buyerPhone: '+91 94280 12345',
        buyerAddress: 'Flat 304, Green Heights, Vastrapur, Ahmedabad 380015',
        bookPrice: 180.0,
        shippingFee: 40.0,
        status: SellerOrderStatus.pending,
        orderDate: 'Today, 09:30 AM',
        trackingId: 'TRK-AHM-98102',
        courierPartner: 'Shadowfax Quick',
      ),
      SellerOrder(
        orderId: 'ORD-78194',
        bookId: 'LST-102',
        bookTitle: 'NCERT Physics Class 12',
        bookAuthor: 'NCERT Editorial',
        imagePath: 'assets/images/physics.webp',
        buyerName: 'Sneha Dave',
        buyerPhone: '+91 98980 67890',
        buyerAddress: 'House 12, Shanti Nagar, Surat 395007',
        bookPrice: 100.0,
        shippingFee: 40.0,
        status: SellerOrderStatus.packed,
        orderDate: 'Yesterday, 04:15 PM',
        trackingId: 'TRK-SRT-44321',
        courierPartner: 'Delhivery Express',
      ),
      SellerOrder(
        orderId: 'ORD-77980',
        bookId: 'LST-104',
        bookTitle: 'Dune Deluxe Collector Edition',
        bookAuthor: 'Frank Herbert',
        imagePath: 'assets/images/dune.jpg',
        buyerName: 'Kunal Verma',
        buyerPhone: '+91 98251 11223',
        buyerAddress: 'A-14 Nilkanth Palms, Vadodara 390020',
        bookPrice: 250.0,
        shippingFee: 40.0,
        status: SellerOrderStatus.inTransit,
        orderDate: '21 Oct 2026',
        trackingId: 'TRK-VDR-78120',
        courierPartner: 'BlueDart Courier',
      ),
      SellerOrder(
        orderId: 'ORD-77640',
        bookId: 'LST-106',
        bookTitle: 'Rich Dad Poor Dad',
        bookAuthor: 'Robert T. Kiyosaki',
        imagePath: 'assets/images/rich_dad.jpg',
        buyerName: 'Meera Trivedi',
        buyerPhone: '+91 97230 45678',
        buyerAddress: 'Plot 88, Sector 21, Gandhinagar 382021',
        bookPrice: 150.0,
        shippingFee: 40.0,
        status: SellerOrderStatus.delivered,
        orderDate: '19 Oct 2026',
        trackingId: 'TRK-GND-33290',
        courierPartner: 'Delhivery Express',
      ),
    ]);

    _payouts.addAll([
      SellerPayoutRecord(
        payoutId: 'PAY-9041',
        amount: 2500.0,
        method: 'UPI: aryan@upi',
        requestedDate: '20 Oct 2026',
        status: SellerPayoutStatus.completed,
        referenceNumber: 'UPI/20261020/99812401',
      ),
      SellerPayoutRecord(
        payoutId: 'PAY-8912',
        amount: 1800.0,
        method: 'HDFC Bank - 098',
        requestedDate: '14 Oct 2026',
        status: SellerPayoutStatus.completed,
        referenceNumber: 'NEFT/20261014/4412908',
      ),
      SellerPayoutRecord(
        payoutId: 'PAY-8750',
        amount: 3200.0,
        method: 'UPI: aryan@upi',
        requestedDate: '05 Oct 2026',
        status: SellerPayoutStatus.completed,
        referenceNumber: 'UPI/20261005/7781290',
      ),
    ]);

    _reviews.addAll([
      SellerReview(
        reviewerName: 'Priya Joshi',
        rating: 5.0,
        comment: 'Super fast dispatch and the book was practically brand new! 10/10.',
        date: '20 Oct 2026',
        bookPurchased: 'Demon Slayer Vol 1',
      ),
      SellerReview(
        reviewerName: 'Amit Patel',
        rating: 5.0,
        comment: 'Neat packaging with bubble wrap. Accurate book description.',
        date: '18 Oct 2026',
        bookPurchased: 'Physics Class 12',
      ),
      SellerReview(
        reviewerName: 'Rahul Mehta',
        rating: 4.8,
        comment: 'Very polite seller and honest price. Highly recommended.',
        date: '12 Oct 2026',
        bookPurchased: 'Think and Grow Rich',
      ),
    ]);
  }

  // --- Actions ---

  void addListing(SellerBookListing listing) {
    _listings.insert(0, listing);
    notifyListeners();
  }

  void updateListing(SellerBookListing listing) {
    final idx = _listings.indexWhere((item) => item.id == listing.id);
    if (idx != -1) {
      _listings[idx] = listing;
      notifyListeners();
    }
  }

  void deleteListing(String id) {
    _listings.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleListingStatus(String id) {
    final idx = _listings.indexWhere((item) => item.id == id);
    if (idx != -1) {
      if (_listings[idx].status == SellerBookStatus.active) {
        _listings[idx].status = SellerBookStatus.paused;
      } else if (_listings[idx].status == SellerBookStatus.paused) {
        _listings[idx].status = SellerBookStatus.active;
      }
      notifyListeners();
    }
  }

  void markListingAsSold(String id) {
    final idx = _listings.indexWhere((item) => item.id == id);
    if (idx != -1) {
      _listings[idx].status = SellerBookStatus.sold;
      _availableBalance += _listings[idx].price;
      notifyListeners();
    }
  }

  void updateOrderStatus(String orderId, SellerOrderStatus newStatus, {String? trackingId, String? courier}) {
    final idx = _orders.indexWhere((item) => item.orderId == orderId);
    if (idx != -1) {
      _orders[idx].status = newStatus;
      if (trackingId != null && trackingId.trim().isNotEmpty) {
        _orders[idx].trackingId = trackingId.trim();
      }
      if (courier != null && courier.trim().isNotEmpty) {
        _orders[idx].courierPartner = courier.trim();
      }
      if (newStatus == SellerOrderStatus.delivered) {
        // Move from pending balance to available balance
        final earnings = _orders[idx].netEarnings;
        _pendingBalance = (_pendingBalance - earnings).clamp(0.0, double.infinity);
        _availableBalance += earnings;
      }
      notifyListeners();
    }
  }

  bool requestPayout({required double amount, required String method}) {
    if (amount <= 0 || amount > _availableBalance) {
      return false;
    }
    _availableBalance -= amount;
    final payout = SellerPayoutRecord(
      payoutId: 'PAY-${1000 + _payouts.length + 1}',
      amount: amount,
      method: method,
      requestedDate: 'Just now',
      status: SellerPayoutStatus.processing,
      referenceNumber: 'TXN/${DateTime.now().millisecondsSinceEpoch}',
    );
    _payouts.insert(0, payout);
    notifyListeners();
    return true;
  }

  void updateStoreProfile({
    String? storeName,
    String? phone,
    String? pickupAddress,
    String? upiId,
    bool? isVacationMode,
    bool? autoAcceptOrders,
  }) {
    if (storeName != null) profile.storeName = storeName;
    if (phone != null) profile.phone = phone;
    if (pickupAddress != null) profile.pickupAddress = pickupAddress;
    if (upiId != null) profile.upiId = upiId;
    if (isVacationMode != null) profile.isVacationMode = isVacationMode;
    if (autoAcceptOrders != null) profile.autoAcceptOrders = autoAcceptOrders;
    notifyListeners();
  }
}
