import 'package:flutter/material.dart';
import 'package:wallpaper_app/modal/modal.dart';
import 'cart_page.dart'; // Import CartPage for cart access

class ProfilePage extends StatefulWidget {
  final List<Images> cartItems; // Cart items passed from MainPage
  final String userName; // User name
  final String userEmail; // User email

  const ProfilePage({
    Key? key,
    required this.cartItems,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userImage =
      "https://via.placeholder.com/150"; // Placeholder profile image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userImage),
            ),
            const SizedBox(height: 20),
            Text(
              widget.userName, // Display userName here
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.userEmail, // Display userEmail here
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Cart Button
            MaterialButton(
              minWidth: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      cartItems: widget.cartItems,
                      onRemove: (index) {
                        setState(() {
                          widget.cartItems.removeAt(index); // Update cart items
                        });
                      },
                    ),
                  ),
                );
              },
              child: const Text('Go to Cart'),
            ),
            const SizedBox(height: 15),

            // Log Out Button
            MaterialButton(
              minWidth: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                _logOut();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  void _logOut() {
    // Mimic log out by popping all routes until the first
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }
}
