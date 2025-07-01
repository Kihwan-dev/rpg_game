import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:rpg_game/Models/character.dart';
import 'package:rpg_game/Models/monster.dart';
import 'package:rpg_game/Utils/intro.dart';

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

    while (true) {
      stdout.write("행동을 선택하세요 (1: 공격, 2: 방어): ");
      String command = stdin.readLineSync(encoding: utf8) ?? "";

      if (command.isEmpty) {
        print("입력이 잘못되었습니다.");
        continue;
      }

      switch (command) {
        case "1":
          character.attackMonster(monster);
          if (monster.hp > 0) {
            // 몬스터 턴
          } else {
            print("유저가 몬스터를 물리쳤습니다.!");
            print("");
            stdout.write("다음 몬스터와 싸우시겠습니까? (y/n): ");
            return;
          }
          print("유저가 몬스터에게 ${character.ap - monster.dp}만큼의 피해를 입혔습니다.");
          break;
        case "2":
          break;
        default:
      }
    }
  }

  Monster getRandomMonster() {
    print("새로운 몬스터가 나타났습니다!");
    int randNum = Random().nextInt(monsterList.length);
    Monster monster = monsterList[randNum];
    monsterList.removeAt(randNum);
    return monster;
  }
}
