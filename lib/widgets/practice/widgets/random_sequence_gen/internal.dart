import 'dart:math';

// MOVE TO MATH HELPERS
double roundDouble(double value, int amount) {
  if (amount == 0) {
    return value.roundToDouble();
  }
  return (value * pow(10, amount)).round() / pow(10, amount);
}
//
// create func value -> string -> add space -> remove last space(trim)

List<String> randomNumList() {
  var list = List.filled(6, "");
  var rand = Random();

  // 1
  for (int i = 0; i < 10; i++) {
    list[0] += (rand.nextInt(10) + 3).toString() + " ";
  }
  print("1: ${list[0]}");

  // 2
  List<int> seq = [-3, 0, 6, 8, 12, 15];
  for (int i = 0; i < 10; i++) {
    list[1] += (seq[rand.nextInt(seq.length)]).toString() + " ";
  }
  print("2: ${list[1]}");

  // 3
  for (int i = 0; i < 10; i++) {
    list[2] +=
        roundDouble(rand.nextInt(9) + 3 + rand.nextDouble(), 4).toString() +
            " ";
  }
  print("3: ${list[2]}");

  // 4
  var seq2 =
      List.generate(131, (index) => roundDouble(-2.3 + (0.1 * index), 1));
  for (int i = 0; i < 10; i++) {
    list[3] += (seq2[rand.nextInt(seq2.length)]).toString() + " ";
  }
  print("4: ${list[3]}");

  // 5
  var seq3 = [-30, 10, 63, 59, 120, 175];
  for (int i = 0; i < 10; i++) {
    list[4] += (seq3[rand.nextInt(seq3.length)]).toString() + " ";
  }
  print("5: ${list[4]}");

  // 6
  var seq4 = List.generate(16, (index) => pow(10, -index));
  for (int i = 0; i < 10; i++) {
    list[5] += (seq4[rand.nextInt(seq4.length)]).toString() + " ";
  }
  print("6: ${list[5]}");
  return list;
}

List<int> intToList(int value) {
  String temp = value.toString();
  List<int> list = [];

  for (int i = 0; i < 4; i++) {
    list.add(int.parse(temp[i]));
  }
  return list;
}

class BullsAndCowsGame {
  String _strKey = "";
  var _list = [];

  bool _isBull(int value) {
    if (_list.contains(value)) return true;
    return false;
  }

  bool _isCow(int value, int index) {
    if (_list[index] == value) return true;
    return false;
  }

  void init() {
    List<int> set = [];
    while (set.length < 4) {
      var key = Random().nextInt(9);
      if (set.contains(key)) continue;
      set.add(key);
    }
    _list = set;
    _strKey = set.toString();
    print("Gen key: $_strKey");
  }

  void check(int value) {
    int cows = 0;
    int bulls = 0;
    var list = intToList(value);
    print(list);
    for (int i = 0; i < 4; i++) {
      if (_isBull(list[i])) {
        bulls++;
        if (_isCow(list[i], i)) {
          cows++;
        }
      }
    }
    print("COWS: $cows");
    print("BULLS: $bulls");
  }

  bool isUnique(int value) {
    var list = intToList(value);
    return list.length == list.toSet().length;
  }
}

void main() {
  //var list = randomNumList();
  //var str = "test";

  var game = BullsAndCowsGame();
  game.init();
  print(game.isUnique(1233));
  game.check(1234);
}
