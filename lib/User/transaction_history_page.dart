import 'package:flutter/material.dart';

class TransactionItemModel {
  final String title;
  final String date;
  final String price;
  final String status; // 'Delivered', 'Completed', 'Canceled'
  final String paymentInfo;
  final String imagePath;

  TransactionItemModel({
    required this.title,
    required this.date,
    required this.price,
    required this.status,
    required this.paymentInfo,
    required this.imagePath,
  });
}

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String _selectedFilter = 'All';

  final List<TransactionItemModel> _allTransactions = [
    TransactionItemModel(
      title: 'UI/UX Design',
      date: '17 May 2024',
      price: '₹180',
      status: 'Delivered',
      paymentInfo: 'Payment via UPI • Order #RR12343979',
      imagePath: 'assets/images/python.jpg',
    ),
    TransactionItemModel(
      title: 'Attack on Titan',
      date: '10 May 2024',
      price: '₹50',
      status: 'Completed',
      paymentInfo: 'Payment via Card • Order #RR12343676',
      imagePath: 'assets/images/aot.jpg',
    ),
    TransactionItemModel(
      title: 'Psychology of human',
      date: '05 May 2024',
      price: '₹150',
      status: 'Delivered',
      paymentInfo: 'Payment via UPI • Order #RR12343072',
      imagePath: 'assets/images/how_to_kill_men.jpg',
    ),
    TransactionItemModel(
      title: 'Dune',
      date: '28 Apr 2024',
      price: '₹200',
      status: 'Canceled',
      paymentInfo: 'Refund Processed • Order #RR12343689',
      imagePath: 'assets/images/dune.jpg',
    ),
  ];

  List<TransactionItemModel> get _filteredTransactions {
    if (_selectedFilter == 'All') return _allTransactions;
    return _allTransactions.where((t) => t.status == _selectedFilter).toList();
  }

  Color _getStatusBg(String status) {
    if (status == 'Canceled') {
      return const Color(0xFFFEE2E2);
    }
    return const Color(0xFFE8F7F0);
  }

  Color _getStatusTextColor(String status) {
    if (status == 'Canceled') {
      return const Color(0xFFEF4444);
    }
    return const Color(0xFF00BFA5);
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              ...['All', 'Delivered', 'Completed', 'Canceled'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return ListTile(
                  title: Text(
                    filter,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF4F39E3)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Color(0xFF4F39E3))
                      : null,
                  onTap: () {
                    setState(() => _selectedFilter = filter);
                    Navigator.pop(ctx);
                  },
                );
              }),
            ],
          ),
        );
      },
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
          'Transaction History',
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

          // Subheader row: Showing all past transactions | Filter ⌵
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedFilter == 'All'
                      ? 'Showing all past transactions'
                      : 'Showing $_selectedFilter transactions',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: _showFilterMenu,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedFilter == 'All' ? 'Filter' : _selectedFilter,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: Color(0xFF475569),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transaction Cards List
          Expanded(
            child: _filteredTransactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredTransactions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final tx = _filteredTransactions[index];
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
                                // Thumbnail
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    tx.imagePath,
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

                                // Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tx.title,
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
                                        tx.date,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        tx.price,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F39E3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Status Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusBg(tx.status),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    tx.status,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusTextColor(tx.status),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade100,
                            ),
                            const SizedBox(height: 10),

                            // Footer info
                            Text(
                              tx.paymentInfo,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
