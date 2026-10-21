import 'package:flutter/material.dart';

import 'search_page.dart';
import 'book_detail_page.dart';
import 'sell_book_page.dart';
import 'cart_page.dart';
import 'saler_profile_page.dart';
import 'view_all_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';

class BookItem {
  final String title;
  final String author;
  final String price;
  final String originalPrice;
  final String condition;
  final String rating;
  final int soldCount;
  final String imagePath;
  final String category;
  bool isFavorite;

  BookItem({
    required this.title,
    required this.author,
    required this.price,
    required this.originalPrice,
    required this.condition,
    required this.rating,
    required this.soldCount,
    required this.imagePath,
    this.category = 'Textbooks',
    this.isFavorite = false,
  });
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;

  final List<String> _categories = [
    'All',
    'Textbooks',
    'Medical',
    'Novels',
    'Comics',
  ];

  late final List<BookItem> _recommendedBooks;
  late final List<BookItem> _exploreMoreBooks;

  @override
  void initState() {
    super.initState();
    _recommendedBooks = [
      BookItem(
        title: 'Accounts',
        author: 'NCERT',
        price: '₹50',
        originalPrice: '₹110',
        condition: 'Normal',
        rating: '4.8',
        soldCount: 120,
        imagePath: 'assets/images/accounts.jpg',
        category: 'Textbooks',
        isFavorite: true,
      ),
      BookItem(
        title: 'Physics',
        author: 'NCERT',
        price: '₹100',
        originalPrice: '₹180',
        condition: 'Good',
        rating: '4.9',
        soldCount: 85,
        imagePath: 'assets/images/physics.webp',
        category: 'Textbooks',
        isFavorite: false,
      ),
      BookItem(
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        price: '₹200',
        originalPrice: '₹399',
        condition: 'Like New',
        rating: '4.7',
        soldCount: 150,
        imagePath: 'assets/images/money.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      BookItem(
        title: 'Dune',
        author: 'Frank Herbert',
        price: '₹250',
        originalPrice: '₹499',
        condition: 'Like New',
        rating: '4.8',
        soldCount: 95,
        imagePath: 'assets/images/dune.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      BookItem(
        title: 'One Piece (Vol. 61)',
        author: 'Eiichiro Oda',
        price: '₹199',
        originalPrice: '₹350',
        condition: 'Like New',
        rating: '5.0',
        soldCount: 310,
        imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
        category: 'Comics',
        isFavorite: true,
      ),
      BookItem(
        title: 'Gujarati Sarthi',
        author: 'Cal Newport',
        price: '₹50',
        originalPrice: '₹100',
        condition: 'Normal',
        rating: '4.5',
        soldCount: 78,
        imagePath: 'assets/images/gujarti_starthi.jpg',
        category: 'Textbooks',
        isFavorite: false,
      ),
      BookItem(
        title: 'Human Anatomy & Physiology',
        author: 'Dr. Elaine Marieb',
        price: '₹320',
        originalPrice: '₹650',
        condition: 'Good',
        rating: '4.8',
        soldCount: 64,
        imagePath: 'assets/images/physics.webp',
        category: 'Medical',
        isFavorite: false,
      ),
    ];

    _exploreMoreBooks = [
      BookItem(
        title: 'Attack on Titan',
        author: 'Hajime Isayama',
        price: '₹150',
        originalPrice: '₹300',
        condition: 'Poor',
        rating: '4.7',
        soldCount: 210,
        imagePath: 'assets/images/aot.jpg',
        category: 'Comics',
        isFavorite: true,
      ),
      BookItem(
        title: 'Demon Slayer',
        author: 'Koyoharu Gotouge',
        price: '₹180',
        originalPrice: '₹299',
        condition: 'Good',
        rating: '4.9',
        soldCount: 180,
        imagePath: 'assets/images/demon_slayer.jpg',
        category: 'Comics',
        isFavorite: false,
      ),
      BookItem(
        title: 'It Ends with Us',
        author: 'Colleen Hoover',
        price: '₹220',
        originalPrice: '₹399',
        condition: 'Normal',
        rating: '4.6',
        soldCount: 145,
        imagePath: 'assets/images/it_end_us.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      BookItem(
        title: 'How to Kill Your Family',
        author: 'Bella Mackie',
        price: '₹210',
        originalPrice: '₹450',
        condition: 'Good',
        rating: '4.5',
        soldCount: 112,
        imagePath: 'assets/images/how_to_kill_men.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      BookItem(
        title: 'Concepts of Modern Physics',
        author: 'Arthur Beiser',
        price: '₹175',
        originalPrice: '₹350',
        condition: 'Like New',
        rating: '4.9',
        soldCount: 55,
        imagePath: 'assets/images/physics.webp',
        category: 'Textbooks',
        isFavorite: false,
      ),
      BookItem(
        title: 'Guyton and Hall Medical Physiology',
        author: 'John E. Hall',
        price: '₹450',
        originalPrice: '₹899',
        condition: 'Like New',
        rating: '4.9',
        soldCount: 42,
        imagePath: 'assets/images/accounts.jpg',
        category: 'Medical',
        isFavorite: false,
      ),
      BookItem(
        title: 'Corporate Accounting',
        author: 'Dr. P. C. Tulsian',
        price: '₹160',
        originalPrice: '₹320',
        condition: 'Good',
        rating: '4.6',
        soldCount: 88,
        imagePath: 'assets/images/accounts.jpg',
        category: 'Textbooks',
        isFavorite: false,
      ),
      BookItem(
        title: 'Python Programming',
        author: 'R. N. Hyper',
        price: '₹200',
        originalPrice: '₹399',
        condition: 'Like New',
        rating: '4.7',
        soldCount: 150,
        imagePath: 'assets/images/python.jpg',
        category: 'Textbooks',
        isFavorite: false,
      ),
    ];
  }

