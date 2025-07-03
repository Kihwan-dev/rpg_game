import 'dart:math';

import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/unit.dart';

class Monster extends Unit {
  Monster(super.name, super.hp, super.ap, super.dp);

  // 유저에게 공격을 가하여 피해 입힘
  // 데미지(몬스터 공격력 - 유저 방어력)
  @override
  void showStatus() {
    print("$name - 체력: $hp, 공격력: $ap\n");
  }

  void setAp(int characterDp) {
    ap = Random().nextInt(ap - characterDp) + characterDp;
  }

  @override
  void attack(Character target) {
    final damage = ap - target.dp;
    target.hp -= damage;
    print("$name이(가) ${target.name}에게 $damage만큼의 데미지를 입혔습니다.");
  }
}
