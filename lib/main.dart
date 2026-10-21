import 'package:flutter/material.dart';

import 'Guset_user/welcome_page.dart';
import 'Guset_user/login_page.dart';
import 'Guset_user/register_page.dart';
import 'Guset_user/verification_page.dart';
import 'Guset_user/home_page.dart';
import 'User/home.dart';
import 'User/search_page.dart';
import 'User/book_detail_page.dart';
import 'User/saler_profile_page.dart';
import 'User/sell_book_page.dart';
import 'User/cart_page.dart';
import 'User/view_all_page.dart';
import 'User/wishlist_page.dart';
import 'User/checkout_page.dart';
import 'User/order_status_page.dart';
import 'User/my_orders_page.dart';
import 'User/transaction_history_page.dart';
import 'User/my_listings_page.dart';
import 'User/profile_page.dart';
import 'User/edit_profile_page.dart';
import 'User/settings_page.dart';
import 'Guset_user/forgot_password_page.dart';
import 'Guset_user/forgot_password_otp_page.dart';
import 'Guset_user/reset_password_page.dart';
import 'Admin/admin_main_screen.dart';
import 'Admin/admin_login_page.dart';
import 'Admin/admin_books_page.dart';
import 'Admin/admin_orders_page.dart';
import 'Admin/admin_users_page.dart';
import 'Admin/admin_categories_page.dart';
import 'Admin/admin_reports_page.dart';
import 'Admin/admin_settings_page.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4F39E3),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verification': (context) => const VerificationPage(),
        '/home': (context) => const UserHomePage(),
        '/guest-home': (context) => const HomePage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/forgot-password-otp': (context) => const ForgotPasswordOtpPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/search': (context) => const SearchPage(),
        '/book-details': (context) => const BookDetailPage(),
        '/saler-profile': (context) => const SalerProfilePage(),
        '/seller-profile': (context) => const SalerProfilePage(),
        '/sell-book': (context) => const SellBookPage(),
        '/cart': (context) => const CartPage(),
        '/view-all': (context) => const ViewAllPage(),
        '/wishlist': (context) => const WishlistPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/order-status': (context) => const OrderStatusPage(),
        '/my-orders': (context) => const MyOrdersPage(),
        '/transaction-history': (context) => const TransactionHistoryPage(),
        '/my-listings': (context) => const MyListingsPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/admin': (context) => const AdminMainScreen(),
        '/admin-login': (context) => const AdminLoginPage(),
        '/admin-books': (context) => const AdminBooksPage(),
        '/admin-orders': (context) => const AdminOrdersPage(),
        '/admin-users': (context) => const AdminUsersPage(),
        '/admin-categories': (context) => const AdminCategoriesPage(),
        '/admin-reports': (context) => const AdminReportsPage(),
        '/admin-settings': (context) => const AdminSettingsPage(),
      },
    );
  }
}
