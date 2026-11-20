import 'package:flutter/material.dart';

// Auth screens
import '../../features/auth/screens/welcome_page.dart';
import '../../features/auth/screens/login_page.dart';
import '../../features/auth/screens/register_page.dart';
import '../../features/auth/screens/verification_page.dart';
import '../../features/auth/screens/forgot_password_page.dart';
import '../../features/auth/screens/forgot_password_otp_page.dart';
import '../../features/auth/screens/reset_password_page.dart';
import '../../features/auth/screens/home_page.dart' as guest;

// Buyer screens
import '../../features/buyer/screens/home_page.dart';
import '../../features/buyer/screens/search_page.dart';
import '../../features/buyer/screens/view_all_page.dart';
import '../../features/buyer/screens/book_detail_page.dart';
import '../../features/buyer/screens/cart_page.dart';
import '../../features/buyer/screens/checkout_page.dart';
import '../../features/buyer/screens/wishlist_page.dart';
import '../../features/buyer/screens/my_orders_page.dart';
import '../../features/buyer/screens/order_status_page.dart';
import '../../features/buyer/screens/transaction_history_page.dart';
import '../../features/buyer/screens/seller_profile_page.dart';
import '../../features/buyer/screens/profile_page.dart';
import '../../features/buyer/screens/edit_profile_page.dart';
import '../../features/buyer/screens/settings_page.dart';
import '../../features/buyer/screens/sell_book_page.dart';
import '../../features/buyer/screens/my_listings_page.dart';

// Seller screens
import '../../features/seller/screens/seller_main_screen.dart';

// Admin screens
import '../../features/admin/screens/admin_main_screen.dart';
import '../../features/admin/screens/admin_login_page.dart';
import '../../features/admin/screens/admin_books_page.dart';
import '../../features/admin/screens/admin_orders_page.dart';
import '../../features/admin/screens/admin_users_page.dart';
import '../../features/admin/screens/admin_categories_page.dart';
import '../../features/admin/screens/admin_reports_page.dart';
import '../../features/admin/screens/admin_settings_page.dart';

class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verification = '/verification';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordOtp = '/forgot-password-otp';
  static const String resetPassword = '/reset-password';
  static const String guestHome = '/guest-home';

  // Buyer routes
  static const String home = '/home';
  static const String search = '/search';
  static const String bookDetails = '/book-details';
  static const String sellerProfile = '/seller-profile';
  static const String salerProfile = '/saler-profile';
  static const String sellBook = '/sell-book';
  static const String cart = '/cart';
  static const String viewAll = '/view-all';
  static const String wishlist = '/wishlist';
  static const String checkout = '/checkout';
  static const String orderStatus = '/order-status';
  static const String myOrders = '/my-orders';
  static const String transactionHistory = '/transaction-history';
  static const String myListings = '/my-listings';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';

  // Seller routes
  static const String sellerPanel = '/seller-panel';
  static const String sellPanel = '/sell-panel';

  // Admin routes
  static const String admin = '/admin';
  static const String adminLogin = '/admin-login';
  static const String adminBooks = '/admin-books';
  static const String adminOrders = '/admin-orders';
  static const String adminUsers = '/admin-users';
  static const String adminCategories = '/admin-categories';
  static const String adminReports = '/admin-reports';
  static const String adminSettings = '/admin-settings';
}

class AppRouter {
  AppRouter._();

  static Map<String, WidgetBuilder> get routes => {
    // Auth routes
    AppRoutes.welcome: (context) => const WelcomePage(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.register: (context) => const RegisterPage(),
    AppRoutes.verification: (context) => const VerificationPage(),
    AppRoutes.forgotPassword: (context) => const ForgotPasswordPage(),
    AppRoutes.forgotPasswordOtp: (context) => const ForgotPasswordOtpPage(),
    AppRoutes.resetPassword: (context) => const ResetPasswordPage(),
    AppRoutes.guestHome: (context) => const guest.HomePage(),

    // Buyer routes
    AppRoutes.home: (context) => const UserHomePage(),
    AppRoutes.search: (context) => const SearchPage(),
    AppRoutes.bookDetails: (context) => const BookDetailPage(),
    AppRoutes.salerProfile: (context) => const SalerProfilePage(),
    AppRoutes.sellerProfile: (context) => const SalerProfilePage(),
    AppRoutes.sellBook: (context) => const SellBookPage(),
    AppRoutes.cart: (context) => const CartPage(),
    AppRoutes.viewAll: (context) => const ViewAllPage(),
    AppRoutes.wishlist: (context) => const WishlistPage(),
    AppRoutes.checkout: (context) => const CheckoutPage(),
    AppRoutes.orderStatus: (context) => const OrderStatusPage(),
    AppRoutes.myOrders: (context) => const MyOrdersPage(),
    AppRoutes.transactionHistory: (context) => const TransactionHistoryPage(),
    AppRoutes.myListings: (context) => const MyListingsPage(),
    AppRoutes.profile: (context) => const ProfilePage(),
    AppRoutes.editProfile: (context) => const EditProfilePage(),
    AppRoutes.settings: (context) => const SettingsPage(),

    // Seller routes
    AppRoutes.sellerPanel: (context) => const SellPanalMainScreen(),
    AppRoutes.sellPanel: (context) => const SellPanalMainScreen(),

    // Admin routes
    AppRoutes.admin: (context) => const AdminMainScreen(),
    AppRoutes.adminLogin: (context) => const AdminLoginPage(),
    AppRoutes.adminBooks: (context) => const AdminBooksPage(),
    AppRoutes.adminOrders: (context) => const AdminOrdersPage(),
    AppRoutes.adminUsers: (context) => const AdminUsersPage(),
    AppRoutes.adminCategories: (context) => const AdminCategoriesPage(),
    AppRoutes.adminReports: (context) => const AdminReportsPage(),
    AppRoutes.adminSettings: (context) => const AdminSettingsPage(),
  };
}
