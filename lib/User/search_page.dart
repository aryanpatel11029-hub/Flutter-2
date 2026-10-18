import 'package:flutter/material.dart';
import 'book_detail_page.dart';

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
  int _selectedNavIndex = 1; // 1 = Search Tab active

  final List<String> _categories = [
    'All',
    'Engineering',
    'Medical',
    'Novels',
    'More',
  ];

  late List<SearchBookItem> _allBooks;
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
    ];

    _filteredBooks = List.from(_allBooks);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterBooks();
  }

  void _filterBooks() {
    final query = _searchController.text.trim().toLowerCase();
    final selectedCategory = _categories[_selectedCategoryIndex];

    setState(() {
      _filteredBooks = _allBooks.where((book) {
        final matchesQuery = query.isEmpty ||
            book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);

        final matchesCategory = selectedCategory == 'All' ||
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Row & Filter Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                            color: Colors.grey.shade500,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by title, author, ISBN...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Button with 3 horizontal lines
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

            // Horizontal Category Chips
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
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
            ),

            // Book List
            Expanded(
              child: _filteredBooks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      itemCount: _filteredBooks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final book = _filteredBooks[index];
                        return _buildSearchBookItem(book);
                      },
                    ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar matching design
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
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Search Tab (Active)
            _buildNavItem(
              index: 1,
              icon: Icons.search_rounded,
              label: 'Search',
              onTap: () {},
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
              onTap: () {
                setState(() => _selectedNavIndex = 3);
              },
            ),
            // Profile Tab
            _buildNavItem(
              index: 4,
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              onTap: () {
                setState(() => _selectedNavIndex = 4);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBookItem(SearchBookItem book) {
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
            width: 72,
            height: 98,
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

        // Book Details
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
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                book.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 10),
              // Price and Rating Row
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
                      color: Colors.black87,
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
            child: Icon(
              Icons.favorite,
              size: 20,
              color: book.isFavorite
                  ? const Color(0xFFEF4444)
                  : const Color(0xFFCBD5E1),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedNavIndex == index;
    final color = isSelected ? const Color(0xFF4F39E3) : Colors.grey.shade600;

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
