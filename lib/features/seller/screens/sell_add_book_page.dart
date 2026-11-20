import 'package:flutter/material.dart';

import '../models/seller_models.dart';
import '../../../../shared/models/book_model.dart';
import '../../../../shared/services/firestore_service.dart';

class SellAddBookPage extends StatefulWidget {
  final SellerBookListing? editListing;

  const SellAddBookPage({super.key, this.editListing});

  @override
  State<SellAddBookPage> createState() => _SellAddBookPageState();
}

class _SellAddBookPageState extends State<SellAddBookPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _priceController;
  late final TextEditingController _originalPriceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _isbnController;

  String _selectedCategory = 'Textbooks';
  String _selectedCondition = 'Like New';
  String _selectedImage = 'assets/images/money.jpg';
  int _stock = 1;

  final List<String> _categories = [
    'Textbooks',
    'Self Help',
    'Novels',
    'Comics',
    'Medical',
    'Engineering',
    'Fiction',
    'Business & Finance',
    'Biography',
    'Other',
  ];

  final List<String> _conditions = [
    'Brand New',
    'Like New',
    'Good',
    'Normal',
    'Acceptable',
  ];

  final List<String> _sampleImages = [
    'assets/images/money.jpg',
    'assets/images/physics.webp',
    'assets/images/accounts.jpg',
    'assets/images/dune.jpg',
    'assets/images/demon_slayer.jpg',
    'assets/images/aot.jpg',
    'assets/images/rich_dad.jpg',
    'assets/images/python.jpg',
    'assets/images/gujarti_starthi.jpg',
    'assets/images/One_Piece,_Volume_61_Cover_.jpg',
    'assets/images/how_to_kill_men.jpg',
    'assets/images/it_end_us.jpg',
  ];

  @override
  void initState() {
    super.initState();
    final edit = widget.editListing;
    _titleController = TextEditingController(text: edit?.title ?? '');
    _authorController = TextEditingController(text: edit?.author ?? '');
    _priceController = TextEditingController(
      text: edit != null ? edit.price.toStringAsFixed(0) : '',
    );
    _originalPriceController = TextEditingController(
      text: edit != null ? edit.originalPrice.toStringAsFixed(0) : '',
    );
    _descriptionController = TextEditingController(
      text:
          edit?.description ??
          'Book is in clean condition with no torn pages or missing leaves.',
    );
    _isbnController = TextEditingController(
      text: edit?.isbn ?? '978-0-123456-78-9',
    );

    if (edit != null) {
      _selectedCategory = edit.category;
      _selectedCondition = edit.condition;
      _selectedImage = edit.imagePath;
      _stock = edit.stock;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _descriptionController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  void _saveListing({bool asDraft = false}) {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final originalPrice =
        double.tryParse(_originalPriceController.text.trim()) ?? (price * 1.5);

    final service = SellerDataService();

    if (widget.editListing != null) {
      final updated = SellerBookListing(
        id: widget.editListing!.id,
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        category: _selectedCategory,
        price: price,
        originalPrice: originalPrice,
        condition: _selectedCondition,
        imagePath: _selectedImage,
        description: _descriptionController.text.trim(),
        status: asDraft ? SellerBookStatus.paused : widget.editListing!.status,
        stock: _stock,
        viewsCount: widget.editListing!.viewsCount,
        favoritesCount: widget.editListing!.favoritesCount,
        listedDate: widget.editListing!.listedDate,
        isbn: _isbnController.text.trim(),
      );
      service.updateListing(updated);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Listing "${updated.title}" updated successfully!'),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else {
      final newListing = SellerBookListing(
        id: 'LST-${DateTime.now().millisecondsSinceEpoch % 100000}',
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        category: _selectedCategory,
        price: price,
        originalPrice: originalPrice,
        condition: _selectedCondition,
        imagePath: _selectedImage,
        description: _descriptionController.text.trim(),
        status: asDraft ? SellerBookStatus.paused : SellerBookStatus.active,
        stock: _stock,
        viewsCount: 1,
        favoritesCount: 0,
        listedDate: 'Just now',
        isbn: _isbnController.text.trim(),
      );
      service.addListing(newListing);

      // Save to Cloud Firestore database
      FirestoreService().addBook(
        BookModel(
          id: newListing.id,
          title: newListing.title,
          author: newListing.author,
          price: newListing.price,
          originalPrice: newListing.originalPrice,
          condition: newListing.condition,
          category: newListing.category,
          imagePath: newListing.imagePath,
          description: newListing.description,
          sellerName: 'Aryan',
          isbn: newListing.isbn,
          createdAt: DateTime.now(),
        ),
      );

      _showSuccessDialog(newListing);
    }
  }

  void _showSuccessDialog(SellerBookListing listing) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF4F39E3),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Book Listed in Store!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '"${listing.title}" is now active in your seller inventory at ₹${listing.price.toStringAsFixed(0)}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Inventory'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      // Clear form to list another
                      _titleController.clear();
                      _authorController.clear();
                      _priceController.clear();
                      _originalPriceController.clear();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F39E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Another',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Book Cover Image',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: GridView.builder(
                  itemCount: _sampleImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final img = _sampleImages[index];
                    final isSel = _selectedImage == img;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedImage = img);
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSel
                                ? const Color(0xFF4F39E3)
                                : Colors.grey.shade300,
                            width: isSel ? 2.5 : 1,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              img,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: const Color(0xFFEEF2FF),
                                    child: const Icon(
                                      Icons.book,
                                      color: Color(0xFF4F39E3),
                                    ),
                                  ),
                            ),
                            if (isSel)
                              Container(
                                color: const Color(0xFF4F39E3)
                                    .withValues(alpha: 0.35),
                                child: const Center(
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editListing != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Book Listing' : 'List Book for Sale',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _saveListing(asDraft: true),
            child: const Text(
              'Save Draft',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Picker Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _selectedImage,
                        width: 80,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 110,
                          color: const Color(0xFFEEF2FF),
                          child: const Icon(
                            Icons.book,
                            color: Color(0xFF4F39E3),
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Book Cover Photo',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose clear cover preview for buyers.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: _showImageSelector,
                            icon: const Icon(
                              Icons.photo_library_outlined,
                              size: 18,
                            ),
                            label: const Text('Change Photo'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4F39E3),
                              side: const BorderSide(color: Color(0xFF4F39E3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Book Details Section
              _buildSectionHeader('Book Information'),
              const SizedBox(height: 10),

              _buildTextField(
                controller: _titleController,
                label: 'Book Title *',
                hint: 'e.g. Think and Grow Rich',
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Enter book title'
                    : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _authorController,
                label: 'Author Name *',
                hint: 'e.g. Napoleon Hill',
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Enter author name'
                    : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      label: 'Category',
                      value: _selectedCategory,
                      items: _categories,
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField(
                      label: 'Condition',
                      value: _selectedCondition,
                      items: _conditions,
                      onChanged: (val) =>
                          setState(() => _selectedCondition = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _isbnController,
                label: 'ISBN (Optional)',
                hint: 'e.g. 978-0-123456-78-9',
              ),

              const SizedBox(height: 20),

              // Pricing Section
              _buildSectionHeader('Pricing & Stock'),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _priceController,
                      label: 'Your Selling Price (₹) *',
                      hint: '180',
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter selling price';
                        }
                        if (double.tryParse(val.trim()) == null) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _originalPriceController,
                      label: 'Original MRP (₹)',
                      hint: '350',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Quantity / Stock selector
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity in Stock',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: _stock > 1
                              ? () => setState(() => _stock--)
                              : null,
                          color: const Color(0xFF4F39E3),
                        ),
                        Text(
                          '$_stock',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() => _stock++),
                          color: const Color(0xFF4F39E3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Zero Commission Badge
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: Color(0xFF16A34A), size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '0% Seller Commission fee on ReRead! You keep 100% of your book earnings.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF15803D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Description Section
              _buildSectionHeader('Condition & Details'),
              const SizedBox(height: 10),

              _buildTextField(
                controller: _descriptionController,
                label: 'Description / Book Condition Notes',
                hint: 'Mention highlights, folded pages, or bundled CDs if any...',
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => _saveListing(asDraft: false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F39E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isEditing ? 'Update Listing' : 'Publish Book to Store',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 14)),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
