// 6.1
// Bad: if文で多重にネストした構造
// ネストしすぎて可読性が下がっている。保守性も下がる
// ignore_for_file: unnecessary_cast

import 'dart:math';

import 'package:flutter_good_bad_codes_sample/src/utils/logger/logger.dart';

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
  final int maxHitPoint; // 6.7用のインスタンス変数
  final int level; // 6.12用のインスタンス変数
  final int agility; // 6.13用のインスタンス変数

  BadMember(
    this.hitPoint,
    this.canAct,
    this.magicPoint,
    this.maxHitPoint,
    this.level,
    this.agility,
  );

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
enum BadMagicType { fire, shiden, hellFire }

// 6.11
// Bad: switch文で表示名を切り替えている
class BadMagicManager {
  BadMagicManager();

  // 6.11
  String getName(BadMagicType magicType) {
    String name = "";

    switch (magicType) {
      case BadMagicType.fire:
        name = "ファイア";
        break;

      case BadMagicType.shiden:
        name = "紫電";
        break;

      // 6.14
      case BadMagicType.hellFire:
        name = "地獄の業火";
        break;
    }

    return name;
  }

  // 6.12
  // Bad: switch文で消費魔法力を切り替えている
  int costMagicPoint(BadMagicType magicType, BadMember member) {
    int magicPoint = 0;

    switch (magicType) {
      case BadMagicType.fire:
        magicPoint = 2;
        break;

      case BadMagicType.shiden:
        magicPoint = 5 + (member.level * 0.2).toInt();
        break;

      // 6.15
      case BadMagicType.hellFire:
        magicPoint = 16;
        break;
    }

    return magicPoint;
  }

  // 6.13
  // Bad: switch文で魔法攻撃力を切り替えている
  int attackPower(BadMagicType magicType, BadMember member) {
    int attackPower = 0;

    switch (magicType) {
      case BadMagicType.fire:
        attackPower = 20 + (member.level * 0.5).toInt();
        break;

      case BadMagicType.shiden:
        attackPower = 50 + (member.agility * 1.5).toInt();
        break;

      // 6.16
      // Bad: attackPowerのs場合のケースが実装されていない
      // (Dartは未実装だとエラーになるが、Javaではエラーが出ないことによる)
      case BadMagicType.hellFire:
        throw UnimplementedError();
    }

    return attackPower;
  }

  // 6.17
  // Bad: switch文で消費テクニカルポイントを切り替えている
  int costTechnicalPoint(BadMagicType magicType, BadMember member) {
    int technicalPoint = 0;

    switch (magicType) {
      case BadMagicType.fire:
        technicalPoint = 0;
        break;

      case BadMagicType.shiden:
        technicalPoint = 5;
        break;

      case BadMagicType.hellFire:
        throw UnimplementedError();
    }

    return technicalPoint;
  }
}

// 6.19
class BadRectangle {
  final double _width;
  final double _height;

  BadRectangle(this._width, this._height);

  double area() {
    return _width * _height;
  }
}

// 6.19
class BadCircle {
  final double _radius;

  BadCircle(this._radius);

  double area() {
    return _radius * pi;
  }
}

void main() {
  // 6.21
  // Bad: 異なる型のため代入できない。エラーになる。同名のメソッドがあっても利用できない。
  // BadRectangle rectangle = BadCircle(8);
  // rectangle.area();

  // 6.22
  // Bad: 計算はできているが、isで型判定しなければならない
  void showArea(Object shape) {
    if (shape is BadRectangle) {
      Log.d("${(shape as BadRectangle).area()}");
    }

    if (shape is BadCircle) {
      Log.d("${(shape as BadCircle).area()}");
    }
  }

  // 6.22
  BadRectangle rectangle = BadRectangle(8, 12);
  showArea(rectangle);
}

// 6.41
// Bad: if文が多重にネストしており、可読性が低い
bool isGoldCustomer(PurchaseHistory history) {
  if (100000 <= history.totalAmount) {
    if (10 <= history.purchaseFrequencyPerMonth) {
      if (history.returnRate <= 0.001) {
        return true;
      }
    }
  }
  return false;
}

// 6.41, 6.42用クラス
class PurchaseHistory {
  final int totalAmount;
  final int purchaseFrequencyPerMonth;
  final double returnRate;

  PurchaseHistory(
    this.totalAmount,
    this.purchaseFrequencyPerMonth,
    this.returnRate,
  );
}
