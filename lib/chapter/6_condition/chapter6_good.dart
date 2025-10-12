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

    // 6.5
    // Good: 早期returnでネスト解消しているおかげで、条件追加が容易
    if (member.technicalPoint < magic.costTechnicalPoint) return;

    member.consumerMagicPoint(magic.costMagicPoint);
    member.chant(magic);

    // 6.6
    // Good: 早期returnでネスト解消しているおかげで、実行ロジックの追加も容易
    member.gainTechnicalPoint(magic.incrementTechnicalPoint);
  }
}

// 6.3用クラス
class Member {
  final int hitPoint;
  final bool canAct;
  final int magicPoint;
  final int technicalPoint; // 6.5
  final int maxHitPoint;

  Member(
    this.hitPoint,
    this.canAct,
    this.magicPoint,
    this.technicalPoint,
    this.maxHitPoint,
  );

  // 6.3用メソッド
  void consumerMagicPoint(int magicPoint) {}

  // 6.3用メソッド
  void chant(Magic magic) {}

  // 6.6
  void gainTechnicalPoint(int technicalPoint) {}
}

// 6.3用クラス
class Magic {
  final String name; // 6.18
  final int costMagicPoint;
  final int attackPower; // 6.18
  final int costTechnicalPoint; // 6.5
  final int incrementTechnicalPoint; // 6.6
  Magic(
    this.name,
    this.costMagicPoint,
    this.attackPower,
    this.costTechnicalPoint,
    this.incrementTechnicalPoint,
  );
}

// 6.8
class HealthCondition {
  const HealthCondition();

  HealthConditionEnum getHealthConditionByHitPointRate(Member member) {
    final hitPointRate = member.hitPoint / member.maxHitPoint;

    // 6.8
    // Good: else句を早期returnに置き換えており、可読性が改善している
    // if (hitPointRate == 0) {
    //   return HealthConditionEnum.dead;
    // } else if (hitPointRate < 0.3) {
    //   return HealthConditionEnum.danger;
    // } else if (hitPointRate < 0.5) {
    //   return HealthConditionEnum.caution;
    // } else {
    //   return HealthConditionEnum.fine;
    // }

    // 6.9
    // Good: else句を用いずreturnすることで、さらに可読性が改善している
    if (hitPointRate == 0) return HealthConditionEnum.dead;

    if (hitPointRate < 0.3) return HealthConditionEnum.danger;

    if (hitPointRate < 0.5) return HealthConditionEnum.caution;

    return HealthConditionEnum.fine;
  }
}

// 6.8用enum
enum HealthConditionEnum { dead, danger, caution, fine }
