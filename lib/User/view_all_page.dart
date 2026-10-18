import 'package:flutter/material.dart';

import 'book_detail_page.dart';
import 'cart_page.dart';
import 'saler_profile_page.dart';
import 'search_page.dart';
import 'home.dart';

class ViewAllBookItem {
  final String title;
  final String author;
  final String price;
  final String rating;
  final String imagePath;
  final String category;
  bool isFavorite;

  ViewAllBookItem({
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.category,
    this.isFavorite = false,
  });
}

class ViewAllPage extends StatefulWidget {
  final String pageTitle;

  const ViewAllPage({
    super.key,
    this.pageTitle = 'All Books',
  });

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  late final List<ViewAllBookItem> _books;

  @override
  void initState() {
    super.initState();
    _books = [
      ViewAllBookItem(
        title: 'Gujarati Sarthi',
        author: 'Cal Newport',
        price: '₹50',
        rating: '4.5',
        imagePath: 'assets/images/gujarti_starthi.jpg',
        category: 'Textbooks',
        isFavorite: true,
      ),
      ViewAllBookItem(
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        price: '₹200',
        rating: '4.6',
        imagePath: 'assets/images/money.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      ViewAllBookItem(
        title: 'Physics',
        author: 'Robin Sharma',
        price: '₹150',
        rating: '4.4',
        imagePath: 'assets/images/physics.webp',
        category: 'Textbooks',
        isFavorite: true,
      ),
      ViewAllBookItem(
        title: 'Atomic Habits',
        author: 'James Clear',
        price: '₹100',
        rating: '4.6',
        imagePath: 'assets/images/aot.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      ViewAllBookItem(
        title: 'One Piece',
        author: 'Robin Sharma',
        price: '₹60',
        rating: '4.4',
        imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
        category: 'Comics',
        isFavorite: true,
      ),
      ViewAllBookItem(
        title: 'The Self Discipline',
        author: 'Robin Sharma',
        price: '₹120',
        rating: '4.4',
        imagePath: 'assets/images/self_discipline.jpg',
        category: 'Novels',
        isFavorite: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Back Chevron Row matching design
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF1E293B),
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Book List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                itemCount: _books.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 22),
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return _buildBookRow(book);
                },
              ),
            ),
          ],
        ),
      ),

      // 4-Tab Bottom Navigation Bar matching design
      bottomNavigationBar: Container(
        height: 72,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Tab
            _buildNavItem(
              index: 0,
              customIcon: const Icon(
                Icons.home_outlined,
                size: 26,
                color: Color(0xFF64748B),
              ),
              label: 'Home',
              isSelected: false,
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserHomePage(),
                    ),
                  );
                }
              },
            ),

            // Search Tab (Active with purple circle)
            _buildNavItem(
              index: 1,
              customIcon: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF4F39E3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              label: 'Search',
              isSelected: true,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),

            // Cart Tab
            _buildNavItem(
              index: 2,
              customIcon: const Icon(
                Icons.shopping_cart_outlined,
                size: 25,
                color: Color(0xFF64748B),
              ),
              label: 'Cart',
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),

            // Profile Tab
            _buildNavItem(
              index: 3,
              customIcon: const Icon(
                Icons.person_outline_rounded,
                size: 26,
                color: Color(0xFF64748B),
              ),
              label: 'Profile',
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalerProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookRow(ViewAllBookItem book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: book.title,
              author: book.author,
              price: book.price,
              rating: book.rating,
              imagePath: book.imagePath,
              category: book.category,
              isFavorite: book.isFavorite,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book Cover Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 70,
              height: 96,
              child: Image.asset(
                book.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.book, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Book Details (Title, Author, Price, Rating)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 10),
                // Price & Star Rating Row
                Row(
                  children: [
                    Text(
                      book.price,
                      style: const TextStyle(
                        color: Color(0xFF4F39E3),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      book.rating,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Favorite Heart Button (Red when true, Light Grey when false)
          GestureDetector(
            onTap: () {
              setState(() {
                book.isFavorite = !book.isFavorite;
              });
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFFAF6F8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  size: 19,
                  color: book.isFavorite
                      ? const Color(0xFFEF4444)
                      : const Color(0xFFD1D5DB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget customIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final textColor = isSelected
        ? const Color(0xFF4F39E3)
        : const Color(0xFF64748B);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customIcon,
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
