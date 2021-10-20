import 'dart:math';

class PasswordGenerator {
  static String generate(length, alphabet) {
    var rand = Random();
    String password = "";
    for (int i = 0; i < length; i++) {
      var index = rand.nextInt(alphabet.length);
      password += alphabet[index];
    }
    return password;
  }

  static String? generateWithMap({required PasswordSegmentMapper map}) {
    var rand = Random();
    String? password = "";
    print(map.length);
    for (int i = 0; i < map.length; i++) {
      var segment = PasswordSegmentMapper.getSegmentMap(map.segment[i]);
      if (segment == "FUNC") {
        password = password! + customValue(map.getKeyWordLen());
        continue;
      }
      print("map - " + segment!);
      var index = rand.nextInt(segment.length);
      password = password! + segment[index];
    }
    return password;
  }
}

class PasswordSegmentMapper {
  static final _dicts = <String, String>{
    "абс": "йцукенгшщзхъфывапролджэячсмитьбю",
    "АБС": "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ",
    "abc": "qwertyuiopasdfghjklzxcvbnm",
    "ABC": "QWERTYUIOPASDFGHJKLZXCVBNM",
    "123": "1234567890",
    "#\$*": "!#\$\"%&`,*",
    "FUNC": "FUNC"
  };
  int length = 0;
  final int _keyWordLen;
  List<String?> segment;

  PasswordSegmentMapper(this.segment, this._keyWordLen) {
    length = segment.length;
  }
  int getKeyWordLen() {
    return _keyWordLen;
  }

  static String? getSegmentMap(String? str) {
    return _dicts[str];
  }
}

String customValue(int N) {
  var expr = (pow(N, 4) % 100);
  return expr < 10 ? "0" + expr.toString() : expr.toString();
}

// for testing
void main() {
  String pas1, pas2;
  String user_text = "YaVvel16Simvolov";
  final int N = user_text.length;

  var map1 = [
    "russian_low",
    "russian_low",
    "russian_low",
    "russian_up",
    "russian_up",
    "numbers",
    customValue(N),
    "russian_up",
  ];

  PasswordSegmentMapper psm = PasswordSegmentMapper(map1, N);
  pas1 = PasswordGenerator.generate(16, "qewrtyuiopasfdghjkljzxcvnbmn");
  pas2 = PasswordGenerator.generateWithMap(map: psm)!;

  print("P1: " + pas1);
  print("P2: " + pas2);
}
