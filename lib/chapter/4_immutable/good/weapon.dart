import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/attack_power.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/enemy.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/good/member.dart';

// 4.2.1
class Weapon {
  final AttackPower attackPower;

  Weapon(this.attackPower);

  /*
  * 武器を強化する
  * @param increment 攻撃力の増分
  * @return 強化した武器
  */
  Weapon reinforce(final AttackPower increment) {
    // Good: 既存のインスタンスを変更せず、新しいインスタンスを生成して返す
    final reinforced = attackPower.reinforce(increment);
    return Weapon(reinforced);
  }
}

// Good: 攻撃力のインスタンスを個別に生成している
AttackPower attackPowerA = AttackPower(Member('戦士', 100, 50, 20), Enemy(30), 0);
AttackPower attackPowerB = AttackPower(Member('盗賊', 90, 60, 40), Enemy(25), 0);
AttackPower attackPowerC = AttackPower(Member('僧侶', 70, 40, 10), Enemy(15), 0);
