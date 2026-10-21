import 'package:flutter/material.dart';
import 'models/admin_models.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final AdminDataService _dataService = AdminDataService();
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ['All', 'Buyers', 'Sellers', 'Suspended'];

  @override
  void initState() {
    super.initState();
    _dataService.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dataService.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) setState(() {});
  }

  List<AdminUser> _getFilteredUsers() {
    return _dataService.users.where((user) {
      if (_selectedFilter == 'Buyers' && user.role != UserRole.buyer) {
        return false;
      }
      if (_selectedFilter == 'Sellers' &&
          user.role != UserRole.seller &&
          user.role != UserRole.verifiedSeller) {
        return false;
      }
      if (_selectedFilter == 'Suspended' &&
          user.status != UserAccountStatus.suspended) {
        return false;
      }

      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchName = user.name.toLowerCase().contains(query);
        final matchEmail = user.email.toLowerCase().contains(query);
        final matchPhone = user.phone.toLowerCase().contains(query);
        if (!matchName && !matchEmail && !matchPhone) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _getFilteredUsers();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Users & Merchant Directory',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddUserDialog(context),
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF4F39E3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add_alt_1_rounded,
                  color: Colors.white, size: 20),
            ),
            tooltip: 'Add User',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter & Search bar container
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search user name, email, or phone...',
                    hintStyle:
                        TextStyle(fontSize: 13, color: Colors.grey.shade400),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF4F39E3),
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      int count = 0;
                      if (filter == 'All') {
                        count = _dataService.users.length;
                      } else if (filter == 'Buyers') {
                        count = _dataService.users
                            .where((u) => u.role == UserRole.buyer)
                            .length;
                      } else if (filter == 'Sellers') {
                        count = _dataService.users
                            .where((u) =>
                                u.role == UserRole.seller ||
                                u.role == UserRole.verifiedSeller)
                            .length;
                      } else if (filter == 'Suspended') {
                        count = _dataService.users
                            .where((u) =>
                                u.status == UserAccountStatus.suspended)
                            .length;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(
                            '$filter ($count)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF475569),
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF4F39E3),
                          backgroundColor: const Color(0xFFF1F5F9),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (val) {
                            if (val) setState(() => _selectedFilter = filter);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Users list
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline_rounded,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          'No users found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredUsers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return _buildUserCard(context, user);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, AdminUser user) {
    final isSuspended = user.status == UserAccountStatus.suspended;
    final isVerifiedSeller = user.role == UserRole.verifiedSeller;
    final isSeller = user.role == UserRole.seller || isVerifiedSeller;

    String initials = '';
    final parts = user.name.split(' ');
    if (parts.isNotEmpty) initials += parts[0][0];
    if (parts.length > 1) initials += parts[1][0];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSuspended
              ? const Color(0xFFFECACA)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: user.avatarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initials.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (isVerifiedSeller) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF0EA5E9),
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            user.phone,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Joined ${user.joinedDate}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSuspended
                      ? const Color(0xFFFEE2E2)
                      : const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isSuspended ? 'Suspended' : 'Active',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSuspended
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // User Stats Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Purchases', '${user.totalOrders} Orders'),
                Container(width: 1, height: 20, color: Colors.grey.shade300),
                _buildStatItem('Listings', '${user.totalListings} Books'),
                Container(width: 1, height: 20, color: Colors.grey.shade300),
                _buildStatItem(
                  'Role',
                  isVerifiedSeller
                      ? 'Verified Seller'
                      : isSeller
                          ? 'Seller'
                          : 'Buyer',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isSeller)
                TextButton.icon(
                  onPressed: () {
                    _dataService.toggleUserVerification(user.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isVerifiedSeller
                              ? 'Removed verified badge from ${user.name}'
                              : 'Verified ${user.name} as trusted seller!',
                        ),
                        backgroundColor: const Color(0xFF0EA5E9),
                      ),
                    );
                  },
                  icon: Icon(
                    isVerifiedSeller
                        ? Icons.remove_circle_outline
                        : Icons.verified_rounded,
                    size: 16,
                    color: const Color(0xFF0EA5E9),
                  ),
                  label: Text(
                    isVerifiedSeller ? 'Revoke Badge' : 'Verify Seller',
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF0EA5E9)),
                  ),
                ),
              const SizedBox(width: 6),
              TextButton.icon(
                onPressed: () => _confirmToggleSuspension(context, user),
                icon: Icon(
                  isSuspended
                      ? Icons.check_circle_outline
                      : Icons.block_flipped,
                  size: 16,
                  color: isSuspended
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                ),
                label: Text(
                  isSuspended ? 'Reactivate' : 'Suspend',
                  style: TextStyle(
                    fontSize: 12,
                    color: isSuspended
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  void _confirmToggleSuspension(BuildContext context, AdminUser user) {
    final isSuspended = user.status == UserAccountStatus.suspended;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(isSuspended ? 'Reactivate Account?' : 'Suspend Account?'),
        content: Text(
          isSuspended
              ? 'Are you sure you want to restore access for ${user.name}?'
              : 'Suspended users cannot buy, sell, or list items on ReRead. Are you sure you want to suspend ${user.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _dataService.toggleUserStatus(user.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSuspended
                        ? '${user.name} has been reactivated.'
                        : '${user.name} has been suspended.',
                  ),
                  backgroundColor: isSuspended
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSuspended
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(isSuspended ? 'Reactivate' : 'Suspend'),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    UserRole selectedRole = UserRole.buyer;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Add New User / Merchant'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<UserRole>(
                  value: selectedRole,
                  decoration: const InputDecoration(labelText: 'Initial Role'),
                  items: const [
                    DropdownMenuItem(
                      value: UserRole.buyer,
                      child: Text('Regular Buyer'),
                    ),
                    DropdownMenuItem(
                      value: UserRole.seller,
                      child: Text('Book Seller'),
                    ),
                    DropdownMenuItem(
                      value: UserRole.verifiedSeller,
                      child: Text('Verified Merchant / Pro Seller'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedRole = val);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) return;
                final newUser = AdminUser(
                  id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameController.text.trim(),
                  email: emailController.text.trim().isEmpty
                      ? 'user@reread.com'
                      : emailController.text.trim(),
                  phone: phoneController.text.trim().isEmpty
                      ? '+91 98000 00000'
                      : phoneController.text.trim(),
                  role: selectedRole,
                  joinedDate: 'Today',
                  avatarColor: const Color(0xFF4F39E3),
                );
                _dataService.addUser(newUser);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('New user registered successfully!'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F39E3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Register User'),
            ),
          ],
        ),
      ),
    );
  }
}
