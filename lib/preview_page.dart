import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/modal/modal.dart';
import 'package:wallpaper_app/repo/repository.dart';

class PreviewPage extends StatefulWidget {
  final String imageUrl;
  final int imageId;

  const PreviewPage({
    super.key,
    required this.imageId,
    required this.imageUrl,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Repository repo = Repository();

  // To keep track of whether the image is added to the cart or not
  bool isAddedToCart = false;

  @override
  void initState() {
    super.initState();

    // Check if the image is already in the cart
    isAddedToCart =
        repo.getCartItems().any((item) => item.imageID == widget.imageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isAddedToCart ? Icons.shopping_cart : Icons.add_shopping_cart,
              color: isAddedToCart ? Colors.green : Colors.white,
            ),
            onPressed: () {
              setState(() {
                // Toggle cart state
                isAddedToCart = !isAddedToCart;
              });

              // Show confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isAddedToCart ? 'Added to Cart' : 'Removed from Cart',
                  ),
                ),
              );

              // Create an image object to add or remove from cart
              Images image = Images(
                imageID: widget.imageId,
                imagePotraitPath: widget.imageUrl,
                imageAlt: '',
              );

              // Call repository to add/remove from cart
              if (isAddedToCart) {
                repo.addToCart(image);
              } else {
                repo.removeFromCart(widget.imageId);
              }
            },
          )
        ],
      ),
      body: CachedNetworkImage(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        imageUrl: widget.imageUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(230, 10, 10, .5),
        foregroundColor: const Color.fromRGBO(255, 255, 255, .8),
        shape: const CircleBorder(),
        onPressed: () {
          repo.downloadImage(
              imageUrl: widget.imageUrl,
              imageId: widget.imageId,
              context: context);
        },
        child: const Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
