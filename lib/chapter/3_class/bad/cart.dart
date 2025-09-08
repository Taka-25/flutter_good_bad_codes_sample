import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/product.dart';

class Cart {
  // Bad: インスタンス変数がなく、メソッドしかない
  List<Product> add(Product product) {
    final List<Product> products = [];
    products.add(product);
    return products;
  }

}