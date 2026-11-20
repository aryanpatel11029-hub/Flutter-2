import 'package:flutter/material.dart';

enum BookApprovalStatus { pending, approved, rejected }
enum OrderStatus { processing, inTransit, delivered, canceled }
enum UserAccountStatus { active, suspended }
enum UserRole { buyer, seller, verifiedSeller }

class AdminBook {
  final String id;
  String title;
  String author;
  String category;
  double price;
  double originalPrice;
  String condition;
  String sellerName;
  String sellerPhone;
  String imagePath;
  String description;
  BookApprovalStatus status;
  String listedDate;
  int soldCount;

  AdminBook({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.condition,
    required this.sellerName,
    this.sellerPhone = '+91 98765 43210',
    required this.imagePath,
    this.description = 'Good condition, no marked pages or missing leaves.',
    this.status = BookApprovalStatus.approved,
    required this.listedDate,
    this.soldCount = 0,
  });
}

class AdminOrder {
  final String orderId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String address;
  final String bookTitle;
  final double bookPrice;
  final String imagePath;
  OrderStatus status;
  final String orderDate;
  final String paymentMethod;
  final String trackingId;

  AdminOrder({
    required this.orderId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.address,
    required this.bookTitle,
    required this.bookPrice,
    required this.imagePath,
    this.status = OrderStatus.processing,
    required this.orderDate,
    this.paymentMethod = 'UPI / Online',
    required this.trackingId,
  });
}

class AdminUser {
  final String id;
  String name;
  String email;
  String phone;
  UserRole role;
  int totalOrders;
  int totalListings;
  UserAccountStatus status;
  String joinedDate;
  Color avatarColor;

  AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.totalOrders = 0,
    this.totalListings = 0,
    this.status = UserAccountStatus.active,
    required this.joinedDate,
    required this.avatarColor,
  });
}

class AdminCategory {
  final String id;
  String name;
  int bookCount;
  IconData icon;
  Color color;

  AdminCategory({
    required this.id,
    required this.name,
    required this.bookCount,
    required this.icon,
    required this.color,
  });
}

class AdminReport {
  final String id;
  final String reportedItem;
  final String reporterName;
  final String type; // 'Listing', 'Seller', 'Order'
  final String reason;
  String status; // 'Pending', 'Resolved', 'Dismissed'
  final String date;

  AdminReport({
    required this.id,
    required this.reportedItem,
    required this.reporterName,
    required this.type,
    required this.reason,
    this.status = 'Pending',
    required this.date,
  });
}

class AdminDataService extends ChangeNotifier {
  static final AdminDataService _instance = AdminDataService._internal();
  factory AdminDataService() => _instance;

  AdminDataService._internal() {
    _initData();
  }

  // App Settings
  double commissionRate = 8.5; // percentage
  bool maintenanceMode = false;
  bool broadcastBannerEnabled = false;
  String broadcastMessage = 'ReRead Monsoon Book Fair: Flat 20% off shipping!';

  // Data collections
  final List<AdminBook> _books = [];
  final List<AdminOrder> _orders = [];
  final List<AdminUser> _users = [];
  final List<AdminCategory> _categories = [];
  final List<AdminReport> _reports = [];

  List<AdminBook> get books => List.unmodifiable(_books);
  List<AdminOrder> get orders => List.unmodifiable(_orders);
  List<AdminUser> get users => List.unmodifiable(_users);
  List<AdminCategory> get categories => List.unmodifiable(_categories);
  List<AdminReport> get reports => List.unmodifiable(_reports);

  // Statistics
  double get totalRevenue => _orders
      .where((o) => o.status != OrderStatus.canceled)
      .fold(0.0, (sum, o) => sum + o.bookPrice);

  int get pendingApprovalsCount =>
      _books.where((b) => b.status == BookApprovalStatus.pending).length;

  int get pendingOrdersCount =>
      _orders.where((o) => o.status == OrderStatus.processing).length;

  int get pendingReportsCount =>
      _reports.where((r) => r.status == 'Pending').length;

