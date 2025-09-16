// 5.1
// 注文を管理するクラス
// ignore_for_file: non_constant_identifier_names, slash_for_doc_comments

class OrderManager {
  static int add(int moneyAmount1, int moneyAmount2) {
    return moneyAmount1 + moneyAmount2;
  }
}

// 5.1.3
class PaymentManager {
  int _discountRate;

  PaymentManager(this._discountRate);

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

// 5.2

void main() {}
