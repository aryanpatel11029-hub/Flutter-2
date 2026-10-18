import 'package:flutter/material.dart';
import 'saler_profile_page.dart';

class BookDetailPage extends StatefulWidget {
  final String title;
  final String author;
  final String price;
  final String originalPrice;
  final String discount;
  final String condition;
  final String category;
  final String language;
  final String edition;
  final String imagePath;
  final String rating;
  final int reviewsCount;
  final String sellerName;
  final String sellerInitials;
  final String sellerLocation;
  final String sellerNote;
  final bool isFavorite;

  const BookDetailPage({
    super.key,
    this.title = 'Physics',
    this.author = 'NCERT',
    this.price = '₹100',
    this.originalPrice = '₹180',
    this.discount = '40% OFF',
    this.condition = 'Like New',
    this.category = 'Novels',
    this.language = 'English',
    this.edition = '2023',
    this.imagePath = 'assets/images/physics.webp',
    this.rating = '4.8',
    this.reviewsCount = 98,
    this.sellerName = 'Sarthak Lila',
    this.sellerInitials = 'SL',
    this.sellerLocation = 'Verified Student • Rajkot, Gujarat',
    this.sellerNote =
        '"College student selling my personal copy. No torn pages, no pen/highlighter marks. Original binding is in excellent condition. Available for pickup or local delivery."',
    this.isFavorite = true,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late bool _isFavorite;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  Map<String, dynamic> _getResolvedData() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return {
      'title': routeArgs?['title'] ?? widget.title,
      'author': routeArgs?['author'] ?? widget.author,
      'price': routeArgs?['price'] ?? widget.price,
      'originalPrice': routeArgs?['originalPrice'] ?? widget.originalPrice,
      'discount': routeArgs?['discount'] ?? widget.discount,
      'condition': routeArgs?['condition'] ?? widget.condition,
      'category': routeArgs?['category'] ?? widget.category,
      'language': routeArgs?['language'] ?? widget.language,
      'edition': routeArgs?['edition'] ?? widget.edition,
      'imagePath': routeArgs?['imagePath'] ?? widget.imagePath,
      'rating': routeArgs?['rating'] ?? widget.rating,
      'reviewsCount': routeArgs?['reviewsCount'] ?? widget.reviewsCount,
      'sellerName': routeArgs?['sellerName'] ?? widget.sellerName,
      'sellerInitials': routeArgs?['sellerInitials'] ?? widget.sellerInitials,
      'sellerLocation': routeArgs?['sellerLocation'] ?? widget.sellerLocation,
      'sellerNote': routeArgs?['sellerNote'] ?? widget.sellerNote,
    };
  }

  Widget _buildSpecCard({
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _getResolvedData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Book Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: _isFavorite
                  ? const Color(0xFFEF4444)
                  : Colors.grey.shade400,
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.black87,
              size: 22,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing link copied!')),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Book Image Banner
              Center(
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      data['imagePath'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 160,
                          height: 220,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.book_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Carousel Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isActive = index == _currentImageIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 22 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF4F39E3)
                            : const Color(0xFFD6D3E8),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 22),

              // Book Title & Author
              Text(
                data['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data['author'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),

              // Price, Original Price, Discount & Negotiable Tag
              Row(
                children: [
                  Text(
                    data['price'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F39E3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data['originalPrice'],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Discount Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F8F0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data['discount'],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Negotiable Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EEFB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check,
                          size: 14,
                          color: Color(0xFF4F39E3),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Negotiable',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F39E3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 4 Specification Cards
              Row(
                children: [
                  Expanded(
                    child: _buildSpecCard(
                      label: 'Condition',
                      value: data['condition'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSpecCard(
                      label: 'Category',
                      value: data['category'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSpecCard(
                      label: 'Language',
                      value: data['language'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSpecCard(
                      label: 'Edition',
                      value: data['edition'],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Seller's Note Section
              const Text(
                "Seller's Note",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data['sellerNote'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Seller Card
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalerProfilePage(
                        sellerName: data['sellerName'],
                        sellerInitials: data['sellerInitials'],
                        rating: data['rating'],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4FB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                child: Row(
                  children: [
                    // Avatar with online green dot
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xFF4F39E3),
                          child: Text(
                            data['sellerInitials'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),

                    // Seller info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['sellerName'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data['sellerLocation'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Seller Rating
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${data['rating']} ',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '(${data['reviewsCount']})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          children: [
            // Chat Seller Button
            Expanded(
              child: SizedBox(
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF4F39E3),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Starting chat with ${data['sellerName']}...'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Color(0xFF4F39E3),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Chat Seller',
                        style: TextStyle(
                          color: Color(0xFF4F39E3),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Buy Now Button
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F39E3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Proceeding to buy ${data['title']} for ${data['price']}!'),
                      ),
                    );
                  },
                  child: Text(
                    'Buy Now (${data['price']})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
}
