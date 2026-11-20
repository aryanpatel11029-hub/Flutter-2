import 'package:flutter/material.dart';

import '../models/admin_models.dart';
import 'admin_dashboard_page.dart';
import 'admin_books_page.dart';
import 'admin_orders_page.dart';
import 'admin_users_page.dart';
import 'admin_categories_page.dart';
import 'admin_reports_page.dart';
import 'admin_settings_page.dart';

class AdminMainScreen extends StatefulWidget {
  final int initialIndex;

  const AdminMainScreen({super.key, this.initialIndex = 0});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  late int _currentIndex;
  final AdminDataService _dataService = AdminDataService();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _dataService.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _dataService.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pendingBooks = _dataService.pendingApprovalsCount;
    final pendingOrders = _dataService.pendingOrdersCount;

    final List<Widget> pages = [
      AdminDashboardPage(
        onTabChange: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      const AdminBooksPage(),
      const AdminOrdersPage(),
      const AdminUsersPage(),
    ];

    return Scaffold(
      drawer: _buildAdminDrawer(context),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
                isLabelVisible: pendingBooks > 0,
                label: Text('$pendingBooks'),
                backgroundColor: const Color(0xFFF59E0B),
                child: const Icon(Icons.menu_book_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: pendingBooks > 0,
                label: Text('$pendingBooks'),
                backgroundColor: const Color(0xFFF59E0B),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF4F39E3),
                ),
              ),
              label: 'Catalog',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: pendingOrders > 0,
                label: Text('$pendingOrders'),
                backgroundColor: const Color(0xFF4F39E3),
                child: const Icon(Icons.local_shipping_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: pendingOrders > 0,
                label: Text('$pendingOrders'),
                backgroundColor: const Color(0xFF4F39E3),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  color: Color(0xFF4F39E3),
                ),
              ),
              label: 'Orders',
            ),
            const NavigationDestination(
              icon: Icon(Icons.people_outline_rounded),
              selectedIcon: Icon(
                Icons.people_rounded,
                color: Color(0xFF4F39E3),
              ),
              label: 'Users',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
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
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/BrandLogo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.admin_panel_settings,
                              color: Color(0xFF4F39E3),
                              size: 28,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ReRead Admin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Root Administrator',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.dashboard_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Dashboard'),
                    selected: _currentIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Books & Listings'),
                    selected: _currentIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_bag_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Orders & Shipments'),
                    selected: _currentIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.people_rounded,
                      color: Color(0xFF4F39E3),
                    ),
                    title: const Text('Users & Sellers'),
                    selected: _currentIndex == 3,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 3);
                    },
                  ),
                  const Divider(height: 20),
                  ListTile(
                    leading: const Icon(
                      Icons.category_rounded,
                      color: Color(0xFF0EA5E9),
                    ),
                    title: const Text('Categories Manager'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminCategoriesPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_problem_rounded,
                      color: Color(0xFFF59E0B),
                    ),
                    title: const Text('Reports & Disputes'),
                    trailing: _dataService.pendingReportsCount > 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${_dataService.pendingReportsCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminReportsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_rounded,
                      color: Color(0xFF64748B),
                    ),
                    title: const Text('Platform Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(
                Icons.storefront_rounded,
                color: Color(0xFF4F39E3),
              ),
              title: const Text('Go to User App'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFEF4444),
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Color(0xFFEF4444)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/admin-login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
