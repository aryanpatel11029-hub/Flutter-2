import 'package:flutter/material.dart';
import '../models/seller_models.dart';
import 'sell_add_book_page.dart';

class SellInventoryPage extends StatefulWidget {
  const SellInventoryPage({super.key});

  @override
  State<SellInventoryPage> createState() => _SellInventoryPageState();
}

class _SellInventoryPageState extends State<SellInventoryPage> {
  String _searchQuery = '';
  String _selectedStatusFilter = 'All'; // All, Active, Sold, Paused, Pending
  String _selectedCategory = 'All';

  final List<String> _statusFilters = [
    'All',
    'Active',
    'Sold',
    'Paused',
    'Pending',
  ];

  final List<String> _categories = [
    'All',
    'Textbooks',
    'Self Help',
    'Novels',
    'Comics',
  ];

  @override
  Widget build(BuildContext context) {
    final service = SellerDataService();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final listings = service.listings.where((book) {
          // Filter by search query
          if (_searchQuery.isNotEmpty) {
            final q = _searchQuery.toLowerCase();
            final matches = book.title.toLowerCase().contains(q) ||
                book.author.toLowerCase().contains(q);
            if (!matches) return false;
          }

          // Filter by category
          if (_selectedCategory != 'All' &&
              book.category.toLowerCase() != _selectedCategory.toLowerCase()) {
            return false;
          }

          // Filter by status
          if (_selectedStatusFilter == 'Active' &&
              book.status != SellerBookStatus.active) {
            return false;
          }
          if (_selectedStatusFilter == 'Sold' &&
              book.status != SellerBookStatus.sold) {
            return false;
          }
          if (_selectedStatusFilter == 'Paused' &&
              book.status != SellerBookStatus.paused) {
            return false;
          }
          if (_selectedStatusFilter == 'Pending' &&
              book.status != SellerBookStatus.pendingApproval) {
            return false;
          }

          return true;
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu_rounded, color: Color(0xFF1E293B)),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            title: const Text(
              'My Inventory & Books',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded,
                    color: Color(0xFF4F39E3)),
                tooltip: 'Add New Book',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SellAddBookPage()),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SellAddBookPage()),
              );
            },
            backgroundColor: const Color(0xFF4F39E3),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('List New Book',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          body: Column(
            children: [
              // Search & Filter header container
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  children: [
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Color(0xFF94A3B8), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: (val) =>
                                  setState(() => _searchQuery = val.trim()),
                              decoration: const InputDecoration(
                                hintText: 'Search by title, author, or ISBN...',
                                hintStyle: TextStyle(
                                    color: Color(0xFF94A3B8), fontSize: 13),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () => setState(() => _searchQuery = ''),
                              child: const Icon(Icons.close,
                                  size: 18, color: Colors.grey),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Status Tab Pills
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _statusFilters.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, idx) {
                          final status = _statusFilters[idx];
                          final isSel = _selectedStatusFilter == status;
                          return ChoiceChip(
                            label: Text(status),
                            selected: isSel,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedStatusFilter = status);
                              }
                            },
                            selectedColor: const Color(0xFF4F39E3),
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: isSel ? Colors.white : const Color(0xFF475569),
                              fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                            ),
                            backgroundColor: const Color(0xFFF1F5F9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide.none,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Summary Info Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing ${listings.length} books',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    // Quick Category Dropdown
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        icon: const Icon(Icons.filter_list,
                            size: 16, color: Color(0xFF4F39E3)),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4F39E3),
                          fontWeight: FontWeight.bold,
                        ),
                        items: _categories
                            .map((c) => DropdownMenuItem(
                                value: c, child: Text('Category: $c')))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val!),
                      ),
                    ),
                  ],
                ),
              ),

              // Listings List
              Expanded(
                child: listings.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                        itemCount: listings.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final book = listings[index];
                          return _buildInventoryCard(context, book, service);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search_off_rounded,
                  size: 40, color: Color(0xFF4F39E3)),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Books Found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try adjusting your search query or status filter.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedStatusFilter = 'All';
                  _selectedCategory = 'All';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F39E3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Reset Filters',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryCard(
      BuildContext context, SellerBookListing book, SellerDataService service) {
    Color statusColor;
    String statusLabel;

    switch (book.status) {
      case SellerBookStatus.active:
        statusColor = const Color(0xFF10B981);
        statusLabel = 'Active';
        break;
      case SellerBookStatus.sold:
        statusColor = const Color(0xFF6B7280);
        statusLabel = 'Sold';
        break;
      case SellerBookStatus.paused:
        statusColor = const Color(0xFFF59E0B);
        statusLabel = 'Paused';
        break;
      case SellerBookStatus.pendingApproval:
        statusColor = const Color(0xFF3B82F6);
        statusLabel = 'Under Review';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  book.imagePath,
                  width: 65,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 65,
                    height: 90,
                    color: const Color(0xFFEEF2FF),
                    child: const Icon(Icons.book, color: Color(0xFF4F39E3)),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        // Quick popup menu
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz,
                              color: Colors.grey, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onSelected: (action) {
                            if (action == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SellAddBookPage(editListing: book),
                                ),
                              );
                            } else if (action == 'toggle_pause') {
                              service.toggleListingStatus(book.id);
                            } else if (action == 'mark_sold') {
                              service.markListingAsSold(book.id);
                            } else if (action == 'delete') {
                              _confirmDelete(context, book, service);
                            }
                          },
                          itemBuilder: (ctx) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined, size: 16),
                                  SizedBox(width: 8),
                                  Text('Edit Details'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'toggle_pause',
                              child: Row(
                                children: [
                                  Icon(
                                      book.status == SellerBookStatus.active
                                          ? Icons.pause_circle_outline
                                          : Icons.play_circle_outline,
                                      size: 16),
                                  SizedBox(width: 8),
                                  Text(book.status == SellerBookStatus.active
                                      ? 'Pause Listing'
                                      : 'Resume Listing'),
                                ],
                              ),
                            ),
                            if (book.status != SellerBookStatus.sold)
                              const PopupMenuItem(
                                value: 'mark_sold',
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline, size: 16),
                                    SizedBox(width: 8),
                                    Text('Mark as Sold'),
                                  ],
                                ),
                              ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline,
                                      size: 16, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete Listing',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'By ${book.author} • ${book.condition}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${book.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F39E3),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${book.originalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Stock: ${book.stock}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 8),

          // Bottom Stats & Quick Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_outlined,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text('${book.viewsCount} views',
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade600)),
                  const SizedBox(width: 14),
                  Icon(Icons.favorite_border_rounded,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text('${book.favoritesCount} likes',
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade600)),
                ],
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SellAddBookPage(editListing: book),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 14),
                    label: const Text('Edit', style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF4F39E3),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, SellerBookListing book, SellerDataService service) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Listing?'),
        content: Text(
            'Are you sure you want to remove "${book.title}" from your store inventory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              service.deleteListing(book.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Listing deleted successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
