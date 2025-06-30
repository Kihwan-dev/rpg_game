
import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/game.dart';
import 'package:rpg_game/Models/monster.dart';
import 'package:rpg_game/Utils/intro.dart';

void main(List<String> arguments) {
  // 파일에서 캐릭터 정보 불러오기
  Character character = loadCharacterStatus();

  // 파일에서 몬스터 정보 불러오기
  List<Monster> monsterList = loadMonsterStatus();

  // 게임 생성
  Game game = Game(character, monsterList);
  game.startGame();
}
