import 'package:flutter/material.dart';

import '../models/seller_models.dart';
import 'sell_dashboard_page.dart';
import 'sell_inventory_page.dart';
import 'sell_orders_page.dart';
import 'sell_earnings_page.dart';
import 'sell_analytics_page.dart';
import 'sell_settings_page.dart';
import 'sell_add_book_page.dart';

class SellPanalMainScreen extends StatefulWidget {
  final int initialIndex;

  const SellPanalMainScreen({super.key, this.initialIndex = 0});

  @override
  State<SellPanalMainScreen> createState() => _SellPanalMainScreenState();
}

typedef SellerMainScreen = SellPanalMainScreen;

class _SellPanalMainScreenState extends State<SellPanalMainScreen> {
  late int _currentIndex;
  final SellerDataService _service = SellerDataService();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _service.removeListener(_onServiceUpdate);
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pendingOrdersCount = _service.pendingOrdersCount;
    final activeListingsCount = _service.activeListingsCount;

    final pages = [
      SellDashboardPage(
        onTabChange: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      const SellInventoryPage(),
      const SellOrdersPage(),
      const SellEarningsPage(),
    ];

    return Scaffold(
      drawer: _buildSellerDrawer(context),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFEEF2FF),
          elevation: 0,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(
                Icons.dashboard_rounded,
                color: Color(0xFF4F39E3),
              ),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: activeListingsCount > 0,
                label: Text('$activeListingsCount'),
                backgroundColor: const Color(0xFF10B981),
                child: const Icon(Icons.inventory_2_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: activeListingsCount > 0,
                label: Text('$activeListingsCount'),
                backgroundColor: const Color(0xFF10B981),
                child: const Icon(
                  Icons.inventory_2_rounded,
                  color: Color(0xFF4F39E3),
                ),
              ),
              label: 'Inventory',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: pendingOrdersCount > 0,
                label: Text('$pendingOrdersCount'),
                backgroundColor: const Color(0xFFF59E0B),
                child: const Icon(Icons.local_shipping_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: pendingOrdersCount > 0,
                label: Text('$pendingOrdersCount'),
                backgroundColor: const Color(0xFFF59E0B),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  color: Color(0xFF4F39E3),
                ),
              ),
              label: 'Orders',
            ),
            const NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(
                Icons.account_balance_wallet_rounded,
                color: Color(0xFF4F39E3),
              ),
              label: 'Earnings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerDrawer(BuildContext context) {
    final profile = _service.profile;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4F39E3), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.storeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Colors.amberAccent,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified Seller • ${profile.rating} ★',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.dashboard_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Store Dashboard'),
                    selected: _currentIndex == 0,
                    selectedTileColor: const Color(0xFFEEF2FF),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.inventory_2_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Books & Inventory'),
                    selected: _currentIndex == 1,
                    selectedTileColor: const Color(0xFFEEF2FF),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.local_shipping_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Orders & Shipments'),
                    selected: _currentIndex == 2,
                    selectedTileColor: const Color(0xFFEEF2FF),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Wallet & Payouts'),
                    selected: _currentIndex == 3,
                    selectedTileColor: const Color(0xFFEEF2FF),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 3);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.add_circle_rounded,
                      color: Color(0xFF10B981),
                    ),
                    title: const Text(
                      'List a New Book',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SellAddBookPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.insights_rounded,
                      color: Color(0xFF6366F1),
                    ),
                    title: const Text('Analytics & Insights'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SellAnalyticsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_rounded,
                      color: Color(0xFF64748B),
                    ),
                    title: const Text('Store Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SellSettingsPage(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Switch to Buyer App'),
                    subtitle: const Text('Browse & buy books'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Color(0xFF475569),
                    ),
                    title: const Text('Admin Portal'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/admin');
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/BrandLogo.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ReRead Seller Panel v1.0.0',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
