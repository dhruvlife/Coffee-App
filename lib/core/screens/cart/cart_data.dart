class CartData {
  final String image;
  final String name;
  final String category;
  final String description;
  final double rating;
  final double price;
  final String size;
  final int byRate;
  int quantity;

  CartData({
    required this.image,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.price,
    required this.size,
    required this.byRate,
    this.quantity = 1,
  });
}

class CartManager {
  static List<CartData> cartData = [];

  static void addToCart(CartData cartDataItem) {
    bool itemExists = cartData.any((item) => item.name == cartDataItem.name);

    if (itemExists) {
      cartData.firstWhere((item) => item.name == cartDataItem.name).quantity++;
    } else {
      cartData.add(cartDataItem);
    }
  }

  static double getTotalPrice() {
    return cartData.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
