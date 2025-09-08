import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/product.dart';

class Cart {
  Cart(final List<Product> products){
    this.products.addAll(products);
  }

  // Good: インスタンス変数、メソッドの両方がある
  final List<Product> products = [];

  void add(Product product) {
    products.add(product);
  }

  void remove(Product product) {
    products.remove(product);
  }
}