// ignore_for_file: prefer_initializing_formals

import 'package:flutter_good_bad_codes_sample/chapter/3_class/good/currency.dart';

// 3.2 ~ 3.2.2
class Money1 {
  int amount = 0;
  Currency? currency;

  Money1(int amount, Currency? currency) {
    // Good: ガード節で不正値が入ることを防ぎ、安全にインスタンス変数を初期化している
    if (amount < 0) {
      throw ArgumentError('Amount cannot be negative');
    }
    if (currency == null) {
      throw ArgumentError('Amount cannot be null');
    }

    // Java風の初期化方法。本来ならDartのwarningが出るが、オフにしている
    this.amount = amount;
    this.currency = currency;
  }

  // Good: 自身のインスタンス変数を変更するメソッドを自前で実装しており、クラス内で完結している
  void add(int other) {
    amount += other;
  }
}
