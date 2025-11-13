// Good: 早期returnでネスト解消している
// これにより可読性・保守性が上がっている
import 'dart:collection';
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

// 6.28, 6.29, 6.30の補足
// 抽象クラスの運用は基本的に「インターフェース的抽象クラス」と「抽象基底クラス的抽象クラス」がある。
// 前者はgetterを実装し外部から変更はできない。後者はgetterではなく変数を実装することで、外部から変更できてしまう。基本的に前者で実装するのが望ましい

// 6.28
abstract class InterfaceMagic {
  String get name;
  int get costMagicPoint;
  int get attackPower;
  int get costTechnicalPoint;
}

// 6.29
class Fire implements InterfaceMagic {
  final Member _member;

  Fire(this._member);

  @override
  String get name => "ファイア";

  @override
  int get costMagicPoint => 2;

  @override
  int get attackPower => 20 + (_member.level * 0.5).toInt();

  @override
  int get costTechnicalPoint => 0;
}

// 6.30
class Shiden implements InterfaceMagic {
  final Member _member;

  Shiden(this._member);

  @override
  String get name => "紫電";

  @override
  int get costMagicPoint => 5 + (_member.level * 0.2).toInt();

  @override
  int get attackPower => 50 + (_member.agility * 1.5).toInt();

  @override
  int get costTechnicalPoint => 5;
}

// 6.31
class HellFire implements InterfaceMagic {
  final Member _member;

  HellFire(this._member);

  @override
  String get name => "地獄の業火";

  @override
  int get costMagicPoint => 16;

  @override
  int get attackPower =>
      200 + (_member.magicAttack * 0.5 + _member.vitality * 2).toInt();

  @override
  int get costTechnicalPoint => 20 + (_member.level * 0.4).toInt();
}

// 6.32
// ストラテジパターンをDartで再現
class MagicFactory {
  final Map<MagicType, InterfaceMagic> magics;

  MagicFactory(Member member)
    : magics = {
        MagicType.fire: Fire(member),
        MagicType.shiden: Shiden(member),
        MagicType.hellFire: HellFire(member),
      };

  InterfaceMagic? get(MagicType type) => magics[type];

  // 6.34
  void magicAttack(MagicType magicType) {
    final InterfaceMagic? usingMagic = get(magicType);
    usingMagic!.attackPower;
  }

  void showMagicName(final InterfaceMagic magic) {
    // ignore: unused_local_variable
    final String name = magic.name;
    // nameを使った表示処理
  }

  void consumeMagicPoint(final InterfaceMagic magic) {
    // ignore: unused_local_variable
    final int costMagicPoint = magic.costMagicPoint;
    // costMagicPointを使った魔法力消費処理
  }

  void consumeTechnicalPoint(final InterfaceMagic magic) {
    // ignore: unused_local_variable
    final int costTechnicalPoint = magic.costTechnicalPoint;
    // costTechnicalPointを使ったテクニカルポイント消費処理
  }

  void magicDamage(final InterfaceMagic magic) {
    // ignore: unused_local_variable
    final int attackPower = magic.attackPower;
    // attackPowerを使ったダメージ計算
  }
}

void main2() {
  // 6.33
  // ignore: unused_element
  void magicAttack(final Member member, MagicType magicType) {
    final factory = MagicFactory(member);
    final InterfaceMagic? usingMagic = factory.get(magicType);
    usingMagic!.attackPower;
  }
}

// 6.37
// Good: 値オブジェクト化されており、意図の異なる値を渡してしまうことを懐疑
abstract class ValueObjectMagic {
  String get name;
  MagicPoint get costMagicPoint;
  AttackPower get attackPower;
  TechnicalPoint get costTechnicalPoint;
}

class MagicPoint {
  final int value;

  MagicPoint({required this.value});
}

class AttackPower {
  final int value;

  AttackPower({required this.value});
}

class TechnicalPoint {
  final int value;

  TechnicalPoint({required this.value});
}

// 6.38
class ValueObjectFire implements ValueObjectMagic {
  final Member _member;

  ValueObjectFire(this._member);

  @override
  String get name => "ファイア";

  @override
  MagicPoint get costMagicPoint => MagicPoint(value: 2);

  @override
  AttackPower get attackPower {
    final int value = 20 + (_member.level * 0.5).toInt();
    return AttackPower(value: value);
  }

  @override
  TechnicalPoint get costTechnicalPoint => TechnicalPoint(value: 0);
}

// 6.39
class ValueObjectShiden implements ValueObjectMagic {
  final Member _member;

  ValueObjectShiden(this._member);

  @override
  String get name => "紫電";

  @override
  MagicPoint get costMagicPoint {
    final int value = 5 + (_member.level * 0.2).toInt();
    return MagicPoint(value: value);
  }

  @override
  AttackPower get attackPower {
    final int value = 50 + (_member.agility * 1.5).toInt();
    return AttackPower(value: value);
  }

  @override
  TechnicalPoint get costTechnicalPoint => TechnicalPoint(value: 5);
}

// 6.40
class ValueObjectHellFire implements ValueObjectMagic {
  final Member _member;

  ValueObjectHellFire(this._member);

  @override
  String get name => "地獄の業火";

  @override
  MagicPoint get costMagicPoint {
    return MagicPoint(value: 16);
  }

  @override
  AttackPower get attackPower {
    final int value =
        200 + (_member.magicAttack * 0.5 + _member.vitality * 2).toInt();
    return AttackPower(value: value);
  }

  @override
  TechnicalPoint get costTechnicalPoint {
    final int value = 20 + (_member.level * 0.4).toInt();
    return TechnicalPoint(value: value);
  }
}

// 6.43用クラス
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

// 6.43
abstract class ExcellentCustomerRule {
  bool ok(final PurchaseHistory purchaseHistory);
}

// 6.44
class GoldCustomerPurchaseAmountRule implements ExcellentCustomerRule {
  @override
  bool ok(final PurchaseHistory history) {
    return 100000 >= history.totalAmount;
  }
}

// 6.45
class PurchaseFrequencyRule implements ExcellentCustomerRule {
  @override
  bool ok(final PurchaseHistory history) {
    return 10 <= history.purchaseFrequencyPerMonth;
  }
}

// 6.46
class ReturnRateRule implements ExcellentCustomerRule {
  @override
  bool ok(final PurchaseHistory history) {
    return history.returnRate <= 0.01;
  }
}

// 6.47
class ExcellentCustomerPolicy {
  final Set<ExcellentCustomerRule> rules;

  ExcellentCustomerPolicy({Set<ExcellentCustomerRule>? rules})
    : rules = rules ?? <ExcellentCustomerRule>{};

  void add(final ExcellentCustomerRule rule) {
    rules.add(rule);
  }

  bool complyWithAll(final PurchaseHistory history) {
    for (ExcellentCustomerRule each in rules) {
      if (!each.ok(history)) {
        return false;
      }
    }
    return true;
  }
}

// 6.48
// Not Bad: ロジックか単純化したが、ゴールド会員以外の無関係なロジックを差し込まれてしまう可能性がある
void main3() {
  ExcellentCustomerPolicy goldCustomerPolicy = ExcellentCustomerPolicy();
  goldCustomerPolicy.add(GoldCustomerPurchaseAmountRule());
  goldCustomerPolicy.add(PurchaseFrequencyRule());
  goldCustomerPolicy.add(ReturnRateRule());
  goldCustomerPolicy.complyWithAll(PurchaseHistory(150000, 12, 0.0));
}
