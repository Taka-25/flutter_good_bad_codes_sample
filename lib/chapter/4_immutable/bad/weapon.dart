import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/bad/attack_power.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/bad/enemy.dart';
import 'package:flutter_good_bad_codes_sample/chapter/4_immutable/bad/member.dart';
import 'package:flutter_good_bad_codes_sample/src/utils/logger/logger.dart';

// 4.2.1
class Weapon {
  final AttackPower attackPower;

  Weapon(this.attackPower);

  /*
  * 武器を強化する
  * @param increment 攻撃力の増分
  * @return 強化した武器
  */
  // Weapon reinforce(final AttackPower increment) {
  //   final reinforced = attackPower.reinforce(increment);
  //   return Weapon(reinforced);
  // }
}

void main() {
  // Bad: AttackPowerのインスタンスを使い回している
  AttackPower attackPower = AttackPower(
    Member('戦士', 100, 50, 20),
    Enemy(30),
    0,
  );

  Weapon weaponA = Weapon(attackPower);
  Weapon weaponB = Weapon(attackPower);

  weaponA.attackPower.value = 25;

  Log.d(weaponA.attackPower.value.toString()); // 25
  Log.d(weaponB.attackPower.value.toString()); // 25

  // Bad: AttackPowerのインスタンスを使い回しているため、weaponAの攻撃力強化がweaponBに影響してしまう
}
