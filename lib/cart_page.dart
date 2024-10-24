import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/modal/modal.dart';

class CartPage extends StatelessWidget {
  final List<Images> cartItems;

  const CartPage(
      {super.key,
      required this.cartItems,
      required Null Function(dynamic index) onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text("No items in cart"),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final image = cartItems[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: image.imagePotraitPath,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Image ID: ${image.imageID}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Remove item from cart
                      cartItems.removeAt(index);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            cartItems: cartItems,
                            onRemove: (index) {},
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
