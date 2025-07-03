import 'package:rpg_game/Models/game.dart';

void main(List<String> arguments) {
  // 게임 생성
  Game game = Game();
  game.startGame();
}

// bool isAnagram(String s, String t) {
//   // 두 문자열의 길이가 다르면 애너그램이 아님
//   if (s.length != t.length) return false;

//   Map<String, int> map = {};

//   for (int i = 0; i < s.length; i++) {
//     map[s[i]] = (map[s[i]] ?? 0) + 1;
//   }

//   for (int i = 0; i < t.length; i++) {
//     if(!map.keys.contains(t[i])) {
//       return false;
//     }
//     map[t[i]] = map[t[i]]! - 1;
//     if(map[t[i]] == 0) map.remove(t[i]);
//   }

//   return map.isEmpty;
// }

// class Test {
//   int a = 0;
//   int b = 0;
// }