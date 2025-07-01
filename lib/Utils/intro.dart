import "dart:convert";
import "dart:io";

import "package:rpg_game/Models/character.dart";
import "package:rpg_game/Models/monster.dart";

// 캐릭터 이름 입력
String getCharacterName() {
  stdout.write("캐릭터의 이름을 입력하세요 : ");
  return stdin.readLineSync(encoding: utf8) ?? "";
}

// 캐릭터 상태 불러오기
Character loadCharacterStatus() {
  try {
    final file = File("assets/characters.txt");
    final contents = file.readAsStringSync();
    final status = contents.split(",");

    if (status.length != 3) throw FormatException("invalid character data");

    int hp = int.parse(status[0]);
    int ap = int.parse(status[1]);
    int dp = int.parse(status[2]);

    String name = "";
    RegExp regex = RegExp(r"^[a-zA-Z가-힣]+$");

    while (true) {
      name = getCharacterName();
      if(name.isNotEmpty && regex.hasMatch(name)) break;
      print("❗이름 형식이 올바르지 않습니다❗");
    }

    print("$name, $hp, $ap, $dp");

    return Character(name, hp, ap, dp);
  } catch (e) {
    print("캐릭터 데이터를 불러오는 데 실패했습니다\n$e");
    exit(1);
  }
}

// 몬스터 상태 리스트 불러오기
List<Monster> loadMonsterStatus() {
  List<Monster> monsterList = [];
  try {
    final file = File("assets/monsters.txt");
    final contents = file.readAsStringSync();
    final monsters = contents.split("\n");

    for (String monster in monsters) {
      final status = monster.split(",");
      if (status.length != 3) throw FormatException("Invalid character data");

      String name = status[0];
      int hp = int.parse(status[1]);
      int ap = int.parse(status[2]);

      print("$name, $hp, $ap");

      monsterList.add(Monster(name, hp, ap));
    }

    return monsterList;
  } catch (e) {
    print("몬스터 리스트 데이터를 불러오는 데 실패했습니다\n$e");
    exit(1);
  }
}

// 입력에 대한 유효성 검사
String getValidInput(String prompt, bool Function(String) validator) {
  while(true) {
    stdout.write(prompt);
    String input = stdin.readLineSync(encoding: utf8)?.trim() ?? "";
    if(validator(input)) return input;
    print("잘못된 입력입니다!");
  }
}