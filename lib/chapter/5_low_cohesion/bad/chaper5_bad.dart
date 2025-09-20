// 5.1
// 注文を管理するクラス
// ignore_for_file: non_constant_identifier_names, slash_for_doc_comments

import 'dart:math';

class OrderManager {
  static int add(int moneyAmount1, int moneyAmount2) {
    return moneyAmount1 + moneyAmount2;
  }
}

// 5.1.3
class PaymentManager {
  PaymentManager();

  int add(int moneyAmount1, int moneyAmount2) {
    return moneyAmount1 + moneyAmount2;
  }
}

// 5.2
class GiftPoint {
  static final int _MIN_POINT = 0;
  final int value;

  GiftPoint(this.value) {
    if (value < _MIN_POINT) {
      throw ArgumentError('ポイントが0以上ではありません。');
    }
  }

  /** 
   * ポイントを加算する。
   * 
   * @param other 加算ポイント
   * @return 加算後の残余ポイント
   */
  GiftPoint add(final GiftPoint other) {
    return GiftPoint(value + other.value);
  }

  /**
   * @return 残余ポイントが消費ポイント以上であればtrue
   */
  bool isEnough(final ConsumptionPoint point) {
    return point.value <= value;
  }

  /** 
   * ポイントを減算する。
   * 
   * @param point 消費ポイント
   * @return 消費後の残余ポイント
   */
  GiftPoint consume(final ConsumptionPoint point) {
    if (!isEnough(point)) {
      throw ArgumentError('ポイントが不足しています。');
    }

    return GiftPoint(value - point.value);
  }
}

// 5.5, 5.6
// Bad: コンストラクタを公開しているせいで、関連ロジックが分散し低凝集になっている
GiftPoint standardMemberShipPoint = GiftPoint(3000);
GiftPoint premiumMemberShipPoint = GiftPoint(5000);

class ConsumptionPoint {
  static final int _MIN_POINT = 0;
  final int value;

  ConsumptionPoint(this.value) {
    if (value < _MIN_POINT) {
      throw ArgumentError('ポイントが0以上ではありません。');
    }
  }
}

// 5.10, 5.11
// Bad: 関連のないメソッドが1つのクラスに集約されており、低凝集になっている
class Common {
  // 税込み金額を計算する
  static BigDecimal calcAmountIncludingTax(
    BigDecimal amountExcludingTax,
    BigDecimal taxRate,
  ) {
    return amountExcludingTax.multiply(taxRate);
  }

  // ユーザーが退会済みの場合 true
  static bool hasResigned(User user) {
    // 省略
    return user.resignationDate != null;
  }

  static void createOrder(Product product) {
    // 省略
  }

  // 有効な電話番号である場合 true
  static bool isValidPhoneNumber(String phoneNumber) {
    // 省略
    return true;
  }
}

// 5.10, 5.11用クラス
class BigDecimal {
  final double value;

  BigDecimal(this.value);

  BigDecimal multiply(BigDecimal other) {
    return BigDecimal(value * other.value);
  }
}

// 5.10, 5.11用クラス
class User {
  final DateTime? resignationDate;

  User(this.resignationDate);
}

// 5.10, 5.11用クラス
class Product {
  // 省略
}

// 5.14
// Bad: 引数の変更をしている
class ActorManager {
  void shift(Location location, int shiftX, int shiftY) {
    location.x += shiftX;
    location.y += shiftY;
  }
}

// 5.15
// Bad: まったく同じクラスが別のクラスに存在してしまっている
class SpecialAttackManager {
  void shift(Location location, int shiftX, int shiftY) {
    location.x += shiftX;
    location.y += shiftY;
  }
}

// 5.14, 5.15用クラス
class Location {
  int x;
  int y;

  Location(this.x, this.y);
}

// 5.17
// Bad: 引数変更していることが外部からわからない
class DiscountManager {
  void set(MoneyData money) {
    money.amount -= 2000;
    if (money.amount < 0) {
      money.amount = 0;
    }
  }
}

// 5.17用クラス
class MoneyData {
  int amount;

  MoneyData(this.amount);
}

// 5.23
// Bad: メソッド引数が多すぎる。このような場合、不注意で正しくない値を代入してしまう可能性が高まる
class MagicPoint {
  /**
   * 魔法力を回復する
   * @param currentMagicPoint 現在の魔法力残量
   * @param originalMagicPoint オリジナルの魔法力の最大値
   * @param maxMagicPointIncrements 魔法力最大値の増分
   * @return 回復後の魔法力残量
   */
  int recoverMagicPoint(
    int currentMagicPoint,
    int originalMagicPoint,
    List<int> maxMagicPointIncrements,
    int recoveryAmount,
  ) {
    int currentMaxMagicPoint = originalMagicPoint;
    for (int each in maxMagicPointIncrements) {
      currentMaxMagicPoint += each;
    }
    return min(currentMagicPoint + recoveryAmount, currentMaxMagicPoint);
  }
}

// 5.24
// Bad: プリミティブ型執着。このように実装すると、重複コードや演算ロジックががあちこちに無秩序に実装されやすくなる
class PrimitiveCommon {
  int discountedPrice(int regularPrice, double discountRate) {
    if (regularPrice < 0) {
      throw ArgumentError('価格が0以上ではありません。');
    }
    if (discountRate < 0.0) {
      throw ArgumentError('割引率が0以上ではありません。');
    }
    return (regularPrice * (1.0 - discountRate)).toInt();
  }
}

// 5.25
// Bad: プリミティブ型執着。5.24のdiscountedPrice同様にregularPriceのバリデーションが重複してしまっている
class Util {
  bool isFairPrice(int regularPrice) {
    if (regularPrice < 0) {
      throw ArgumentError('価格が0以上ではありません。');
    }
    return regularPrice >= 1000;
  }
}

void main() {}
