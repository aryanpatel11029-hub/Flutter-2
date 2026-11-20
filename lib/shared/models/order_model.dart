import 'cart_item_model.dart';

enum OrderState { pending, confirmed, processing, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final String buyerId;
  final String buyerName;
  final String buyerPhone;
  final String shippingAddress;
  final List<CartItemModel> items;
  final double totalAmount;
  final double deliveryFee;
  final OrderState status;
  final String paymentMethod;
  final String trackingId;
  final DateTime orderDate;

  const OrderModel({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.buyerPhone,
    required this.shippingAddress,
    required this.items,
    required this.totalAmount,
    this.deliveryFee = 40.0,
    this.status = OrderState.pending,
    this.paymentMethod = 'Cash on Delivery',
    this.trackingId = '',
    required this.orderDate,
  });

  double get grandTotal => totalAmount + deliveryFee;

  OrderModel copyWith({
    String? id,
    String? buyerId,
    String? buyerName,
    String? buyerPhone,
    String? shippingAddress,
    List<CartItemModel>? items,
    double? totalAmount,
    double? deliveryFee,
    OrderState? status,
    String? paymentMethod,
    String? trackingId,
    DateTime? orderDate,
  }) {
    return OrderModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      buyerPhone: buyerPhone ?? this.buyerPhone,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      trackingId: trackingId ?? this.trackingId,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'shippingAddress': shippingAddress,
      'items': items.map((i) => i.toMap()).toList(),
      'totalAmount': totalAmount,
      'deliveryFee': deliveryFee,
      'status': status.name,
      'paymentMethod': paymentMethod,
      'trackingId': trackingId,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return OrderModel(
      id: docId ?? map['id'] ?? '',
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
      buyerPhone: map['buyerPhone'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (map['deliveryFee'] as num?)?.toDouble() ?? 40.0,
      status: OrderState.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => OrderState.pending,
      ),
      paymentMethod: map['paymentMethod'] ?? 'Cash on Delivery',
      trackingId: map['trackingId'] ?? '',
      orderDate: map['orderDate'] != null
          ? DateTime.tryParse(map['orderDate']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
