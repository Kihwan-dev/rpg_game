import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/monster.dart';

class Game {
  Character character;
  List<Monster> monsterList = [];
  int killCnt = 0;

  Game(this.character);

  void startGame() {}

  void battle() {}

  void getRandomMonster() {}
}