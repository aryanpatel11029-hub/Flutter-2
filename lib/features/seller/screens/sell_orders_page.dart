import 'package:flutter/material.dart';
import '../models/seller_models.dart';

class SellOrdersPage extends StatefulWidget {
  const SellOrdersPage({super.key});

  @override
  State<SellOrdersPage> createState() => _SellOrdersPageState();
}

class _SellOrdersPageState extends State<SellOrdersPage> {
  String _selectedStatusFilter = 'All';

  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Packed',
    'In Transit',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    final service = SellerDataService();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final orders = service.orders.where((o) {
          if (_selectedStatusFilter == 'Pending' &&
              o.status != SellerOrderStatus.pending) {
            return false;
          }
          if (_selectedStatusFilter == 'Packed' &&
              o.status != SellerOrderStatus.packed) {
            return false;
          }
          if (_selectedStatusFilter == 'In Transit' &&
              o.status != SellerOrderStatus.inTransit) {
            return false;
          }
          if (_selectedStatusFilter == 'Delivered' &&
              o.status != SellerOrderStatus.delivered) {
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
              'Orders & Shipments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          body: Column(
            children: [
              // Status filter pills
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: SizedBox(
                  height: 36,
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
                      );
                    },
                  ),
                ),
              ),

              // Orders List
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF2FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.inbox_rounded,
                                  color: Color(0xFF4F39E3), size: 36),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'No Orders Found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'No orders matching the "$_selectedStatusFilter" filter.',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: orders.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return _buildOrderCard(context, order, service);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(
      BuildContext context, SellerOrder order, SellerDataService service) {
    Color statusBg;
    Color statusColor;
    String statusText;

    switch (order.status) {
      case SellerOrderStatus.pending:
        statusBg = const Color(0xFFFEF3C7);
        statusColor = const Color(0xFFB45309);
        statusText = 'Needs Packing';
        break;
      case SellerOrderStatus.packed:
        statusBg = const Color(0xFFDBEAFE);
        statusColor = const Color(0xFF1D4ED8);
        statusText = 'Packed & Ready';
        break;
      case SellerOrderStatus.inTransit:
        statusBg = const Color(0xFFEDE9FE);
        statusColor = const Color(0xFF6D28D9);
        statusText = 'In Transit';
        break;
      case SellerOrderStatus.delivered:
        statusBg = const Color(0xFFDCFCE7);
        statusColor = const Color(0xFF15803D);
        statusText = 'Delivered & Paid';
        break;
      case SellerOrderStatus.cancelled:
        statusBg = const Color(0xFFFEE2E2);
        statusColor = const Color(0xFFB91C1C);
        statusText = 'Cancelled';
        break;
    }

    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderId,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    order.orderDate,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 12),

          // Book info row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  order.imagePath,
                  width: 50,
                  height: 68,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50,
                    height: 68,
                    color: const Color(0xFFEEF2FF),
                    child: const Icon(Icons.book, color: Color(0xFF4F39E3)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.bookTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'By ${order.bookAuthor}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Net Earnings: ₹${order.netEarnings.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                        Text(
                          order.paymentMode,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Buyer & Shipping Summary Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_pin_circle_outlined,
                        size: 16, color: Color(0xFF4F39E3)),
                    const SizedBox(width: 6),
                    Text(
                      '${order.buyerName} • ${order.buyerPhone}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  order.buyerAddress,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
                if (order.status == SellerOrderStatus.inTransit ||
                    order.status == SellerOrderStatus.delivered) ...[
                  const SizedBox(height: 6),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tracking: ${order.trackingId}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4F39E3),
                        ),
                      ),
                      Text(
                        order.courierPartner,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Action Buttons based on order status
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () => _showPackingSlip(context, order),
                icon: const Icon(Icons.receipt_long, size: 14),
                label: const Text('Packing Slip', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: const Size(0, 32),
                ),
              ),
              const SizedBox(width: 8),

              if (order.status == SellerOrderStatus.pending)
                ElevatedButton(
                  onPressed: () {
                    service.updateOrderStatus(
                        order.orderId, SellerOrderStatus.packed);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Order ${order.orderId} marked as packed!'),
                        backgroundColor: const Color(0xFF10B981),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F39E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Pack Order',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),

              if (order.status == SellerOrderStatus.packed)
                ElevatedButton(
                  onPressed: () => _showShipModal(context, order, service),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Dispatch / Ship',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),

              if (order.status == SellerOrderStatus.inTransit)
                ElevatedButton(
                  onPressed: () {
                    service.updateOrderStatus(
                        order.orderId, SellerOrderStatus.delivered);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Order ${order.orderId} Delivered! Earnings credited to wallet.'),
                        backgroundColor: const Color(0xFF10B981),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Mark Delivered',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showShipModal(
      BuildContext context, SellerOrder order, SellerDataService service) {
    final trackingCtrl = TextEditingController(text: order.trackingId);
    final courierCtrl = TextEditingController(text: order.courierPartner);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dispatch Order & Add Tracking',
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
            const SizedBox(height: 14),
            Text(
              'Order: ${order.orderId} • ${order.bookTitle}',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: courierCtrl,
              decoration: InputDecoration(
                labelText: 'Courier Partner',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: trackingCtrl,
              decoration: InputDecoration(
                labelText: 'Airway Bill / Tracking ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  service.updateOrderStatus(
                    order.orderId,
                    SellerOrderStatus.inTransit,
                    trackingId: trackingCtrl.text.trim(),
                    courier: courierCtrl.text.trim(),
                  );
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order ${order.orderId} is now in transit!'),
                      backgroundColor: const Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F39E3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Confirm Shipment',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPackingSlip(BuildContext context, SellerOrder order) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Packing Slip & Invoice',
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
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ReRead Order: ${order.orderId}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Date: ${order.orderDate}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    const Divider(),
                    Text('Item: ${order.bookTitle}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Author: ${order.bookAuthor}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Book Price:'),
                        Text('₹${order.bookPrice.toStringAsFixed(0)}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shipping:'),
                        Text('₹${order.shippingFee.toStringAsFixed(0)}'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${order.netEarnings.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4F39E3))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Deliver To:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text('${order.buyerName}\n${order.buyerAddress}\nPhone: ${order.buyerPhone}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Packing slip sent to printer.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.print_outlined, size: 16),
                      label: const Text('Print'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invoice saved as PDF.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 16),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F39E3),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
