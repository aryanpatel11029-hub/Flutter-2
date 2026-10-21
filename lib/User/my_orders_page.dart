import 'package:flutter/material.dart';

import 'order_status_page.dart';

class OrderItemModel {
  final String title;
  final String orderId;
  final String price;
  final String status; // 'In Transit', 'Processing', 'Delivered', 'Canceled'
  final String estimatedDelivery;
  final String imagePath;
  final String category; // 'Ongoing', 'Completed', 'Canceled'

  OrderItemModel({
    required this.title,
    required this.orderId,
    required this.price,
    required this.status,
    required this.estimatedDelivery,
    required this.imagePath,
    required this.category,
  });
}

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  String _selectedTab = 'Ongoing';

  final List<String> _tabs = ['Ongoing', 'Completed', 'Canceled'];

  final List<OrderItemModel> _allOrders = [
    OrderItemModel(
      title: 'The Alchemist',
      orderId: '#RR12345678',
      price: '₹150',
      status: 'In Transit',
      estimatedDelivery: 'Sep 21, 2026',
      imagePath: 'assets/images/how_to_kill_men.jpg',
      category: 'Ongoing',
    ),
    OrderItemModel(
      title: 'Rich Dad and Poor Dad',
      orderId: '#RR12345677',
      price: '₹220',
      status: 'Processing',
      estimatedDelivery: 'Aug 23, 2026',
      imagePath: 'assets/images/rich_dad.jpg',
      category: 'Ongoing',
    ),
    OrderItemModel(
      title: 'Attack on Titan',
      orderId: '#RR12343676',
      price: '₹50',
      status: 'Delivered',
      estimatedDelivery: 'May 10, 2024',
      imagePath: 'assets/images/aot.jpg',
      category: 'Completed',
    ),
    OrderItemModel(
      title: 'UI/UX Design',
      orderId: '#RR12343979',
      price: '₹180',
      status: 'Delivered',
      estimatedDelivery: 'May 17, 2024',
      imagePath: 'assets/images/python.jpg',
      category: 'Completed',
    ),
    OrderItemModel(
      title: 'Dune',
      orderId: '#RR12343689',
      price: '₹200',
      status: 'Canceled',
      estimatedDelivery: 'Apr 28, 2024',
      imagePath: 'assets/images/dune.jpg',
      category: 'Canceled',
    ),
  ];

  List<OrderItemModel> get _filteredOrders {
    return _allOrders.where((o) => o.category == _selectedTab).toList();
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'In Transit':
      case 'Delivered':
      case 'Completed':
        return const Color(0xFFE8F7F0);
      case 'Processing':
        return const Color(0xFFFFF3E0);
      case 'Canceled':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'In Transit':
      case 'Delivered':
      case 'Completed':
        return const Color(0xFF00BFA5);
      case 'Processing':
        return const Color(0xFFF59E0B);
      case 'Canceled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF64748B);
    }
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
          'My Orders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // Tabs Row: Ongoing, Completed, Canceled
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
                        horizontal: 20,
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

          const SizedBox(height: 20),

          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No $_selectedTab orders found',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredOrders.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderStatusPage(
                                orderId: order.orderId,
                                primaryButtonText: 'Track Order',
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Book Thumbnail
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      order.imagePath,
                                      width: 60,
                                      height: 78,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, _, __) => Container(
                                        width: 60,
                                        height: 78,
                                        color: const Color(0xFFF1F5F9),
                                        child: const Icon(
                                          Icons.menu_book_rounded,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Title, Order ID, Price
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.title,
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
                                          'Order ID: ${order.orderId}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          order.price,
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
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusBgColor(order.status),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            _getStatusTextColor(order.status),
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

                              // Estimated Delivery
                              Text(
                                'Estimated Delivery: ${order.estimatedDelivery}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
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
    );
  }
}
