// ignore_for_file: prefer_initializing_formals

import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/currency.dart';

// 4.1.2
class Money {
  final int totalPrice;
  final Currency? currency;
  // ignore: non_constant_identifier_names
  final int MAX_TOTAL_PRICE = 1000000;

  Money(int amount, Currency? currency)
    : assert(amount >= 0, 'Amount cannot be negative'),
      assert(currency != null, 'Currency cannot be null'),
      totalPrice = amount,
      currency = currency;

  // Bad: 引数にfinal修飾子をつけていないため、引数productPriceが再代入されている
  void addPrice(int productPrice) {
    productPrice = totalPrice + productPrice;

    if (MAX_TOTAL_PRICE < productPrice) {
      throw ArgumentError('購入金額の上限を超えています。');
    }
  }
}
