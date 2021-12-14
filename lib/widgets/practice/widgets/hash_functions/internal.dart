import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

class DiffieHelmanConnector {
  int p;
  int g;
  int A = 0;
  int B = 0;
  DiffieHelmanConnector(this.p, this.g);
}

class DiffieHelmanUser {
  late int privateKey;
  bool client;
  DiffieHelmanConnector conn;
  DiffieHelmanUser(int key, this.conn, this.client) {
    privateKey = key;
    if (client) {
      conn.A = conn.g.modPow(privateKey, conn.p);
    } else {
      conn.B = conn.g.modPow(privateKey, conn.p);
    }
  }
  int getSessionKey() {
    if (client) {
      return conn.B.modPow(privateKey, conn.p);
    }
    return conn.A.modPow(privateKey, conn.p);
  }
}

class MD5 {
  static var hex = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f"
  ];
  // Стандартное магическое число
  static var A = 0x67452301;
  static var B = 0xefcdab89;
  static var C = 0x98badcfe;
  static var D = 0x10325476;

  // Следующие S11-S44 на самом деле представляют собой матрицу 4 * 4, которая используется в операции четырехэтапного цикла
  static var S11 = 7;
  static var S12 = 12;
  static var S13 = 17;
  static var S14 = 22;

  static var S21 = 5;
  static var S22 = 9;
  static var S23 = 14;
  static var S24 = 20;

  static var S31 = 4;
  static var S32 = 11;
  static var S33 = 16;
  static var S34 = 23;

  static var S41 = 6;
  static var S42 = 10;
  static var S43 = 15;
  static var S44 = 21;

  // Java не поддерживает беззнаковые базовые данные (беззнаковые)
  var result = [
    A,
    B,
    C,
    D
  ]; // Сохраняем результат хеширования, всего 4 × 32 = 128 бит, и начальное значение (каскад магических чисел)

  String decrypt(String inputStr) {
    Uint8List inputBytes = Uint8List.fromList(inputStr.codeUnits);
    var byteLen = inputBytes.length; // Длина (байты)
    var groupCount = 0; // Количество полных групп
    groupCount = byteLen ~/ 64; // 512 бит на группу (64 байта)
    var groups = List.filled(groupCount,
        0); // каждая группа (64 байта), а затем разделены на 16 групп (4 байта)

    // Обработка каждой полной группы
    for (var step = 0; step < groupCount; step++) {
      groups = divGroup(inputBytes, step * 64);
      trans(groups); // Группировка обработки, основной алгоритм
    }

    int rest = byteLen % 64; // остаток после 512-битной группировки
    Uint8List tempBytes = Uint8List(64);
    if (rest <= 56) {
      for (int i = 0; i < rest; i++)
        tempBytes[i] = inputBytes[byteLen - rest + i];
      if (rest < 56) {
        tempBytes[rest] = (1 << 7); //byte
        for (int i = 1; i < 56 - rest; i++) tempBytes[rest + i] = 0;
      }
      int len = byteLen << 3;
      for (int i = 0; i < 8; i++) {
        tempBytes[56 + i] = (len & 0xFF); //byte
        len = len >> 8;
      }
      groups = divGroup(tempBytes, 0);
      trans(groups); // группа обработки
    } else {
      for (int i = 0; i < rest; i++)
        tempBytes[i] = inputBytes[byteLen - rest + i];
      tempBytes[rest] = 1 << 7; //byte
      for (int i = rest + 1; i < 64; i++) tempBytes[i] = 0;
      groups = divGroup(tempBytes, 0);
      trans(groups); // группа обработки

      for (int i = 0; i < 56; i++) tempBytes[i] = 0;
      int len = byteLen << 3;
      for (int i = 0; i < 8; i++) {
        tempBytes[56 + i] = len & 0xFF;
        len = len >> 8;
      }
      groups = divGroup(tempBytes, 0);
      trans(groups); // группа обработки
    }
    // Преобразуем значение хэша в шестнадцатеричную строку
    String resStr = "";
    int temp = 0;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        temp = result[i] & 0x0F;
        String a = hex[temp];
        result[i] = result[i] >> 4;
        temp = result[i] & 0x0F;
        resStr += hex[temp] + a;
        result[i] = result[i] >> 4;
      }
    }
    return resStr;
  }

  static List<int> divGroup(Uint8List inputBytes, int index) {
    var temp = List.filled(16, 0);
    for (int i = 0; i < 16; i++) {
      temp[i] = b2iu(inputBytes[4 * i + index]) |
          (b2iu(inputBytes[4 * i + 1 + index])) << 8 |
          (b2iu(inputBytes[4 * i + 2 + index])) << 16 |
          (b2iu(inputBytes[4 * i + 3 + index])) << 24;
    }
    return temp;
  }

  static int b2iu(int b) {
    //uint8 b
    return b < 0 ? b & 0x7F + 128 : b;
  }

  void trans(List<int> groups) {
    int a = result[0], b = result[1], c = result[2], d = result[3];

    a = FF(a, b, c, d, groups[0], S11, 0xd76aa478); /* 1 */
    d = FF(d, a, b, c, groups[1], S12, 0xe8c7b756); /* 2 */
    c = FF(c, d, a, b, groups[2], S13, 0x242070db); /* 3 */
    b = FF(b, c, d, a, groups[3], S14, 0xc1bdceee); /* 4 */
    a = FF(a, b, c, d, groups[4], S11, 0xf57c0faf); /* 5 */
    d = FF(d, a, b, c, groups[5], S12, 0x4787c62a); /* 6 */
    c = FF(c, d, a, b, groups[6], S13, 0xa8304613); /* 7 */
    b = FF(b, c, d, a, groups[7], S14, 0xfd469501); /* 8 */
    a = FF(a, b, c, d, groups[8], S11, 0x698098d8); /* 9 */
    d = FF(d, a, b, c, groups[9], S12, 0x8b44f7af); /* 10 */
    c = FF(c, d, a, b, groups[10], S13, 0xffff5bb1); /* 11 */
    b = FF(b, c, d, a, groups[11], S14, 0x895cd7be); /* 12 */
    a = FF(a, b, c, d, groups[12], S11, 0x6b901122); /* 13 */
    d = FF(d, a, b, c, groups[13], S12, 0xfd987193); /* 14 */
    c = FF(c, d, a, b, groups[14], S13, 0xa679438e); /* 15 */
    b = FF(b, c, d, a, groups[15], S14, 0x49b40821); /* 16 */

    a = GG(a, b, c, d, groups[1], S21, 0xf61e2562); /* 17 */
    d = GG(d, a, b, c, groups[6], S22, 0xc040b340); /* 18 */
    c = GG(c, d, a, b, groups[11], S23, 0x265e5a51); /* 19 */
    b = GG(b, c, d, a, groups[0], S24, 0xe9b6c7aa); /* 20 */
    a = GG(a, b, c, d, groups[5], S21, 0xd62f105d); /* 21 */
    d = GG(d, a, b, c, groups[10], S22, 0x2441453); /* 22 */
    c = GG(c, d, a, b, groups[15], S23, 0xd8a1e681); /* 23 */
    b = GG(b, c, d, a, groups[4], S24, 0xe7d3fbc8); /* 24 */
    a = GG(a, b, c, d, groups[9], S21, 0x21e1cde6); /* 25 */
    d = GG(d, a, b, c, groups[14], S22, 0xc33707d6); /* 26 */
    c = GG(c, d, a, b, groups[3], S23, 0xf4d50d87); /* 27 */
    b = GG(b, c, d, a, groups[8], S24, 0x455a14ed); /* 28 */
    a = GG(a, b, c, d, groups[13], S21, 0xa9e3e905); /* 29 */
    d = GG(d, a, b, c, groups[2], S22, 0xfcefa3f8); /* 30 */
    c = GG(c, d, a, b, groups[7], S23, 0x676f02d9); /* 31 */
    b = GG(b, c, d, a, groups[12], S24, 0x8d2a4c8a); /* 32 */

    a = HH(a, b, c, d, groups[5], S31, 0xfffa3942); /* 33 */
    d = HH(d, a, b, c, groups[8], S32, 0x8771f681); /* 34 */
    c = HH(c, d, a, b, groups[11], S33, 0x6d9d6122); /* 35 */
    b = HH(b, c, d, a, groups[14], S34, 0xfde5380c); /* 36 */
    a = HH(a, b, c, d, groups[1], S31, 0xa4beea44); /* 37 */
    d = HH(d, a, b, c, groups[4], S32, 0x4bdecfa9); /* 38 */
    c = HH(c, d, a, b, groups[7], S33, 0xf6bb4b60); /* 39 */
    b = HH(b, c, d, a, groups[10], S34, 0xbebfbc70); /* 40 */
    a = HH(a, b, c, d, groups[13], S31, 0x289b7ec6); /* 41 */
    d = HH(d, a, b, c, groups[0], S32, 0xeaa127fa); /* 42 */
    c = HH(c, d, a, b, groups[3], S33, 0xd4ef3085); /* 43 */
    b = HH(b, c, d, a, groups[6], S34, 0x4881d05); /* 44 */
    a = HH(a, b, c, d, groups[9], S31, 0xd9d4d039); /* 45 */
    d = HH(d, a, b, c, groups[12], S32, 0xe6db99e5); /* 46 */
    c = HH(c, d, a, b, groups[15], S33, 0x1fa27cf8); /* 47 */
    b = HH(b, c, d, a, groups[2], S34, 0xc4ac5665); /* 48 */

    a = II(a, b, c, d, groups[0], S41, 0xf4292244); /* 49 */
    d = II(d, a, b, c, groups[7], S42, 0x432aff97); /* 50 */
    c = II(c, d, a, b, groups[14], S43, 0xab9423a7); /* 51 */
    b = II(b, c, d, a, groups[5], S44, 0xfc93a039); /* 52 */
    a = II(a, b, c, d, groups[12], S41, 0x655b59c3); /* 53 */
    d = II(d, a, b, c, groups[3], S42, 0x8f0ccc92); /* 54 */
    c = II(c, d, a, b, groups[10], S43, 0xffeff47d); /* 55 */
    b = II(b, c, d, a, groups[1], S44, 0x85845dd1); /* 56 */
    a = II(a, b, c, d, groups[8], S41, 0x6fa87e4f); /* 57 */
    d = II(d, a, b, c, groups[15], S42, 0xfe2ce6e0); /* 58 */
    c = II(c, d, a, b, groups[6], S43, 0xa3014314); /* 59 */
    b = II(b, c, d, a, groups[13], S44, 0x4e0811a1); /* 60 */
    a = II(a, b, c, d, groups[4], S41, 0xf7537e82); /* 61 */
    d = II(d, a, b, c, groups[11], S42, 0xbd3af235); /* 62 */
    c = II(c, d, a, b, groups[2], S43, 0x2ad7d2bb); /* 63 */
    b = II(b, c, d, a, groups[9], S44, 0xeb86d391); /* 64 */

    result[0] += a;
    result[1] += b;
    result[2] += c;
    result[3] += d;
    result[0] = result[0] & 0xFFFFFFFF;
    result[1] = result[1] & 0xFFFFFFFF;
    result[2] = result[2] & 0xFFFFFFFF;
    result[3] = result[3] & 0xFFFFFFFF;
  }

  static int F(int x, int y, int z) {
    return (x & y) | ((~x) & z);
  }

  static int G(int x, int y, int z) {
    return (x & z) | (y & (~z));
  }

  static int H(int x, int y, int z) {
    return x ^ y ^ z;
  }

  static int I(int x, int y, int z) {
    return y ^ (x | (~z));
  }

  static int FF(int a, int b, int c, int d, int x, int s, int ac) {
    a += (F(b, c, d) & 0xFFFFFFFF) + x + ac;
    a = ((a & 0xFFFFFFFF) << s) | ((a & 0xFFFFFFFF) >> (32 - s));
    a += b;
    return (a & 0xFFFFFFFF);
  }

  static int GG(int a, int b, int c, int d, int x, int s, int ac) {
    a += (G(b, c, d) & 0xFFFFFFFF) + x + ac;
    a = ((a & 0xFFFFFFFF) << s) | ((a & 0xFFFFFFFF) >> (32 - s));
    a += b;
    return (a & 0xFFFFFFFF);
  }

  static int HH(int a, int b, int c, int d, int x, int s, int ac) {
    a += (H(b, c, d) & 0xFFFFFFFF) + x + ac;
    a = ((a & 0xFFFFFFFF) << s) | ((a & 0xFFFFFFFF) >> (32 - s));
    a += b;
    return (a & 0xFFFFFFFF);
  }

  static int II(int a, int b, int c, int d, int x, int s, int ac) {
    a += (I(b, c, d) & 0xFFFFFFFF) + x + ac;
    a = ((a & 0xFFFFFFFF) << s) | ((a & 0xFFFFFFFF) >> (32 - s));
    a += b;
    return (a & 0xFFFFFFFF);
  }
}

void main() {
  var algoritm = DiffieHelmanConnector(23, 5);
  var alice = DiffieHelmanUser(6, algoritm, true);
  var bob = DiffieHelmanUser(15, algoritm, false);
  var md = MD5();
  print(alice.getSessionKey());
  print(bob.getSessionKey());
  print(md.decrypt("test"));
}
