import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/monster.dart';
import 'package:rpg_game/Utils/utils.dart';

class Game {
  late Character character;
  late List<Monster> monsterList;
  late Monster monster;
  int killMonsterCount = 0;
  bool isStillFight = true;

  void startGame() {
    // 파일에서 캐릭터 정보 불러오기
    character = loadCharacterStatus();
    // 파일에서 몬스터 정보 불러오기
    monsterList = loadMonsterStatus();

    print("게임을 시작합니다!");
    character.showStatus();

    while (isStillFight) {
      // 몬스터 정보 출력
      monster = getRandomMonster();
      monster.setAp(character.dp);
      monster.showStatus();
      print("");

      // 배틀 시작
      battle();
    }

    endGame();
  }

  void endGame() {
    if (monsterList.isEmpty) {
      print("축하합니다! 모든 몬스터를 물리쳤습니다.");
    } else {
      if(character.hp <= 0) print("사망띠..");
      print("게임을 종료합니다.");
    }
    String result = getValidInput("결과를 저장하시겠습니까? (y/n): ", (input) => input.toLowerCase() == "y" || input.toLowerCase() == "n").toLowerCase();
    if (result == "y") {
      saveResult();
    }
  }

  void battle() {
    /// 유저 턴
    /// ├ 공격하기(1) : "유저가 몬스터에게 (공격력 - 몬스터의 방어력) 만큼의 피해를 입혔습니다."
    /// │ ├ 몬스터의 체력 >  0
    /// │ │ └ -> 몬스터 턴
    /// │ │   └ 공격하기 : "몬스터가 유저에게 (몬스터의 공격력 0 유저의 방어력)의 데미지를 입혔습니다."
    /// │ └ 몬스터의 체력 <= 0
    /// │   └ -> "유저가 몬스터를 물리쳤습니다!"
    /// │     └ -> "다음 몬스터와 싸우시겠습니까? (y/n): "
    /// │       ├ y : 다음 몬스터 출현
    /// │       └ n : "게임을 종료합니다.\n결과를 저장하시겠습니까? (y/n)"
    /// │         ├ y :  결과가 저장되었습니다. / 종료
    /// │         └ n :
    /// └ 방어하기(2) : 유저가 방어 태세를 취하여 (몬스터의 공격력 - 유저의 방어력) 만큼 체력을 얻었습니다.
    ///   └ 몬스터 턴
    ///     └ 공격하기 : "몬스터가 유저에게 (몬스터의 공격력 0 유저의 방어력)의 데미지를 입혔습니다."
    ///
    /// 유저 턴 -> 몬스터 턴 반복 후 한 쪽 체력이 0이되면 함수 종료

    while (true) {
      // 유저 턴으로 시작
      print("${character.name}의 턴");
      String command = getValidInput("행동을 선택하세요. (1: 공격, 2: 방어): ", (input) => input == "1" || input == "2");

      if (command.isEmpty) {
        print("입력이 잘못되었습니다.");
        continue;
      }

      switch (command) {
        case "1":
          character.attackMonster(monster);
          break;
        case "2":
          character.defend(monster);
          break;
        default:
      }

      if (monster.hp > 0) {
        // 몬스터 턴
        print("");
        print("${monster.name}의 턴");
        monster.attackCharacter(character);
      } else {
        print("${monster.name}을(를) 물리쳤습니다.!");
        print("");

        if (monsterList.isEmpty) {
          isStillFight = false;
          return;
        }

        String result = getValidInput("다음 몬스터와 싸우시겠습니까? (y/n): ", (input) => input.toLowerCase() == "y" || input.toLowerCase() == "n");
        if (result == "n") {
          isStillFight = false;
        }
        return;
      }

      if(character.hp <= 0) {
        print("${monster.name}에게 죽었습니다..");
        isStillFight = false;
        return;
      }

      character.showStatus();
      monster.showStatus();
      print("");
    }
  }

  Monster getRandomMonster() {
    int randNum = Random().nextInt(monsterList.length);
    Monster monster = monsterList[randNum];
    monsterList.removeAt(randNum);
    print("새로운 몬스터가 나타났습니다!");
    return monster;
  }

  void saveResult() {
    final file = File("../result.txt");
    file.writeAsString("캐릭터: ${character.name}, 남은 체력: ${character.hp > 0 ? character.hp : 0}, 결과: ${character.hp > 0 ? "승리" : "패배"}");
    print("결과가 저장되었습니다.");
  }
}
