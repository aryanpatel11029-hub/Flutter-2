import 'package:flutter/material.dart';
import '../models/seller_models.dart';

class SellSettingsPage extends StatefulWidget {
  const SellSettingsPage({super.key});

  @override
  State<SellSettingsPage> createState() => _SellSettingsPageState();
}

class _SellSettingsPageState extends State<SellSettingsPage> {
  void _editStoreName(BuildContext context, SellerDataService service) {
    final ctrl = TextEditingController(text: service.profile.storeName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Store Name'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Store Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                service.updateStoreProfile(storeName: ctrl.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editPickupAddress(BuildContext context, SellerDataService service) {
    final ctrl = TextEditingController(text: service.profile.pickupAddress);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Pickup Address'),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Complete Pickup Address for Courier',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                service.updateStoreProfile(pickupAddress: ctrl.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editUpiId(BuildContext context, SellerDataService service) {
    final ctrl = TextEditingController(text: service.profile.upiId);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Payout UPI ID'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            labelText: 'UPI ID (e.g. name@okhdfcbank)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                service.updateStoreProfile(upiId: ctrl.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showFaqDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Seller FAQ & Guide'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'How do I receive payments?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Once the buyer receives the book and confirms delivery, your wallet balance is updated. You can withdraw instantly via UPI or IMPS to your bank.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                'What is the platform fee?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'ReRead is currently offering 0% commission on second-hand books and textbooks! You keep 100% of the sale price.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                'Who handles shipping?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'You pack the book securely. Our courier partners (Delhivery / Shadowfax / BlueDart) pick it up directly from your address!',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = SellerDataService();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final profile = service.profile;

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
              'Store & Seller Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Store Profile Card
              Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Store Information',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _editStoreName(context, service),
                          child: const Text('Edit',
                              style: TextStyle(color: Color(0xFF4F39E3))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEEF2FF),
                        child: Icon(Icons.storefront_rounded,
                            color: Color(0xFF4F39E3)),
                      ),
                      title: Text(profile.storeName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${profile.ownerName} • ${profile.phone}'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Pickup & Logistics Address Card
              Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Courier Pickup Address',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _editPickupAddress(context, service),
                          child: const Text('Change',
                              style: TextStyle(color: Color(0xFF4F39E3))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Color(0xFF64748B), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            profile.pickupAddress,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Payout Account Details Card
              Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payout Accounts',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _editUpiId(context, service),
                          child: const Text('Edit UPI',
                              style: TextStyle(color: Color(0xFF4F39E3))),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.qr_code_2_rounded,
                          color: Color(0xFF4F39E3)),
                      title: const Text('Default UPI ID'),
                      subtitle: Text(profile.upiId),
                      trailing: const Icon(Icons.check_circle,
                          color: Color(0xFF10B981), size: 18),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.account_balance_rounded,
                          color: Color(0xFF4F39E3)),
                      title: Text(profile.bankName),
                      subtitle: Text(
                          'A/C: •••• ${profile.bankAccountNumber.substring(profile.bankAccountNumber.length - 4)} • IFSC: ${profile.ifscCode}'),
                      trailing: const Icon(Icons.check_circle,
                          color: Color(0xFF10B981), size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Preferences & Toggles
              Container(
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
                    const Text(
                      'Store Automation & Operations',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Vacation Mode'),
                      subtitle: const Text(
                          'Temporarily pause all book listings without deleting them.'),
                      activeThumbColor: const Color(0xFF4F39E3),
                      value: profile.isVacationMode,
                      onChanged: (val) {
                        service.updateStoreProfile(isVacationMode: val);
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Auto-Accept Orders'),
                      subtitle: const Text(
                          'Immediately mark incoming orders as ready for packaging.'),
                      activeThumbColor: const Color(0xFF4F39E3),
                      value: profile.autoAcceptOrders,
                      onChanged: (val) {
                        service.updateStoreProfile(autoAcceptOrders: val);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Help & Support
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.help_outline_rounded,
                          color: Color(0xFF4F39E3)),
                      title: const Text('Seller Help & FAQ'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 14),
                      onTap: () => _showFaqDialog(context),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.headset_mic_outlined,
                          color: Color(0xFF4F39E3)),
                      title: const Text('Contact ReRead Seller Support'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 14),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Support chat connected. Help agent available 9am-8pm.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Switch to Buyer Mode button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Switch to ReRead Buyer App'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4F39E3),
                    side: const BorderSide(color: Color(0xFF4F39E3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
