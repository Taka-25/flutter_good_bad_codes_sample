// 6.1
// Bad: if文で多重にネストした構造
// ネストしすぎて可読性が下がっている。保守性も下がる
class BadMagicAttack {
  final BadMember badMember;
  final BadMagic badMagic;
  BadMagicAttack(this.badMember, this.badMagic);

  void magicAttack() {
    if (0 < badMember.hitPoint) {
      if (badMember.canAct) {
        if (badMagic.costMagicPoint <= badMember.magicPoint) {
          badMember.consumerMagicPoint(badMember.magicPoint);
          badMember.chant(badMagic);
        }
      }
    }
  }
}

// 6.1用クラス
class BadMember {
  final int hitPoint;
  final bool canAct;
  final int magicPoint;
  BadMember(this.hitPoint, this.canAct, this.magicPoint);

  // 6.1用メソッド
  void consumerMagicPoint(int magicPoint) {}

  // 6.1用メソッド
  void chant(BadMagic magic) {}
}

// 6.1用クラス
class BadMagic {
  final int costMagicPoint;
  BadMagic(this.costMagicPoint);
}
