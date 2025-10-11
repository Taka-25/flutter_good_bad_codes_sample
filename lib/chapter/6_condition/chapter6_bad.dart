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
  final int maxHitPoint; // 6.7用の変数

  BadMember(this.hitPoint, this.canAct, this.magicPoint, this.maxHitPoint);

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

// 6.7
// Bad: else句が多すぎて可読性が低い
class BadHealthCondition {
  const BadHealthCondition();

  BadHealthConditionEnum getHealthConditionByHitPointRate(BadMember member) {
    final hitPointRate = member.hitPoint / member.maxHitPoint;

    BadHealthConditionEnum currentHealthCondition;

    if (hitPointRate == 0) {
      currentHealthCondition = BadHealthConditionEnum.dead;
    } else if (hitPointRate < 0.3) {
      currentHealthCondition = BadHealthConditionEnum.danger;
    } else if (hitPointRate < 0.5) {
      currentHealthCondition = BadHealthConditionEnum.caution;
    } else {
      currentHealthCondition = BadHealthConditionEnum.fine;
    }
    return currentHealthCondition;
  }
}

// 6.7用enum
enum BadHealthConditionEnum { dead, danger, caution, fine }

// 6.10
enum BadMagicType { fire, shiden }

// 6.11
// Bad: switch文で表示名を切り替えている
class BadMagicManager {
  BadMagicManager();

  String getName(BadMagicType magicType) {
    String name = "";

    switch (magicType) {
      case BadMagicType.fire:
        name = "ファイア";

      case BadMagicType.shiden:
        name = "紫電";

        break;
    }

    return name;
  }
}
