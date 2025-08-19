import 'package:get/get.dart';

class CartItem {
  final String name;
  final String company;
  final double price;
  int quantity;
  final String image;
  final bool requiresPrescription;

  CartItem({
    required this.name,
    required this.company,
    required this.price,
    this.quantity = 1,
    required this.image,
    this.requiresPrescription = false,
  });

  double get totalPrice => price * quantity;
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(CartItem item) {
    int index = cartItems.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
    }
    cartItems.refresh();
  }
}

