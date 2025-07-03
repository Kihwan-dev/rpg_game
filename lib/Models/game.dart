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
    character.recover();
    // 파일에서 몬스터 정보 불러오기
    monsterList = loadMonsterStatus();

    print("\n게임을 시작합니다!");
    character.showStatus();

    while (isStillFight) {
      // 몬스터 정보 출력
      monster = getRandomMonster();
      monster.setAp(character.dp);
      monster.showStatus();

      // 배틀 시작
      battle();
    }

    endGame();
  }

  void endGame() {
    if (monsterList.isEmpty) {
      print("축하합니다! 모든 몬스터를 물리쳤습니다.");
    } else {
      if (character.hp <= 0) print("사망띠..");
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

    int playTurn = 0;
    while (true) {
      playTurn++;
      if (playTurn == 3) {
        monster.dp += 2;
        print("${monster.name}의 방어력이 증가했습니다! 현재 방어력: ${monster.dp}");
        playTurn = 0;
      }
      String command;
      print("${character.name}의 턴");
      while (true) {
        // 안내문구와 입력은 여기서만!
        command = getValidInput("행동을 선택하세요. (1: 공격, 2: 방어, 3: 아이템): ", (input) => input == "1" || input == "2" || input == "3");

        if (command == "3") {
          if (character.item == ItemStatus.none) {
            character.useItem();
            print("아이템 사용으로 공격력이 2배(${character.ap})가 되었습니다.");
          } else {
            print("이미 사용한 아이템입니다. 다른 행동을 선택하세요.");
          }
          continue;
        }
        break; // 정상 입력이면 반복문 탈출
      }

      switch (command) {
        case "1":
          character.attack(monster);
          break;
        case "2":
          character.defend(monster);
          break;
        default:
      }

      if (character.item == ItemStatus.using) {
        character.item = ItemStatus.used;
        character.ap = character.ap ~/ 2;
      }

      if (monster.hp > 0) {
        // 몬스터 턴
        print("\n${monster.name}의 턴");
        monster.attack(character);
      } else {
        print("${monster.name}을(를) 물리쳤습니다!\n");

        character.getExp();

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

      if (character.hp <= 0) {
        print("${monster.name}에게 죽었습니다..");
        isStillFight = false;
        return;
      }

      character.showStatus();
      monster.showStatus();
    }
  }

  Monster getRandomMonster() {
    final randNum = Random().nextInt(monsterList.length);
    final monster = monsterList[randNum];
    monsterList.removeAt(randNum);
    print("\n새로운 몬스터가 나타났습니다!");
    return monster;
  }

  void saveResult() {
    final gameFile = File("../assets/result.txt");
    gameFile.writeAsString("캐릭터: ${character.name}, 남은 체력: ${character.hp > 0 ? character.hp : 0}, 결과: ${character.hp > 0 ? "승리" : "패배"}");
    final characterFile = File("../assets/characters.txt");
    characterFile.writeAsString("${character.hp},${character.ap},${character.dp},${character.level},${character.exp}");
    print("결과가 저장되었습니다.");
  }
}
