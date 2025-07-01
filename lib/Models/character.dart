import 'package:rpg_game/Models/monster.dart';

class Character {
  String name;
  int hp;
  int ap;
  int dp;

  Character(this.name, this.hp, this.ap, this.dp);

  // 몬스터에게 공격을 가하여 피해를 입힘
  void attackMonster(Monster monster) {
    monster.hp -= (ap - monster.dp);
  }
  // 방어 시 특정 해동 수행(몬스터가 입힌 데미지만큼 hp 상승)
  void defend() {}
  // 상태 출력
  void showStatus() {
    // 유저 정보 출력
    print("$name - 체력 : $hp, 공격력 : $ap, 방어력 : $dp");
  }
}
                                                                               