// ignore_for_file: prefer_initializing_formals

import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/currency.dart';

// 3.2.3 ~ 3.2.6
class Money2 {
  // Bad: final修飾子をつけていないため、インスタンス変数が何度も変更される可能性がある
  int amount = 0;
  Currency? currency;

  Money2(int amount, Currency? currency) {
    // Bad: ガード節が実装されておらず、不正値が入る可能性がある

    // Java風の初期化方法。本来ならDartのwarningが出るが、オフにしている
    this.amount = amount;
    this.currency = currency;
  }

  // Bad: 新しいインスタンスを返すのではなく、自身のインスタンス変数を直接変更してしまっている
  // Bad: 引数にfinal修飾子をつけておらず、引数が変更されてしまっている
  void add(int other) {
    other = 999;

    // Bad: ローカル変数にfinal修飾子をつけておらず、変更されてしまっている
    int added = amount += other;
    added = 999;
    amount = added;
  }

  // Bad: 引数に型指定をしておらず、無関係な値を渡してしまっている（int型のように、同じ型の場合よく発生する）
  Money2 addMoney(final int ticketCount) {
    final int added = amount + ticketCount;
    return Money2(added, currency);
  }

  // Bad: 現実的にありえないメソッドを実装してしまっている（=バグの原因となる）
  Money2 multiply(final double factor) {
    final int multiplied = (amount * factor).toInt();
    return Money2(multiplied, currency);
  }
}
