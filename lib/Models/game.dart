import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/monster.dart';

class Game {
  Character character;
  List<Monster> monsterList = [];
  int killMonsterCount = 0;

  Game(this.character, this.monsterList);

  void startGame() {
    print("게임을 시작합니다!");
    
  }

  void battle() {}

  void getRandomMonster() {}
}