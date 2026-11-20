import 'package:flutter/material.dart';

import 'book_detail_page.dart';
import 'cart_page.dart';
import 'seller_profile_page.dart';
import 'sell_book_page.dart';
import 'home_page.dart';

class SearchBookItem {
  final String title;
  final String author;
  final String price;
  final String rating;
  final String imagePath;
  final String category;
  bool isFavorite;

  SearchBookItem({
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.category,
    this.isFavorite = false,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All',
    'Engineering',
    'Medical',
    'Novels',
    'More',
  ];

  late final List<SearchBookItem> _allBooks;
  List<SearchBookItem> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _allBooks = [
      SearchBookItem(
        title: 'Gujarati Sarthi',
        author: 'Cal Newport',
        price: '₹50',
        rating: '4.5',
        imagePath: 'assets/images/gujarti_starthi.jpg',
        category: 'More',
        isFavorite: true,
      ),
      SearchBookItem(
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        price: '₹200',
        rating: '4.6',
        imagePath: 'assets/images/money.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      SearchBookItem(
        title: 'Physics',
        author: 'Robin Sharma',
        price: '₹150',
        rating: '4.4',
        imagePath: 'assets/images/physics.webp',
        category: 'Engineering',
        isFavorite: true,
      ),
      SearchBookItem(
        title: 'Attack on Titan',
        author: 'James Clear',
        price: '₹180',
        rating: '4.6',
        imagePath: 'assets/images/aot.jpg',
        category: 'Novels',
        isFavorite: false,
      ),
      SearchBookItem(
        title: 'One Piece',
        author: 'Robin Sharma',
        price: '₹60',
        rating: '4.4',
        imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
        category: 'More',
        isFavorite: true,
      ),
      SearchBookItem(
        title: 'The Self Discipline',
        author: 'Robin Sharma',
        price: '₹120',
        rating: '4.4',
        imagePath: 'assets/images/self_discipline.jpg',
        category: 'Novels',
        isFavorite: true,
      ),
      SearchBookItem(
        title: 'Concepts of Modern Physics',
        author: 'Arthur Beiser',
        price: '₹175',
        rating: '4.9',
        imagePath: 'assets/images/physics.webp',
        category: 'Engineering',
        isFavorite: false,
      ),
      SearchBookItem(
        title: 'Human Anatomy & Physiology',
        author: 'Dr. Elaine Marieb',
        price: '₹320',
        rating: '4.8',
        imagePath: 'assets/images/physics.webp',
        category: 'Medical',
        isFavorite: false,
      ),
    ];
    _filteredBooks = List.from(_allBooks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    final query = _searchController.text.trim().toLowerCase();
    final selectedCategory = _categories[_selectedCategoryIndex];

    setState(() {
      _filteredBooks = _allBooks.where((book) {
        final matchesQuery =
            query.isEmpty ||
            book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);

        final matchesCategory =
            selectedCategory == 'All' ||
            book.category.toLowerCase() == selectedCategory.toLowerCase();

        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _filterBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar with '<' and 'Search'
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 20, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF1E293B),
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar & Filter Button Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
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
                            color: Colors.grey.shade400,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => _filterBooks(),
                              decoration: InputDecoration(
                                hintText: 'Search by title, author, ISBN...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _filterBooks();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Filter Button with 3 white lines
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
            ),
            const SizedBox(height: 16),

            // Horizontal Category Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  return GestureDetector(
                    onTap: () => _onCategorySelected(index),
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
            const SizedBox(height: 16),

            // Book List
            Expanded(
              child: _filteredBooks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 56,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No books found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 4.0,
                      ),
                      itemCount: _filteredBooks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 22),
                      itemBuilder: (context, index) {
                        final book = _filteredBooks[index];
                        return _buildBookRow(book);
                      },
                    ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar with 5 items including Center Sell (+) button
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
              icon: Icons.home_outlined,
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

            // Search Tab (Active)
            _buildNavItem(
              icon: Icons.search_rounded,
              label: 'Search',
              isSelected: true,
              onTap: () {},
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
              icon: Icons.shopping_cart_outlined,
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
              icon: Icons.person_outline_rounded,
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

  Widget _buildBookRow(SearchBookItem book) {
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

          // Favorite Heart Button
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
                      : const Color(0xFFCBD5E1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected
        ? const Color(0xFF4F39E3)
        : const Color(0xFF64748B);

    return GestureDetector(
      onTap: onTap,
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
