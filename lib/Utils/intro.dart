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
    final file = File("lib/Datas/characters.txt");
    final contents = file.readAsStringSync();
    final status = contents.split(",");

    if (status.length != 3) throw FormatException("invalid character data");

    int hp = int.parse(status[0]);
    int ap = int.parse(status[1]);
    int dp = int.parse(status[2]);

    String name = getCharacterName();

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
    final file = File("lib/Datas/monsters.txt");
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
