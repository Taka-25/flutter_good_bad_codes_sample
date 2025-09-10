// ignore_for_file: slash_for_doc_comments

import 'dart:math';

// 4.3.3
class HitPoint {
  // ignore: non_constant_identifier_names
  static final int MIN = 0;
  int amount;

  HitPoint(this.amount) {
    if (amount < MIN) {
      throw ArgumentError('HitPoint cannot be negative');
    }
  }

  /**
   * ダメージを受ける
   * @param damageAmount ダメージ量
   */
  void damage(final int damageAmount) {
    final int nextAmount = amount - damageAmount;
    amount = max(MIN, nextAmount);
  }

  /** @return ヒットポイントが0であればtrue */
  bool isZero() {
    return amount == MIN;
  }
}

class Member {
  final HitPoint hitPoint;
  final States states;

  Member(this.hitPoint, this.states);

  /**
   * ダメージを受ける
   * @param damageAmount ダメージ量
   */
  void damage(final int damageAmount) {
    hitPoint.damage(damageAmount);

    if (hitPoint.isZero()) {
      states.add(StateType.dead);
    }
  }
}

class States {
  final List states = [];

  States();

  void add(final StateType state) {
    if (!states.contains(state)) {
      states.add(state);
    }
  }
}

enum StateType { alive, dead }
