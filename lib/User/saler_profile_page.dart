import 'package:flutter/material.dart';
import 'book_detail_page.dart';

class SellerBookItem {
  final String title;
  final String author;
  final String price;
  final String originalPrice;
  final String condition;
  final String imagePath;
  final String rating;
  final String category;

  const SellerBookItem({
    required this.title,
    required this.author,
    required this.price,
    required this.originalPrice,
    required this.condition,
    required this.imagePath,
    this.rating = '4.8',
    this.category = 'Textbooks',
  });
}

class SalerProfilePage extends StatefulWidget {
  final String pageTitle;
  final String sellerName;
  final String sellerInitials;
  final String joinedDate;
  final String booksCount;
  final String soldCount;
  final String rating;
  final String aboutText;
  final bool initialFollowing;
  final List<SellerBookItem>? listedBooks;

  const SalerProfilePage({
    super.key,
    this.pageTitle = 'Book Seler Profile',
    this.sellerName = 'Sarthak Lila',
    this.sellerInitials = 'SL',
    this.joinedDate = 'Since May 2022',
    this.booksCount = '120',
    this.soldCount = '98',
    this.rating = '4.8',
    this.aboutText = 'College student. Selling books in good condition.',
    this.initialFollowing = false,
    this.listedBooks,
  });

  @override
  State<SalerProfilePage> createState() => _SalerProfilePageState();
}

typedef SellerProfilePage = SalerProfilePage;

class _SalerProfilePageState extends State<SalerProfilePage> {
  late bool _isFollowing;

  final List<SellerBookItem> _defaultBooks = const [
    SellerBookItem(
      title: 'Accounts',
      author: 'Paulo Coelho',
      price: '₹50',
      originalPrice: '₹110',
      condition: 'Like New',
      imagePath: 'assets/images/accounts.jpg',
      rating: '4.8',
      category: 'Novels',
    ),
    SellerBookItem(
      title: 'Gujarati Sarthi',
      author: 'NCERT Class 12',
      price: '₹60',
      originalPrice: '₹180',
      condition: 'Good',
      imagePath: 'assets/images/gujarti_starthi.jpg',
      rating: '4.7',
      category: 'Textbooks',
    ),
    SellerBookItem(
      title: 'Physics',
      author: 'Standard 12',
      price: '₹100',
      originalPrice: '₹160',
      condition: 'Like New',
      imagePath: 'assets/images/physics.webp',
      rating: '4.9',
      category: 'Textbooks',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.initialFollowing;
  }

  Map<String, dynamic> _resolveData() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return {
      'pageTitle': routeArgs?['pageTitle'] ?? widget.pageTitle,
      'sellerName': routeArgs?['sellerName'] ?? widget.sellerName,
      'sellerInitials': routeArgs?['sellerInitials'] ?? widget.sellerInitials,
      'joinedDate': routeArgs?['joinedDate'] ?? widget.joinedDate,
      'booksCount': routeArgs?['booksCount'] ?? widget.booksCount,
      'soldCount': routeArgs?['soldCount'] ?? widget.soldCount,
      'rating': routeArgs?['rating'] ?? widget.rating,
      'aboutText': routeArgs?['aboutText'] ?? widget.aboutText,
      'listedBooks':
          routeArgs?['listedBooks'] as List<SellerBookItem>? ??
          widget.listedBooks ??
          _defaultBooks,
    };
  }

  void _toggleFollow(String sellerName) {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowing
              ? 'You are now following $sellerName'
              : 'Unfollowed $sellerName',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _openChat(String sellerName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting chat with $sellerName...'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _navigateToBookDetail(SellerBookItem book, String sellerName, String sellerInitials) {
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
          category: book.category,
          sellerName: sellerName,
          sellerInitials: sellerInitials,
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(
    SellerBookItem book,
    String sellerName,
    String sellerInitials,
  ) {
    return InkWell(
      onTap: () => _navigateToBookDetail(book, sellerName, sellerInitials),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 104,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 0.74,
                child: Image.asset(
                  book.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Book Title
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),

            // Author / Subtitle
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 4),

            // Price Row
            Row(
              children: [
                Text(
                  book.price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F39E3),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  book.originalPrice,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Condition Tag Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF4EEFF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  book.condition,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A3AE8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _resolveData();
    final List<SellerBookItem> books = data['listedBooks'];
    final String sellerName = data['sellerName'];
    final String sellerInitials = data['sellerInitials'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 19,
          ),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          data['pageTitle'],
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Seller Profile Avatar and Name Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF4F39E3),
                    child: Text(
                      sellerInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sellerName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        data['joinedDate'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Thin Divider
              Divider(
                color: Colors.grey.shade200,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 18),

              // Stats Row (Books, Sold, Rating)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(
                    value: data['booksCount'],
                    label: 'Books',
                  ),
                  Container(
                    width: 1,
                    height: 28,
                    color: Colors.grey.shade200,
                  ),
                  _buildStatColumn(
                    value: data['soldCount'],
                    label: 'Sold',
                  ),
                  Container(
                    width: 1,
                    height: 28,
                    color: Colors.grey.shade200,
                  ),
                  _buildStatColumn(
                    value: data['rating'],
                    label: 'Rating',
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // About Section
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data['aboutText'],
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),

              // Listed Books Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Listed Books',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Viewing all listed books'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4F39E3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Listed Books List
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: books.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _buildBookCard(
                      books[index],
                      sellerName,
                      sellerInitials,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Action Bar: Follow & Chat Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Follow Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF4F39E3),
                        width: 1.5,
                      ),
                      backgroundColor: _isFollowing
                          ? const Color(0xFFF4EEFF)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _toggleFollow(sellerName),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isFollowing) ...[
                          const Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: Color(0xFF4F39E3),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F39E3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Chat Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F39E3),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _openChat(sellerName),
                    child: const Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 15,
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
      ),
    );
  }
}
