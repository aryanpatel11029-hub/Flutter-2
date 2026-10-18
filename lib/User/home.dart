import 'package:flutter/material.dart';
import 'search_page.dart';
import 'book_detail_page.dart';

class BookItem {
  final String title;
  final String author;
  final String price;
  final String originalPrice;
  final String condition;
  final String rating;
  final int soldCount;
  final String imagePath;
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
    'Reading',
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
                        child: Icon(Icons.menu_book, color: Colors.grey, size: 40),
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
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
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
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
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
          onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Greeting Header
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
                  Text(
                    '👋',
                    style: TextStyle(fontSize: 22),
                  ),
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
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
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
              const SizedBox(height: 24),

              // "Recommended for you" Section
              _buildSectionHeader('Recommended for you'),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBookCard(_recommendedBooks[0])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBookCard(_recommendedBooks[1])),
                ],
              ),
              const SizedBox(height: 24),

              // "Explore More" Section
              _buildSectionHeader('Explore More'),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBookCard(_exploreMoreBooks[0])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBookCard(_exploreMoreBooks[1])),
                ],
              ),
              const SizedBox(height: 20),
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
            _buildNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Home',
            ),
            // Search Tab
            _buildNavItem(
              index: 1,
              icon: Icons.search_rounded,
              label: 'Search',
            ),
            // Center Sell Button
            GestureDetector(
              onTap: () {
                setState(() => _selectedNavIndex = 2);
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 26,
                    ),
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
