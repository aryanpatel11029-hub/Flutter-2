import 'package:flutter/material.dart';

import 'home.dart';

class OrderStatusPage extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  const OrderStatusPage({
    super.key,
    this.orderId = '#RR12345678',
    this.orderDate = '17 May 2024, 10:30 AM',
    this.primaryButtonText = 'Place Order',
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

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
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const UserHomePage()),
                (route) => false,
              );
            }
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'Order Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Orange Parcel Illustration with Checkmark Badge
              const _ParcelIllustration(size: 145),

              const SizedBox(height: 28),

              // Title
              const Text(
                'Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.2,
                ),
              ),

              const SizedBox(height: 10),

              // Order ID
              Text(
                'Order ID: $orderId',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F39E3),
                ),
              ),

              const SizedBox(height: 8),

              // Date & Time
              Text(
                orderDate,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 16),

              // Email description notice
              Text(
                'You will receive order updates\non your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),

              const Spacer(flex: 4),

              // Primary Button (Place Order / Track Order)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onPrimaryPressed ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order $orderId status is active',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: const Color(0xFF4F39E3),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: const Duration(seconds: 2),
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
                  child: Text(
                    primaryButtonText,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Secondary Button (Continue Shopping)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onSecondaryPressed ??
                      () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserHomePage(),
                          ),
                          (route) => false,
                        );
                      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4F0FD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F39E3),
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
}

/// Custom illustration widget matching the orange origami parcel with green check badge
class _ParcelIllustration extends StatelessWidget {
  final double size;

  const _ParcelIllustration({this.size = 145});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ParcelPainter(),
          ),
          Positioned(
            right: size * 0.12,
            bottom: size * 0.08,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: const Color(0xFF00C096),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00C096).withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: size * 0.18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParcelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final boxTop = h * 0.36;
    final boxBottom = h * 0.88;
    final leftX = w * 0.14;
    final rightX = w * 0.86;
    final centerX = w * 0.50;

    final peakLeftX = w * 0.25;
    final peakRightX = w * 0.75;
    final peakY = h * 0.10;
    final valleyY = h * 0.24;

    // Palette
    final leftFlapPaint = Paint()..color = const Color(0xFFE86915);
    final rightFlapPaint = Paint()..color = const Color(0xFFFA8F36);
    final leftBodyPaint = Paint()..color = const Color(0xFFDF5F0F);
    final rightBodyPaint = Paint()..color = const Color(0xFFF3781F);
    final foldDividerPaint = Paint()
      ..color = const Color(0xFFC44E08)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    // Left top origami wing
    final leftFlap = Path()
      ..moveTo(centerX, valleyY)
      ..lineTo(peakLeftX, peakY)
      ..lineTo(leftX, boxTop)
      ..lineTo(centerX, boxTop)
      ..close();
    canvas.drawPath(leftFlap, leftFlapPaint);

    // Right top origami wing
    final rightFlap = Path()
      ..moveTo(centerX, valleyY)
      ..lineTo(peakRightX, peakY)
      ..lineTo(rightX, boxTop)
      ..lineTo(centerX, boxTop)
      ..close();
    canvas.drawPath(rightFlap, rightFlapPaint);

    // Left body side
    final leftBody = Path()
      ..moveTo(leftX, boxTop)
      ..lineTo(centerX, boxTop)
      ..lineTo(centerX, boxBottom)
      ..lineTo(leftX + (w * 0.03), boxBottom)
      ..arcToPoint(
        Offset(leftX, boxBottom - 6),
        radius: const Radius.circular(6),
      )
      ..close();
    canvas.drawPath(leftBody, leftBodyPaint);

    // Right body side
    final rightBody = Path()
      ..moveTo(centerX, boxTop)
      ..lineTo(rightX, boxTop)
      ..lineTo(rightX, boxBottom - 6)
      ..arcToPoint(
        Offset(rightX - (w * 0.03), boxBottom),
        radius: const Radius.circular(6),
      )
      ..lineTo(centerX, boxBottom)
      ..close();
    canvas.drawPath(rightBody, rightBodyPaint);

    // Valley crease line
    canvas.drawLine(
      Offset(centerX, valleyY),
      Offset(centerX, boxBottom),
      foldDividerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
