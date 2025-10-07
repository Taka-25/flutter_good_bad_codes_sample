// Good: 早期returnでネスト解消している
// これにより可読性・保守性が上がっている
class MagicAttack {
  final Member member;
  final Magic magic;
  MagicAttack(this.member, this.magic);

  /// 6.1（badサンプル）
  // void magicAttack() {
  //   if (0 < member.hitPoint) {
  //     if (member.canAct) {
  //       if (magic.costMagicPoint <= member.magicPoint) {
  //         member.consumerMagicPoint(member.magicPoint);
  //         member.chant(magic);
  //       }
  //     }
  //   }
  // }

  // 6.3
  void magicAttackA() {
    if (member.hitPoint <= 0) return;

    if (member.canAct) {
      if (magic.costMagicPoint <= member.magicPoint) {
        member.consumerMagicPoint(magic.costMagicPoint);
        member.chant(magic);
      }
    }
  }

  // 6.4
  // Good: 6.3を改善し、すべてのネストを解消している
  // ネスト解消することで、条件ロジックと実行ロジックを分離できる
  void magicAttackB() {
    if (member.hitPoint <= 0) return;

    if (!member.canAct) return;

    if (member.magicPoint < magic.costMagicPoint) return;

    member.consumerMagicPoint(magic.costMagicPoint);
    member.chant(magic);
  }
}

// 6.3用クラス
class Member {
  final int hitPoint;
  final bool canAct;
  final int magicPoint;
  Member(this.hitPoint, this.canAct, this.magicPoint);

  // 6.3用メソッド
  void consumerMagicPoint(int magicPoint) {}

  // 6.3用メソッド
  void chant(Magic magic) {}
}

// 6.3用クラス
class Magic {
  final int costMagicPoint;
  Magic(this.costMagicPoint);
}
