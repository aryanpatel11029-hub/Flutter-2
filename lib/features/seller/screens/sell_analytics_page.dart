import 'package:flutter/material.dart';
import '../models/seller_models.dart';

class SellAnalyticsPage extends StatelessWidget {
  const SellAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SellerDataService();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final reviews = service.reviews;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF1E293B), size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Store Analytics & Insights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Metrics Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildStatTile(
                        label: 'Total Store Views',
                        value: '1,840',
                        change: '+24% this week',
                        icon: Icons.visibility_rounded,
                        color: const Color(0xFF4F39E3),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildStatTile(
                        label: 'Listing Inquiries',
                        value: '620',
                        change: '+15%',
                        icon: Icons.chat_bubble_outline_rounded,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatTile(
                        label: 'Conversion Rate',
                        value: '11.8%',
                        change: 'Top 5% seller',
                        icon: Icons.trending_up_rounded,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildStatTile(
                        label: 'Avg. Order Value',
                        value: '₹285',
                        change: 'High demand',
                        icon: Icons.shopping_bag_outlined,
                        color: const Color(0xFFEC4899),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Weekly Sales Bar Chart
                Container(
                  padding: const EdgeInsets.all(18),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Weekly Sales Volume',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'Last 7 Days',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildChartBar('Mon', 0.4, '₹400'),
                          _buildChartBar('Tue', 0.65, '₹650'),
                          _buildChartBar('Wed', 0.3, '₹300'),
                          _buildChartBar('Thu', 0.85, '₹850'),
                          _buildChartBar('Fri', 0.5, '₹500'),
                          _buildChartBar('Sat', 1.0, '₹1,200', isHighest: true),
                          _buildChartBar('Sun', 0.75, '₹750'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Categories Breakdown
                Container(
                  padding: const EdgeInsets.all(18),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Revenue by Category',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildCategoryProgress('Textbooks & Academic', 0.45, '45%', const Color(0xFF4F39E3)),
                      const SizedBox(height: 10),
                      _buildCategoryProgress('Novels & Literature', 0.30, '30%', const Color(0xFF10B981)),
                      const SizedBox(height: 10),
                      _buildCategoryProgress('Manga & Comics', 0.15, '15%', const Color(0xFFF59E0B)),
                      const SizedBox(height: 10),
                      _buildCategoryProgress('Self Help & Business', 0.10, '10%', const Color(0xFF8B5CF6)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Customer Feedback & Reviews
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Buyer Reviews & Rating',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '${service.profile.rating} ★ (${service.profile.totalReviews})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4F39E3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Column(
                  children: reviews
                      .map((review) => _buildReviewCard(review))
                      .toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatTile({
    required String label,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String day, double factor, String amount,
      {bool isHighest = false}) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: isHighest ? FontWeight.bold : FontWeight.normal,
            color: isHighest ? const Color(0xFF4F39E3) : Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 28,
          height: 100 * factor,
          decoration: BoxDecoration(
            color: isHighest
                ? const Color(0xFF4F39E3)
                : const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isHighest ? FontWeight.bold : FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryProgress(
      String title, double fraction, String percent, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155))),
            Text(percent,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 8,
            backgroundColor: Colors.grey.shade100,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(SellerReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.reviewerName,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: i < review.rating.floor()
                        ? Colors.amber
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            review.comment,
            style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 6),
          Text(
            'Book: ${review.bookPurchased} • ${review.date}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
