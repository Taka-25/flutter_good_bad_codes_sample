// ignore_for_file: non_constant_identifier_names, unused_element, slash_for_doc_comments, constant_identifier_names, unused_field
import 'dart:math';

import 'package:flutter_good_bad_codes_sample/src/utils/logger/logger.dart';

// 5.7
// Good: コンストラクタがprivateで、目的別のファクトリメソッドを用意している
//コンストラクタが非公開であることで、関連ロジックの分散を防いでいる
class _GiftPoint {
  static final int _MIN_POINT = 0;
  static final int STANDARD_MEMBERSHIP_POINT = 3000;
  static final int PREMIUM_MEMBERSHIP_POINT = 10000;
  final int value;

  _GiftPoint(final int point)
    : assert(point < _MIN_POINT, "ポイントが0以上ではありません。"),
      value = point;

  /**
   * @return 標準会員向け入会ギフトポイント
   */
  static _GiftPoint forStandardMembership() {
    return _GiftPoint(STANDARD_MEMBERSHIP_POINT);
  }

  /**
   * @return プレミアム会員向け入会ギフトポイント
   */
  static _GiftPoint forPremiumMembership() {
    return _GiftPoint(PREMIUM_MEMBERSHIP_POINT);
  }
}

// 5.12
// Good: オブジェクト指向設計の基本にもとづき、関連ロジックをクラスにまとめている
// （安易に共通処理クラスを実装していない）
class AmountIncludingTax {
  final BigDecimal value;

  AmountIncludingTax(
    final AmountIncludingTax amountIncludingTax,
    final TaxRate taxRate,
  ) : value = amountIncludingTax.value.multiply(taxRate.value);
}

// 5.12用クラス
class BigDecimal {
  final double value;
  BigDecimal(this.value);

  BigDecimal multiply(BigDecimal other) {
    return BigDecimal(value * other.value);
  }
}

// 5.12用クラス
class TaxRate {
  final BigDecimal value;
  TaxRate(this.value);
}

// 5.13
// Good: 横断的関心事であるログ出力をstaticメソッドにして呼び出している
class ShoppingCart {
  final Product product;
  final products = [];

  ShoppingCart(this.product);

  void add(final Product product) {
    try {
      products.add(product);
    } catch (e) {
      Log.e("問題が発生しました。買い物かごに商品を追加できません");
    }
  }
}

// 5.13用クラス
class Product {}

// 5.18
// Good: 引数を変更しない構造になっている
class Location {
  final int x;
  final int y;

  Location(this.x, this.y);

  Location shift(final int shiftX, final int shiftY) {
    final int nextX = x + shiftX;
    final int nextY = x + shiftY;
    return Location(nextX, nextY);
  }
}

// 5.21
// Good: ヒットポイントを値オブジェクトとして設定している
class HitPoint {
  static const int _MIN = 0;
  // ignore: unused_field
  final int _value;
  final MaxHitPoint _maxHitPoint;

  HitPoint(int value, MaxHitPoint maxHitPoint)
    : assert(value < _MIN, "0以上を指定してください"),
      _value = value,
      _maxHitPoint = maxHitPoint;

  HitPoint RecoverCompletely() {
    return HitPoint(_maxHitPoint.value, _maxHitPoint);
  }
}

// 5.21用クラス
class MaxHitPoint {
  final int value;
  MaxHitPoint(this.value);
}

// 5.26
// Good: 「定価」という具体的な型として設計されている
class RegularPrice {
  final int amount;

  RegularPrice(this.amount) : assert(amount < 0, ArgumentError());
}

// 5.27
// Good: プリミティブ型ではなくクラスの型を渡している
class DiscountedPrice {
  final int amount;
  DiscountedPrice(
    final RegularPrice regularPrice,
    final DiscountRate discountRate, {
    this.amount = 0,
  });
}

// 5.27用クラス
class DiscountRate {}

// 5.29
// Good: 魔法力に関するロジックをカプセル化している
class MagicPoint {
  int _currentAmount;
  // ignore: prefer_final_fields
  int _originalMaxAmount;
  final List<int> _maxIncrements;

  MagicPoint(this._currentAmount, this._originalMaxAmount, this._maxIncrements);

  int current() {
    return _currentAmount;
  }

  int max() {
    int amount = _originalMaxAmount;
    for (int each in _maxIncrements) {
      amount += each;
    }
    return amount;
  }

  void recover(final int recoveryAmount) {
    _currentAmount = min(_currentAmount + recoveryAmount, max());
  }

  void consume(final int consumeAmount) {
    // 省略
  }
}

// 5.31
// Good: 詳細なロジックを呼ぶ側ではなく、呼ばれる側に実装している
class Equipments {
  final bool _canChange;
  Equipment _head;
  Equipment _armor;
  Equipment _arm;
  Equipments(this._canChange, this._head, this._armor, this._arm);

  void equipArmor(final Equipment newArmor) {
    if (_canChange) {
      _armor = newArmor;
    }
  }

  void deactivateAll() {
    _head = Equipment.EMPTY;
    _armor = Equipment.EMPTY;
    _arm = Equipment.EMPTY;
  }
}

// 5.31用クラス
class Equipment {
  static Equipment EMPTY = Equipment();
}

void main() {
  // 5.8, 5.9
  // ignore: unused_local_variable
  _GiftPoint standardMemberShipPoint = _GiftPoint.forStandardMembership();
  // ignore: unused_local_variable
  _GiftPoint premiumMemberShipPoint = _GiftPoint.forPremiumMembership();
}
