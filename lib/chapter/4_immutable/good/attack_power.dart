import 'dart:math';

import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/enemy.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/member.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/weapon.dart';

// 4.1.1, 4.2.1, 4.2.2 ~ 4.2.5
class AttackPower {
  final Member member;
  final Enemy enemy;
  final int value;

  AttackPower(this.member, this.enemy, this.value);

  int damage() {
    // Good: ローカル変数にfinal修飾子をつけて再代入を防いでいる

    // メンバーの腕力と武器性能が基本攻撃力
    final int basicAttackPower = member.power + member.weaponAttack;

    // メンバーのスピードで攻撃力を補正
    final int finalAttackPower =
        basicAttackPower * (1.0 + member.speed / 100).toInt();

    // 攻撃力から敵の防御力を差し引いたのがダメージ
    // ~/は整数除算。小数点以下を切り捨てたint型を返す
    final int reduction = enemy.defense ~/ 2;

    // ダメージ値が負数にならないよう補正
    final int damage = max(0, finalAttackPower - reduction);

    return damage;
  }

  /*
  * 攻撃力を強化する
  * @param increment 攻撃力の増分
  * @return 強化された攻撃力
  */
  AttackPower reinforce(final AttackPower increment) {
    // Good: 既存のインスタンスを変更せず、新しいインスタンスを生成して返す
    return AttackPower(member, enemy, value + increment.value);
  }
}

final attackPowerA = AttackPower(Member('戦士', 100, 50, 20), Enemy(30), 0);
final attackPowerB = AttackPower(Member('盗賊', 90, 60, 40), Enemy(25), 0);

final weaponA = Weapon(attackPowerA);
final weaponB = Weapon(attackPowerB);

final increment = AttackPower(Member('戦士', 100, 50, 20), Enemy(30), 10);
final reinforcedWeaponA = weaponA.reinforce(increment);
