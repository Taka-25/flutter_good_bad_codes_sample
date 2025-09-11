// ignore_for_file: non_constant_identifier_names, slash_for_doc_comments

import 'dart:math';

import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/bad/enemy.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/bad/member.dart';
import 'package:flutter_good_bad_codes_sample/src/utils/logger/logger.dart';

// 4.1.1, 4.2.2
class AttackPower {
  static final int MIN = 0;
  final Member member;
  final Enemy enemy;
  int value; // finalが付いてないので可変

  AttackPower(this.member, this.enemy, this.value);

  int damage() {
    // Bad: ローカル変数にfinal修飾子をつけていないため、何度も再代入されている
    // これでは変数tmpの意味がわかりづらく、バグの温床になる

    // メンバーの腕力と武器性能が基本攻撃力
    int tmp = member.power + member.weaponAttack;

    // メンバーのスピードで攻撃力を補正
    tmp = tmp * (1.0 + member.speed / 100.0).toInt();

    // 攻撃力から敵の防御力を差し引いたのがダメージ
    tmp = tmp - enemy.defense ~/ 2;

    // ダメージ値が負数にならないよう補正
    tmp = max(0, tmp);

    return tmp;
  }

  /*
  * 攻撃力を強化する
  * @param increment 攻撃力の増分
  * @return 強化された攻撃力
  */
  void reinforce(int increment) {
    value += increment;
  }

  /** 無力化する */
  void disable() {
    value = 0;
  }
}

void main() {
  AttackPower attackPower = AttackPower(
    Member('戦士', 100, 50, 20),
    Enemy(30),
    0,
  );
  attackPower.reinforce(15);

  Log.d(attackPower.value.toString()); // 15

  // ここまでは正常動作

  // どこかで
  attackPower.disable();
  Log.d(attackPower.value.toString()); // 0

  // このように、別のスレッドでAttackPowerのインスタンスを使い回すと、いつの間にか攻撃力が0になってしまう
}
