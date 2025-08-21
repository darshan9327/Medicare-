import 'package:get/get.dart';
import '../WishList/wish_list.dart';

class WishlistController extends GetxController {
  var wishlist = <Product>[].obs;

  void addToWishlist(Product product) {
    // Prevent duplicates
    if (!wishlist.any((item) => item.name == product.name)) {
      wishlist.add(product);
    }
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
  }
}
