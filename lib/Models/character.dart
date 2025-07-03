import 'dart:math';

import 'package:rpg_game/Models/monster.dart';
import 'package:rpg_game/Models/unit.dart';
import 'package:rpg_game/Utils/utils.dart';

class Character extends Unit {
  ItemStatus item = ItemStatus.none;

  Character(super.name, super.hp, super.ap, super.dp);

  // 상태 출력
  @override
  void showStatus() {
    // 유저 정보 출력
    print("$name - 체력 : $hp, 공격력 : $ap, 방어력 : $dp");
  }

  @override
  void attack(target) {
    if (target is Monster) {
      target.hp -= (ap - target.dp);
      print("$name이(가) ${target.name}에게 ${ap - target.dp}의 데미지를 입혔습니다.");
    }
  }

  // 방어 시 특정 해동 수행(몬스터가 입힌 데미지만큼 hp 상승)
  void defend(Monster monster) {
    hp += (monster.ap - dp);
    print("$name이(가) 방어 태세를 취하여 ${monster.ap - dp} 만큼 체력을 얻었습니다.");
  }

  void recover() {
    if(Random().nextInt(100) < 30) {
      hp += 10;
      print("보너스 체력을 얻었습니다! 현재 체력: $hp");
    }
  }

  void useItem() {
    item = ItemStatus.using;
    ap *= 2;
  }
}
