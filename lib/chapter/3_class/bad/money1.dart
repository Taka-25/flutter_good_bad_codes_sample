// ignore_for_file: prefer_initializing_formals

// 3.2 ~ 3.2.2
import 'package:flutter_good_bad_codes_sample/chapter/3_class/bad/currency.dart';

class Money1 {
  int amount = 0;
  Currency? currency;

  Money1(int amount, Currency? currency) {
    // Bad: ガード節が実装されておらず、不正値が入る可能性がある

    // Java風の初期化方法。本来ならDartのwarningが出るが、オフにしている
    this.amount = amount;
    this.currency = currency;
  }
}

class Calculator {
  // Bad: インスタンス変数を変更するメソッドを自前で実装せず、外部(Calculator)から変更している
  // 今回の例だけでは何とも言えないが、低凝集になりやすい
  void add(Money1 money, int other) {
    money.amount += other;
  }
}
