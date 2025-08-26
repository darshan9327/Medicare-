import 'package:get/get.dart';

import '../../Product/pages/product_details_page.dart';

class WishlistController extends GetxController {
  var wishlist = <Product1>[].obs;

  void addToWishlist(Product1 product) {
    wishlist.add(product);
  }

  void removeFromWishlist(Product1 product) {
    wishlist.remove(product);
  }
}
