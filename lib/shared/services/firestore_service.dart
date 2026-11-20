import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection references
  CollectionReference<Map<String, dynamic>> get _booksCol =>
      _db.collection('book');
  CollectionReference<Map<String, dynamic>> get _ordersCol =>
      _db.collection('orders');
  CollectionReference<Map<String, dynamic>> get _usersCol =>
      _db.collection('users');

  // ================= BOOKS CRUD =================

  /// Stream real-time books (optionally filtered by category)
  Stream<List<BookModel>> streamBooks({String? category}) {
    Query<Map<String, dynamic>> query = _booksCol;
    if (category != null && category != 'All' && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => BookModel.fromMap(doc.data(), docId: doc.id))
          .toList();
    });
  }

  /// Get books list once
  Future<List<BookModel>> getBooks({String? category}) async {
    Query<Map<String, dynamic>> query = _booksCol;
    if (category != null && category != 'All' && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => BookModel.fromMap(doc.data(), docId: doc.id))
        .toList();
  }

  /// Get a single book by ID
  Future<BookModel?> getBookById(String bookId) async {
    final doc = await _booksCol.doc(bookId).get();
    if (doc.exists && doc.data() != null) {
      return BookModel.fromMap(doc.data()!, docId: doc.id);
    }
    return null;
  }

  /// Add a new book document
  Future<String> addBook(BookModel book) async {
    final docRef = book.id.isNotEmpty ? _booksCol.doc(book.id) : _booksCol.doc();
    final bookData = book.copyWith(id: docRef.id).toMap();
    await docRef.set(bookData);
    return docRef.id;
  }

  /// Update an existing book document
  Future<void> updateBook(BookModel book) async {
    await _booksCol.doc(book.id).update(book.toMap());
  }

  /// Delete a book document
  Future<void> deleteBook(String bookId) async {
    await _booksCol.doc(bookId).delete();
  }

  /// Seeds all 16 catalog books into Firestore
  Future<void> seedSampleBooks() async {
    try {
      final allBooks = [
        const BookModel(
          id: 'book_accounts',
          title: 'Accounts',
          author: 'NCERT',
          price: 50.0,
          originalPrice: 110.0,
          condition: 'Normal',
          rating: '4.8',
          soldCount: 120,
          imagePath: 'assets/images/books/accounts.jpg',
          category: 'Textbooks',
          description: 'Official NCERT class accountancy book in good readable condition.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_physics',
          title: 'Physics',
          author: 'NCERT',
          price: 100.0,
          originalPrice: 180.0,
          condition: 'Good',
          rating: '4.9',
          soldCount: 85,
          imagePath: 'assets/images/books/physics.webp',
          category: 'Textbooks',
          description: 'NCERT Physics textbook with intact binding and clear formulas.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_money',
          title: 'The Psychology of Money',
          author: 'Morgan Housel',
          price: 200.0,
          originalPrice: 399.0,
          condition: 'Like New',
          rating: '4.7',
          soldCount: 150,
          imagePath: 'assets/images/books/money.jpg',
          category: 'Novels',
          description: 'Timeless lessons on wealth, greed, and happiness.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_dune',
          title: 'Dune',
          author: 'Frank Herbert',
          price: 250.0,
          originalPrice: 499.0,
          condition: 'Like New',
          rating: '4.8',
          soldCount: 95,
          imagePath: 'assets/images/books/dune.jpg',
          category: 'Novels',
          description: 'Science fiction classic set in the distant future amidst a huge interstellar empire.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_one_piece',
          title: 'One Piece (Vol. 61)',
          author: 'Eiichiro Oda',
          price: 199.0,
          originalPrice: 350.0,
          condition: 'Like New',
          rating: '5.0',
          soldCount: 310,
          imagePath: 'assets/images/books/One_Piece,_Volume_61_Cover_.jpg',
          category: 'Comics',
          description: 'Two years later, the Straw Hats reunite at Sabaody Archipelago!',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_gujarati_sarthi',
          title: 'Gujarati Sarthi',
          author: 'Dr. Ramesh Dave',
          price: 50.0,
          originalPrice: 100.0,
          condition: 'Normal',
          rating: '4.5',
          soldCount: 78,
          imagePath: 'assets/images/books/gujarati_sarthi.jpg',
          category: 'Textbooks',
          description: 'Gujarati grammar and literature companion for high school students.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_human_anatomy',
          title: 'Human Anatomy & Physiology',
          author: 'Dr. Elaine Marieb',
          price: 320.0,
          originalPrice: 650.0,
          condition: 'Good',
          rating: '4.8',
          soldCount: 64,
          imagePath: 'assets/images/books/physics.webp',
          category: 'Medical',
          description: 'Comprehensive medical anatomy textbook with colored diagrams.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_aot',
          title: 'Attack on Titan',
          author: 'Hajime Isayama',
          price: 150.0,
          originalPrice: 300.0,
          condition: 'Poor',
          rating: '4.7',
          soldCount: 210,
          imagePath: 'assets/images/books/aot.jpg',
          category: 'Comics',
          description: 'Manga volume following Eren Yeager and the Survey Corps.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_demon_slayer',
          title: 'Demon Slayer',
          author: 'Koyoharu Gotouge',
          price: 180.0,
          originalPrice: 299.0,
          condition: 'Good',
          rating: '4.9',
          soldCount: 180,
          imagePath: 'assets/images/books/demon_slayer.jpg',
          category: 'Comics',
          description: 'Follow Tanjiro Kamado on his quest to cure his sister Nezuko.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_it_ends_with_us',
          title: 'It Ends with Us',
          author: 'Colleen Hoover',
          price: 220.0,
          originalPrice: 399.0,
          condition: 'Normal',
          rating: '4.6',
          soldCount: 145,
          imagePath: 'assets/images/books/it_end_us.jpg',
          category: 'Novels',
          description: 'Heart-wrenching romantic novel by Colleen Hoover.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_how_to_kill_family',
          title: 'How to Kill Your Family',
          author: 'Bella Mackie',
          price: 210.0,
          originalPrice: 450.0,
          condition: 'Good',
          rating: '4.5',
          soldCount: 112,
          imagePath: 'assets/images/books/how_to_kill_men.jpg',
          category: 'Novels',
          description: 'Dark, witty crime fiction bestseller.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_concepts_physics',
          title: 'Concepts of Modern Physics',
          author: 'Arthur Beiser',
          price: 175.0,
          originalPrice: 350.0,
          condition: 'Like New',
          rating: '4.9',
          soldCount: 55,
          imagePath: 'assets/images/books/physics.webp',
          category: 'Textbooks',
          description: 'Standard university physics textbook covering relativity and quantum theory.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_medical_physiology',
          title: 'Guyton and Hall Medical Physiology',
          author: 'John E. Hall',
          price: 450.0,
          originalPrice: 899.0,
          condition: 'Like New',
          rating: '4.9',
          soldCount: 42,
          imagePath: 'assets/images/books/accounts.jpg',
          category: 'Medical',
          description: 'The golden standard of medical physiology learning.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_corporate_accounting',
          title: 'Corporate Accounting',
          author: 'Dr. P. C. Tulsian',
          price: 160.0,
          originalPrice: 320.0,
          condition: 'Good',
          rating: '4.6',
          soldCount: 88,
          imagePath: 'assets/images/books/accounts.jpg',
          category: 'Textbooks',
          description: 'Advanced accounting concepts for commerce undergraduates.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_python',
          title: 'Python Programming',
          author: 'R. N. Hyper',
          price: 200.0,
          originalPrice: 399.0,
          condition: 'Like New',
          rating: '4.7',
          soldCount: 150,
          imagePath: 'assets/images/books/python.jpg',
          category: 'Engineering',
          description: 'Hands-on guide to programming in Python with code examples.',
          sellerName: 'Aryan',
        ),
        const BookModel(
          id: 'book_rich_dad',
          title: 'Rich Dad Poor Dad',
          author: 'Robert T. Kiyosaki',
          price: 199.0,
          originalPrice: 399.0,
          condition: 'Like New',
          rating: '4.8',
          soldCount: 56,
          imagePath: 'assets/images/books/rich_dad.jpg',
          category: 'Self Help',
          description: 'What the rich teach their kids about money that the poor and middle class do not.',
          sellerName: 'Aryan',
        ),
      ];

      for (final book in allBooks) {
        await _booksCol.doc(book.id).set(book.toMap(), SetOptions(merge: true));
      }
    } catch (e) {
      // In case of network delay or permission constraints
    }
  }

  // ================= ORDERS CRUD =================

  /// Place a new order
  Future<String> createOrder(OrderModel order) async {
    final docRef = order.id.isNotEmpty ? _ordersCol.doc(order.id) : _ordersCol.doc();
    final orderData = order.copyWith(id: docRef.id).toMap();
    await docRef.set(orderData);
    return docRef.id;
  }

  /// Stream orders for a specific buyer
  Stream<List<OrderModel>> streamUserOrders(String userId) {
    return _ordersCol
        .where('buyerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data(), docId: doc.id))
          .toList();
    });
  }

  /// Get user orders once
  Future<List<OrderModel>> getUserOrders(String userId) async {
    final snapshot =
        await _ordersCol.where('buyerId', isEqualTo: userId).get();
    return snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data(), docId: doc.id))
        .toList();
  }

  /// Stream all orders (for Admin/Seller)
  Stream<List<OrderModel>> streamAllOrders() {
    return _ordersCol.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data(), docId: doc.id))
          .toList();
    });
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    await _ordersCol.doc(orderId).update({'status': status});
  }

  // ================= USERS CRUD =================

  /// Save or update user profile
  Future<void> saveUser(UserModel user) async {
    await _usersCol.doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  }

  /// Get user profile
  Future<UserModel?> getUser(String uid) async {
    final doc = await _usersCol.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!, docId: doc.id);
    }
    return null;
  }
}
