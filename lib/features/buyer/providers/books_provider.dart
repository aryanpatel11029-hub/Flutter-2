import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/models/book_model.dart';
import '../../../shared/services/firestore_service.dart';

class BooksProvider extends ChangeNotifier {
  static final BooksProvider _instance = BooksProvider._internal();
  factory BooksProvider() => _instance;
  BooksProvider._internal() {
    _initFirestoreListener();
  }

  final FirestoreService _firestore = FirestoreService();
  StreamSubscription? _subscription;

  String _selectedCategory = 'All';
  String _searchQuery = '';
  final Set<String> _favoriteBookIds = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  final List<BookModel> _defaultBooks = const [
    BookModel(
      id: '1',
      title: 'Attack on Titan Vol. 1',
      author: 'Hajime Isayama',
      price: 299,
      originalPrice: 499,
      condition: 'Like New',
      rating: '4.9',
      soldCount: 42,
      imagePath: 'assets/images/books/aot.jpg',
      category: 'Comics',
    ),
    BookModel(
      id: '2',
      title: 'Demon Slayer Vol. 1',
      author: 'Koyoharu Gotouge',
      price: 249,
      originalPrice: 399,
      condition: 'Good',
      rating: '4.8',
      soldCount: 38,
      imagePath: 'assets/images/books/demon_slayer.jpg',
      category: 'Comics',
    ),
    BookModel(
      id: '3',
      title: 'Dune',
      author: 'Frank Herbert',
      price: 349,
      originalPrice: 599,
      condition: 'Very Good',
      rating: '4.7',
      soldCount: 29,
      imagePath: 'assets/images/books/dune.jpg',
      category: 'Fiction',
    ),
    BookModel(
      id: '4',
      title: 'Gujarati Sahitya Sarathi',
      author: 'Dr. Ramesh Dave',
      price: 199,
      originalPrice: 350,
      condition: 'Good',
      rating: '4.6',
      soldCount: 15,
      imagePath: 'assets/images/books/gujarati_sarthi.jpg',
      category: 'Textbooks',
    ),
    BookModel(
      id: '5',
      title: 'Rich Dad Poor Dad',
      author: 'Robert T. Kiyosaki',
      price: 199,
      originalPrice: 399,
      condition: 'Like New',
      rating: '4.8',
      soldCount: 56,
      imagePath: 'assets/images/books/rich_dad.jpg',
      category: 'Self Help',
    ),
  ];

  late List<BookModel> _books;

  void _initFirestoreListener() {
    _books = List.from(_defaultBooks);
    try {
      _subscription = _firestore.streamBooks().listen(
        (remoteBooks) {
          if (remoteBooks.isNotEmpty) {
            _books = remoteBooks;
            notifyListeners();
          }
        },
        onError: (err) {
          debugPrint('Firestore streamBooks note: $err');
        },
      );
    } catch (e) {
      debugPrint('Firestore listener error: $e');
    }
  }

  List<BookModel> get allBooks => List.unmodifiable(_books);

  List<BookModel> get filteredBooks {
    return _books.where((book) {
      final matchesCategory =
          _selectedCategory == 'All' || book.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  bool isFavorite(String bookId) => _favoriteBookIds.contains(bookId);

  void toggleFavorite(String bookId) {
    if (_favoriteBookIds.contains(bookId)) {
      _favoriteBookIds.remove(bookId);
    } else {
      _favoriteBookIds.add(bookId);
    }
    notifyListeners();
  }

  /// Add book to Cloud Firestore database
  Future<void> addBookToDatabase(BookModel book) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firestore.addBook(book);
    } catch (e) {
      debugPrint('Error writing book to Firestore: $e');
      _books.insert(0, book);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
