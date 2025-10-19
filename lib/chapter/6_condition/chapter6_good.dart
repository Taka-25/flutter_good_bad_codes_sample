// Good: 早期returnでネスト解消している
// これにより可読性・保守性が上がっている
import 'dart:math';

import 'package:flutter_good_bad_codes_sample/src/utils/logger/logger.dart';

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
  final int level; // 6.18
  final int agility; // 6.18
  final int magicAttack; // 6.18
  final int vitality; // 6.18

  Member(
    this.hitPoint,
    this.canAct,
    this.magicPoint,
    this.technicalPoint,
    this.maxHitPoint,
    this.level,
    this.agility,
    this.magicAttack,
    this.vitality,
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

  Magic._({
    required this.name,
    required this.costMagicPoint,
    required this.attackPower,
    required this.costTechnicalPoint,
    required this.incrementTechnicalPoint,
  });

  // 6.18
  //（Javaのswitch文のコンストラクタを、Dartでfactoryを使って再現している）
  // Good: 1つのswitch文ですべて切り替えているため、仕様変更時時の抜け漏れを抑止できる
  factory Magic(final MagicType magicType, final Member member) {
    switch (magicType) {
      case MagicType.fire:
        return Magic._(
          name: "ファイア",
          costMagicPoint: 2,
          attackPower: 20 + (member.level * 0.5).toInt(),
          costTechnicalPoint: 0,
          incrementTechnicalPoint: 0,
        );

      case MagicType.shiden:
        return Magic._(
          name: "紫電",
          costMagicPoint: 5 + (member.level * 0.2).toInt(),
          attackPower: 50 + (member.agility * 1.5).toInt(),
          costTechnicalPoint: 5,
          incrementTechnicalPoint: 0,
        );

      case MagicType.hellFire:
        return Magic._(
          name: "地獄の業火",
          costMagicPoint: 16,
          attackPower: 200 + (member.magicAttack * 0.5).toInt(),
          costTechnicalPoint: 20 + (member.level * 0.4).toInt(),
          incrementTechnicalPoint: 0,
        );
    }
  }
}

// 6.18用のenum
enum MagicType { fire, shiden, hellFire }

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

// 6.23
abstract class Shape {
  double area();
}

// 6.24
class Rectangle implements Shape {
  final double _width;
  final double _height;

  Rectangle(this._width, this._height);

  @override
  double area() {
    return _width * _height;
  }
}

// 6.24
class Circle implements Shape {
  final double _radius;

  Circle(this._radius);

  @override
  double area() {
    return _radius * pi;
  }
}

void main() {
  // 6.25
  Shape shape = Circle(10);
  Log.d("${(shape.area())}");

  shape = Rectangle(20, 25);
  Log.d("${(shape.area())}");

  // 6.26
  // Good: 型判定のif文が不要になった
  void showArea(Shape shape) {
    Log.d("${(shape.area())}");
  }

  Rectangle rectangle = Rectangle(8, 12);
  showArea(rectangle);
}

// 6.28
abstract class InterfaceMagic {
  final String name;
  final int costMagicPoint;
  final int attackPower;
  final int costTechnicalPoint;

  InterfaceMagic(
    this.name,
    this.costMagicPoint,
    this.attackPower,
    this.costTechnicalPoint,
  );
}
