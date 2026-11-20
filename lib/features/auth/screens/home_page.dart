import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/BrandLogo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.menu_book,
                    color: Color(0xFF4F39E3),
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('ReRead Dashboard'),
          ],
        ),
        backgroundColor: const Color(0xFF4F39E3),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Welcome to your Book Dashboard!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
