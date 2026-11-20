import 'dart:io';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  Future<String> uploadBookImage(File file, {required String bookId}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return 'assets/images/books/book_cover.jpg';
  }

  Future<String> uploadProfileImage(File file, {required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return 'assets/images/branding/brand_logo.png';
  }
}
