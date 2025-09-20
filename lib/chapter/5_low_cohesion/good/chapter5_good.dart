// ignore_for_file: non_constant_identifier_names, unused_element, slash_for_doc_comments

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

void main() {
  //5.7
  _GiftPoint standardMemberShipPoint = _GiftPoint.forStandardMembership();
  _GiftPoint premiumMemberShipPoint = _GiftPoint.forPremiumMembership();
}