  void _initData() {
    // Categories
    _categories.addAll([
      AdminCategory(
        id: 'cat_1',
        name: 'Textbooks',
        bookCount: 142,
        icon: Icons.school_rounded,
        color: const Color(0xFF4F39E3),
      ),
      AdminCategory(
        id: 'cat_2',
        name: 'Novels',
        bookCount: 89,
        icon: Icons.auto_stories_rounded,
        color: const Color(0xFF0EA5E9),
      ),
      AdminCategory(
        id: 'cat_3',
        name: 'Medical',
        bookCount: 46,
        icon: Icons.medical_services_rounded,
        color: const Color(0xFF10B981),
      ),
      AdminCategory(
        id: 'cat_4',
        name: 'Comics',
        bookCount: 58,
        icon: Icons.palette_rounded,
        color: const Color(0xFFF59E0B),
      ),
      AdminCategory(
        id: 'cat_5',
        name: 'Self Help',
        bookCount: 65,
        icon: Icons.lightbulb_rounded,
        color: const Color(0xFF8B5CF6),
      ),
      AdminCategory(
        id: 'cat_6',
        name: 'Engineering',
        bookCount: 52,
        icon: Icons.precision_manufacturing_rounded,
        color: const Color(0xFFEC4899),
      ),
    ]);

    // Books
    _books.addAll([
      AdminBook(
        id: 'bk_1',
        title: 'NCERT Accounts Std 12',
        author: 'NCERT Board',
        category: 'Textbooks',
        price: 50,
        originalPrice: 110,
        condition: 'Normal',
        sellerName: 'Aryan Patel',
        imagePath: 'assets/images/accounts.jpg',
        status: BookApprovalStatus.approved,
        listedDate: '18 Oct 2026',
        soldCount: 120,
      ),
      AdminBook(
        id: 'bk_2',
        title: 'Concepts of Physics Part 1',
        author: 'H.C. Verma',
        category: 'Textbooks',
        price: 100,
        originalPrice: 180,
        condition: 'Good',
        sellerName: 'Priya Sharma',
        imagePath: 'assets/images/physics.webp',
        status: BookApprovalStatus.approved,
        listedDate: '19 Oct 2026',
        soldCount: 85,
      ),
      AdminBook(
        id: 'bk_3',
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        category: 'Novels',
        price: 200,
        originalPrice: 399,
        condition: 'Like New',
        sellerName: 'Rohan Mehta',
        imagePath: 'assets/images/money.jpg',
        status: BookApprovalStatus.pending,
        listedDate: '20 Oct 2026',
        soldCount: 0,
      ),
      AdminBook(
        id: 'bk_4',
        title: 'One Piece - Vol 61',
        author: 'Eiichiro Oda',
        category: 'Comics',
        price: 180,
        originalPrice: 350,
        condition: 'Like New',
        sellerName: 'Sneha Joshi',
        imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
        status: BookApprovalStatus.approved,
        listedDate: '15 Oct 2026',
        soldCount: 34,
      ),
      AdminBook(
        id: 'bk_5',
        title: 'Rich Dad Poor Dad',
        author: 'Robert Kiyosaki',
        category: 'Self Help',
        price: 220,
        originalPrice: 450,
        condition: 'Good',
        sellerName: 'Vikram Singh',
        imagePath: 'assets/images/rich_dad.jpg',
        status: BookApprovalStatus.pending,
        listedDate: '21 Oct 2026',
        soldCount: 0,
      ),
      AdminBook(
        id: 'bk_6',
        title: 'Attack on Titan Vol 1',
        author: 'Hajime Isayama',
        category: 'Comics',
        price: 150,
        originalPrice: 299,
        condition: 'Brand New',
        sellerName: 'Devang Vora',
        imagePath: 'assets/images/aot.jpg',
        status: BookApprovalStatus.pending,
        listedDate: '21 Oct 2026',
        soldCount: 0,
      ),
      AdminBook(
        id: 'bk_7',
        title: 'Dune Deluxe Edition',
        author: 'Frank Herbert',
        category: 'Novels',
        price: 320,
        originalPrice: 699,
        condition: 'Like New',
        sellerName: 'Ananya Desai',
        imagePath: 'assets/images/dune.jpg',
        status: BookApprovalStatus.approved,
        listedDate: '12 Oct 2026',
        soldCount: 15,
      ),
      AdminBook(
        id: 'bk_8',
        title: 'Demon Slayer - Kimetsu No Yaiba',
        author: 'Koyoharu Gotouge',
        category: 'Comics',
        price: 199,
        originalPrice: 399,
        condition: 'Normal',
        sellerName: 'Karan Shah',
        imagePath: 'assets/images/demon_slayer.jpg',
        status: BookApprovalStatus.rejected,
        listedDate: '10 Oct 2026',
        soldCount: 0,
      ),
    ]);

    // Orders
    _orders.addAll([
      AdminOrder(
        orderId: 'RR-89214',
        customerName: 'Pooja Kulkarni',
        customerEmail: 'pooja.k@gmail.com',
        customerPhone: '+91 99201 12345',
        address: 'B-402, Lotus Residency, SG Highway, Ahmedabad',
        bookTitle: 'Concepts of Physics Part 1',
        bookPrice: 100,
        imagePath: 'assets/images/physics.webp',
        status: OrderStatus.processing,
        orderDate: '21 Oct 2026, 11:20 AM',
        paymentMethod: 'Google Pay (UPI)',
        trackingId: 'TRK-IN-98124',
      ),
      AdminOrder(
        orderId: 'RR-89201',
        customerName: 'Rahul Verma',
        customerEmail: 'rahul.v@yahoo.com',
        customerPhone: '+91 98250 88219',
        address: 'Flat 12, Sunrise Apts, Vastrapur, Ahmedabad',
        bookTitle: 'The Psychology of Money',
        bookPrice: 200,
        imagePath: 'assets/images/money.jpg',
        status: OrderStatus.inTransit,
        orderDate: '20 Oct 2026, 04:15 PM',
        paymentMethod: 'PhonePe',
        trackingId: 'TRK-DT-55214',
      ),
      AdminOrder(
        orderId: 'RR-89190',
        customerName: 'Aarav Patel',
        customerEmail: 'aarav.p@gmail.com',
        customerPhone: '+91 94280 44102',
        address: '15, Shanti Niketan, Bodakdev, Ahmedabad',
        bookTitle: 'One Piece - Vol 61',
        bookPrice: 180,
        imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
        status: OrderStatus.delivered,
        orderDate: '19 Oct 2026, 09:30 AM',
        paymentMethod: 'Cash on Delivery',
        trackingId: 'TRK-BD-33910',
      ),
      AdminOrder(
        orderId: 'RR-89182',
        customerName: 'Simran Kaur',
        customerEmail: 'simran.k@outlook.com',
        customerPhone: '+91 97112 00192',
        address: 'Plot 88, Sector 21, Gandhinagar',
        bookTitle: 'Rich Dad Poor Dad',
        bookPrice: 220,
        imagePath: 'assets/images/rich_dad.jpg',
        status: OrderStatus.delivered,
        orderDate: '18 Oct 2026, 02:40 PM',
        paymentMethod: 'Credit Card (Visa)',
        trackingId: 'TRK-DL-11029',
      ),
      AdminOrder(
        orderId: 'RR-89170',
        customerName: 'Tanmay Bhatt',
        customerEmail: 'tanmay.b@gmail.com',
        customerPhone: '+91 90999 12389',
        address: 'C-10, Green City, Maninagar, Ahmedabad',
        bookTitle: 'NCERT Accounts Std 12',
        bookPrice: 50,
        imagePath: 'assets/images/accounts.jpg',
        status: OrderStatus.canceled,
        orderDate: '17 Oct 2026, 07:10 PM',
        paymentMethod: 'UPI Refunded',
        trackingId: 'TRK-RF-00918',
      ),
    ]);

    // Users
    _users.addAll([
      AdminUser(
        id: 'usr_1',
        name: 'Aryan Patel',
        email: 'aryan.patel@gmail.com',
        phone: '+91 98791 22334',
        role: UserRole.verifiedSeller,
        totalOrders: 14,
        totalListings: 28,
        status: UserAccountStatus.active,
        joinedDate: 'Jan 2026',
        avatarColor: const Color(0xFF4F39E3),
      ),
      AdminUser(
        id: 'usr_2',
        name: 'Priya Sharma',
        email: 'priya.sharma@gmail.com',
        phone: '+91 99092 11002',
        role: UserRole.verifiedSeller,
        totalOrders: 9,
        totalListings: 15,
        status: UserAccountStatus.active,
        joinedDate: 'Mar 2026',
        avatarColor: const Color(0xFF10B981),
      ),
      AdminUser(
        id: 'usr_3',
        name: 'Rohan Mehta',
        email: 'rohan.mehta@yahoo.com',
        phone: '+91 97230 55410',
        role: UserRole.seller,
        totalOrders: 4,
        totalListings: 6,
        status: UserAccountStatus.active,
        joinedDate: 'Jun 2026',
        avatarColor: const Color(0xFFF59E0B),
      ),
      AdminUser(
        id: 'usr_4',
        name: 'Karan Shah',
        email: 'karan.shah@spammail.com',
        phone: '+91 91234 56789',
        role: UserRole.seller,
        totalOrders: 1,
        totalListings: 2,
        status: UserAccountStatus.suspended,
        joinedDate: 'Aug 2026',
        avatarColor: const Color(0xFFEF4444),
      ),
      AdminUser(
        id: 'usr_5',
        name: 'Pooja Kulkarni',
        email: 'pooja.k@gmail.com',
        phone: '+91 99201 12345',
        role: UserRole.buyer,
        totalOrders: 18,
        totalListings: 0,
        status: UserAccountStatus.active,
        joinedDate: 'Feb 2026',
        avatarColor: const Color(0xFF0EA5E9),
      ),
      AdminUser(
        id: 'usr_6',
        name: 'Sneha Joshi',
        email: 'sneha.joshi@gmail.com',
        phone: '+91 94270 88991',
        role: UserRole.verifiedSeller,
        totalOrders: 7,
        totalListings: 12,
        status: UserAccountStatus.active,
        joinedDate: 'Apr 2026',
        avatarColor: const Color(0xFF8B5CF6),
      ),
    ]);

    // Reports
    _reports.addAll([
      AdminReport(
        id: 'rep_1',
        reportedItem: 'Demon Slayer - Kimetsu No Yaiba',
        reporterName: 'Priya Sharma',
        type: 'Listing',
        reason: 'Counterfeit / pirated print detected with blurry text pages.',
        status: 'Pending',
        date: '20 Oct 2026',
      ),
      AdminReport(
        id: 'rep_2',
        reportedItem: 'Seller: Karan Shah',
        reporterName: 'Tanmay Bhatt',
        type: 'Seller',
        reason: 'Seller delayed dispatch for 7 days and is unresponsive on chat.',
        status: 'Pending',
        date: '19 Oct 2026',
      ),
      AdminReport(
        id: 'rep_3',
        reportedItem: 'Order #RR-89170',
        reporterName: 'Tanmay Bhatt',
        type: 'Order',
        reason: 'Incorrect edition received. Requested cancellation and refund.',
        status: 'Resolved',
        date: '18 Oct 2026',
      ),
    ]);
  }

