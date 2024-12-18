class Product {
  final String name;
  final String description;
  final String image;
  final double price;
  final String unit;
  final double? rating; // Nullable rating field

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.unit,
    this.rating,
  });
}
