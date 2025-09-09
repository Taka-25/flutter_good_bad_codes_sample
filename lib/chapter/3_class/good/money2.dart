// ignore_for_file: prefer_initializing_formals

import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/currency.dart';

// 3.2.3 ~ 3.2.6
class Money2 {
  // Good: final修飾子をつけて、インスタンス変数が何度も変更されることを防いでいる
  final int amount;
  final Currency? currency;

  // Javaでは、final修飾子をつけた場合は1度のみ代入できる。これを使って初期化する
  // しかし、Dartでfinal修飾子をつけた場合、以下の方法でしか初期化できない
  Money2(int amount, Currency? currency)
    : assert(amount >= 0, 'Amount cannot be negative'),
      assert(currency != null, 'Currency cannot be null'),
      amount = amount,
      currency = currency;

  // Good: インスタンス変数を直接変更する代わりに、新しいインスタンスを返すメソッドを実装している
  // Good: 引数にfinal修飾子をつけることで、引数が変更されることを防いでいる
  Money2 add(final int other) {
    // Good: ローカル変数にfinal修飾子をつけることで、変更されることを防いでいる
    final int added = amount + other;
    return Money2(added, currency);
  }

  // Good: 引数にMoney2型を指定することで、誤って異なる値を渡すことを防いでいる
  Money2 addMoney(final Money2 other) {
    final int added = amount + other.amount;
    return Money2(added, currency);
  }

  // Good: 現実的にありえないメソッドを実装していない
  // Money2 multiply(final double factor) {
  //   final int multiplied = (amount * factor).toInt();
  //   return Money2(multiplied, currency);
  // }
}
