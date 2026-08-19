import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Placeholder URLs matching the book covers shown in the layout design
  final List<String> bookCovers = const [
    'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300',
    'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=300',
    'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=300',
    'https://images.unsplash.com/photo-1495640388908-05fa85288e61?w=300',
    'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=300',
    'https://images.unsplash.com/photo-1524578271613-d550eacf6090?w=300',
    'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=300',
    'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=300',
    'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=300',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // 3x3 Grid View for Book Covers
              Expanded(
                flex: 5,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        bookCovers[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Descriptive Text Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Read more and stress less with reread, your favorite online book shopping app. Shop from anywhere you are and discover titles that you love. Happy reading!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B39EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Add your login route logic here
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Register Link Button
              TextButton(
                onPressed: () {
                  // Add your register route logic here
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF5B39EF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