  Widget _buildBookCard(BookItem book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: book.title,
              author: book.author,
              price: book.price,
              originalPrice: book.originalPrice,
              condition: book.condition,
              category: book.category,
              imagePath: book.imagePath,
              rating: book.rating,
              isFavorite: book.isFavorite,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container with Badges
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 0.82,
                  child: Image.asset(
                    book.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.menu_book,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Condition Badge (Top-Left)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xA6000000),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      book.condition,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Favorite Heart Button (Top-Right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        book.isFavorite = !book.isFavorite;
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xD9FFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 18,
                        color: book.isFavorite
                            ? const Color(0xFFEF4444)
                            : const Color(0xFFCBD5E1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),

          // Author / Publisher
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),

          // Price Row
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
              const SizedBox(width: 8),
              Text(
                book.originalPrice,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Rating and Sold Count
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 15),
              const SizedBox(width: 4),
              Text(
                book.rating,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${book.soldCount} sold)',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookGrid(List<BookItem> books) {
    final List<Widget> rows = [];
    for (int i = 0; i < books.length; i += 2) {
      final first = books[i];
      final second = (i + 1 < books.length) ? books[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildBookCard(first)),
            const SizedBox(width: 16),
            Expanded(
              child: second != null
                  ? _buildBookCard(second)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
      if (i + 2 < books.length) {
        rows.add(const SizedBox(height: 16));
      }
    }
    return Column(children: rows);
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewAllPage(pageTitle: title),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'See All',
            style: TextStyle(
              color: Color(0xFF4F39E3),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  List<BookItem> _getFilteredBooks(List<BookItem> books) {
    if (_selectedCategoryIndex == 0) return books;
    final selectedCategory = _categories[_selectedCategoryIndex];
    return books
        .where(
          (b) => b.category.toLowerCase() == selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecommended = _getFilteredBooks(_recommendedBooks);
    final filteredExplore = _getFilteredBooks(_exploreMoreBooks);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Greeting Header with Wishlist Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Hello, Aryan ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text('👋', style: TextStyle(fontSize: 22)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find your next favorite read today',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishlistPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F6FD),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFEF4444),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Search Bar & Filter Button
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Search by title, author, ISBN...',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F39E3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 18,
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 12,
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 15,
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Horizontal Category Chips
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedCategoryIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF4F39E3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4F39E3)
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),

              // Sell Your Books Banner
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellBookPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F39E3), Color(0xFF6D57FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F39E3).withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.sell_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sell Your Old Books',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Earn cash in 4 easy steps',
                              style: TextStyle(
                                color: Color(0xFFE0E7FF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Sell Now',
                          style: TextStyle(
                            color: Color(0xFF4F39E3),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // "Recommended for you" Section
              if (filteredRecommended.isNotEmpty) ...[
                _buildSectionHeader('Recommended for you'),
                const SizedBox(height: 14),
                _buildBookGrid(filteredRecommended),
                const SizedBox(height: 24),
              ],

              // "Explore More" Section
              if (filteredExplore.isNotEmpty) ...[
                _buildSectionHeader('Explore More'),
                const SizedBox(height: 14),
                _buildBookGrid(filteredExplore),
                const SizedBox(height: 20),
              ],

              if (filteredRecommended.isEmpty && filteredExplore.isEmpty) ...[
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 48,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No books found in this category',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar matching design
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
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
            _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
            // Search Tab
            _buildNavItem(
              index: 1,
              icon: Icons.search_rounded,
              label: 'Search',
            ),
            // Center Sell Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SellBookPage()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4F39E3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 26),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Sell',
                    style: TextStyle(
                      color: Color(0xFF4F39E3),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Cart Tab
            _buildNavItem(
              index: 3,
              icon: Icons.shopping_cart_outlined,
              label: 'Cart',
            ),
            // Profile Tab
            _buildNavItem(
              index: 4,
              icon: Icons.person_outline_rounded,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedNavIndex == index;
    final color = isSelected ? const Color(0xFF4F39E3) : Colors.grey.shade600;

    return GestureDetector(
      onTap: () {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchPage()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          );
        } else {
          setState(() => _selectedNavIndex = index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
