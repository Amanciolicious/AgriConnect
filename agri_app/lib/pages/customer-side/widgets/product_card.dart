import 'package:agri_app/pages/customer-side/models/product.dart';
import 'package:agri_app/pages/customer-side/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isBookmarked = false; // Tracks the bookmark state

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    // Mock implementation for saving the bookmark
    // Replace this with a real database call or API request
    if (isBookmarked) {
      ("${widget.product.name} added to bookmarks.");
    } else {
      ("${widget.product.name} removed from bookmarks.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Product Details Page
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: widget.product),
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: 0.2,
            color: Colors.grey.shade400,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Bookmark Icon
            Container(
              height: 120,
              alignment: Alignment.topLeft,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.product.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  onPressed: toggleBookmark,
                  iconSize: 18,
                  icon: Icon(
                    isBookmarked ? IconlyBold.bookmark : IconlyLight.bookmark,
                    color: isBookmarked ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price and Unit
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "₱${widget.product.price}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: "/${widget.product.unit}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      // Add to Cart Icon
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton.filled(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Navigate to Product Details Page
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: widget.product),
                            ));
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
