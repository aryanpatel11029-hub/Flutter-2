import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'book_detail_page.dart';

class WishlistItemModel {
  final String id;
  final String title;
  final String author;
  final int price;
  final String imagePath;
  final String category;

  WishlistItemModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<WishlistItemModel> _wishlistItems = [
    WishlistItemModel(
      id: '1',
      title: 'One Piece',
      author: 'Hajime Isayama',
      price: 150,
      imagePath: 'assets/images/One_Piece,_Volume_61_Cover_.jpg',
      category: 'Comics',
    ),
    WishlistItemModel(
      id: '2',
      title: 'Rich Dad Poor Dad',
      author: 'Robert Kiyosaki',
      price: 200,
      imagePath: 'assets/images/rich_dad.jpg',
      category: 'Novels',
    ),
    WishlistItemModel(
      id: '3',
      title: 'Dune',
      author: 'Frank Herbert',
      price: 220,
      imagePath: 'assets/images/dune.jpg',
      category: 'Novels',
    ),
  ];

  void _removeItem(int index) {
    setState(() {
      _wishlistItems.removeAt(index);
    });
  }

  void _moveAllToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header with '<' and 'Wishlist'
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 20, 12),
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
                    'Wishlist',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),

            // Wishlist Items List
            Expanded(
              child: _wishlistItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Your Wishlist is Empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Explore books and tap the heart to save them!',
                            style: TextStyle(
                              fontSize: 14,
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
                        vertical: 8.0,
                      ),
                      itemCount: _wishlistItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 22),
                      itemBuilder: (context, index) {
                        final item = _wishlistItems[index];
                        return _buildWishlistItem(item, index);
                      },
                    ),
            ),

            // Bottom Sticky Button: Move All Carts
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _wishlistItems.isNotEmpty ? _moveAllToCart : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F39E3),
                    disabledBackgroundColor: Colors.grey.shade300,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Move All Carts',
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
      ),
    );
  }

  Widget _buildWishlistItem(WishlistItemModel item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: item.title,
              author: item.author,
              price: '₹${item.price}',
              imagePath: item.imagePath,
              category: item.category,
              isFavorite: true,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book Cover
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 70,
              height: 96,
              child: Image.asset(
                item.imagePath,
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

          // Details (Title, Author, Price)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
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
                  item.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 10),
                Text(
                  '₹${item.price}',
                  style: const TextStyle(
                    color: Color(0xFF4F39E3),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Delete/Trash Button with light pink background
          GestureDetector(
            onTap: () => _removeItem(index),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFFFEDEC),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
