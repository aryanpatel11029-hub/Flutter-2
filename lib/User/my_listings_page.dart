import 'package:flutter/material.dart';

import 'sell_book_page.dart';

class ListingItemModel {
  final String id;
  final String title;
  final String author;
  final String price;
  final String condition;
  final String imagePath;
  final String status; // 'Active', 'Sold', 'Draft'

  ListingItemModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.condition,
    required this.imagePath,
    required this.status,
  });
}

class MyListingsPage extends StatefulWidget {
  const MyListingsPage({super.key});

  @override
  State<MyListingsPage> createState() => _MyListingsPageState();
}

class _MyListingsPageState extends State<MyListingsPage> {
  String _selectedTab = 'Active';

  final List<String> _tabs = ['Active', 'Sold', 'Draft'];

  late List<ListingItemModel> _listings;

  @override
  void initState() {
    super.initState();
    _listings = [
      ListingItemModel(
        id: '1',
        title: 'Maths class 10',
        author: 'NCERT',
        price: '₹45',
        condition: 'Good',
        imagePath: 'assets/images/accounts.jpg',
        status: 'Active',
      ),
      ListingItemModel(
        id: '2',
        title: 'Demon Slayer Manga part-1',
        author: 'Koyoharu Gotouge',
        price: '₹120',
        condition: 'Good',
        imagePath: 'assets/images/demon_slayer.jpg',
        status: 'Active',
      ),
      ListingItemModel(
        id: '3',
        title: 'The Self-Discipline Manual',
        author: 'Cal Newport',
        price: '₹165',
        condition: 'Good',
        imagePath: 'assets/images/self_discipline.jpg',
        status: 'Active',
      ),
      ListingItemModel(
        id: '4',
        title: 'Rich Dad Poor Dad',
        author: 'Robert Kiyosaki',
        price: '₹200',
        condition: 'Normal',
        imagePath: 'assets/images/rich_dad.jpg',
        status: 'Sold',
      ),
      ListingItemModel(
        id: '5',
        title: 'Python Crash Course',
        author: 'Eric Matthes',
        price: '₹250',
        condition: 'Like New',
        imagePath: 'assets/images/python.jpg',
        status: 'Draft',
      ),
    ];
  }

  List<ListingItemModel> get _filteredListings {
    return _listings.where((item) => item.status == _selectedTab).toList();
  }

  void _confirmDeleteListing(ListingItemModel item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text('Delete Listing'),
        content: Text('Are you sure you want to remove "${item.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _listings.removeWhere((l) => l.id == item.id);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Listing removed successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'My listings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Tabs: Active, Sold, Draft
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: _tabs.map((tab) {
                final isSelected = _selectedTab == tab;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedTab = tab);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4F39E3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4F39E3)
                              : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Listings List
          Expanded(
            child: _filteredListings.isEmpty
                ? Center(
                    child: Text(
                      'No $_selectedTab listings found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredListings.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final item = _filteredListings[index];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.025),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Book cover
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item.imagePath,
                                    width: 58,
                                    height: 76,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, _, __) => Container(
                                      width: 58,
                                      height: 76,
                                      color: const Color(0xFFF1F5F9),
                                      child: const Icon(
                                        Icons.menu_book_rounded,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Title, Author, Price
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: const TextStyle(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.author,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.price,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F39E3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Delete cross icon
                                GestureDetector(
                                  onTap: () => _confirmDeleteListing(item),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEE2E2)
                                          .withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 16,
                                      color: Color(0xFFEF4444),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade100,
                            ),
                            const SizedBox(height: 8),

                            // Condition: Good
                            Text(
                              'Condition: ${item.condition}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Bottom Button: Add New Listing
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellBookPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F39E3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Add New Listing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
