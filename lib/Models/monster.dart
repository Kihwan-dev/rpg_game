import 'dart:math';

import 'package:rpg_game/Models/character.dart';

class Monster {
  String name;
  int hp;
  int ap;
  int dp = 0;

  Monster(this.name, this.hp, this.ap);

  void attackCharacter(Character character) {
    character.hp -= (ap - character.dp);
    print("$name이(가) ${character.name}에게 ${ap - character.dp}만큼의 데미지를 입혔습니다.");
  }

  // 유저에게 공격을 가하여 피해 입힘
  // 데미지(몬스터 공격력 - 유저 방어력)
  void showStatus() {
    print("$name - 체력 : $hp, 공격력 : $ap");
  }

  void setAp(int characterDp) {
    ap = Random().nextInt(ap - characterDp) + characterDp;
  }
}
