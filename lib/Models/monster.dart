import 'package:rpg_game/Models/character.dart';

class Monster {
  String name;
  int hp;
  int ap;
  int dp = 0;

  Monster(this.name, this.hp, this.ap);

  void attackCharacter(Character character) {}

  void showStatus() {}
}