  // Book operations
  void updateBookStatus(String bookId, BookApprovalStatus newStatus) {
    final index = _books.indexWhere((b) => b.id == bookId);
    if (index != -1) {
      _books[index].status = newStatus;
      notifyListeners();
    }
  }

  void addBook(AdminBook book) {
    _books.insert(0, book);
    notifyListeners();
  }

  void updateBook(AdminBook updatedBook) {
    final index = _books.indexWhere((b) => b.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  void deleteBook(String bookId) {
    _books.removeWhere((b) => b.id == bookId);
    notifyListeners();
  }

  // Order operations
  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      notifyListeners();
    }
  }

  // User operations
  void toggleUserStatus(String userId) {
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      _users[index].status = _users[index].status == UserAccountStatus.active
          ? UserAccountStatus.suspended
          : UserAccountStatus.active;
      notifyListeners();
    }
  }

  void toggleUserVerification(String userId) {
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      if (_users[index].role == UserRole.verifiedSeller) {
        _users[index].role = UserRole.seller;
      } else {
        _users[index].role = UserRole.verifiedSeller;
      }
      notifyListeners();
    }
  }

  void addUser(AdminUser user) {
    _users.insert(0, user);
    notifyListeners();
  }

  // Category operations
  void addCategory(AdminCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  void deleteCategory(String id) {
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  // Report operations
  void resolveReport(String reportId, String status) {
    final index = _reports.indexWhere((r) => r.id == reportId);
    if (index != -1) {
      _reports[index].status = status;
      notifyListeners();
    }
  }

  // Settings
  void updateCommission(double rate) {
    commissionRate = rate;
    notifyListeners();
  }

  void toggleMaintenance(bool val) {
    maintenanceMode = val;
    notifyListeners();
  }

  void updateBroadcast(bool enabled, String msg) {
    broadcastBannerEnabled = enabled;
    broadcastMessage = msg;
    notifyListeners();
  }
}
