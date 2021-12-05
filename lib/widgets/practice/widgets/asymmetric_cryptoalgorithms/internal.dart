import 'dart:math';

class RSA {
  int publicKey = 0;
  int privateKey = 0;
  int subKey = 0;

  int gcd(int a, int b, List<int> xy) {
    if (a == 0) {
      xy[0] = 0;
      xy[1] = 1;
      return b;
    }
    int x1, y1;
    List<int> xy1 = [1, 1];
    int d = gcd(b % a, a, xy1);
    xy[0] = xy1[1] - (b ~/ a) * xy1[0];
    xy[1] = xy1[0];
    return d;
  }

  void keyGen(int p, int q) {
    int n = p * q;
    print(n);
    subKey = n;

    int fi = (p - 1) * (q - 1);
    print(fi);
    int e = 2;
    List<int> xy = [1, 1];
    while (gcd(e, fi, xy) != 1) {
      e++;
    }
    print(xy);
    // Определение открытой экспоненты
    print(e);
    int d = (xy[0] % fi + fi).round() % fi;

    publicKey = e;
    privateKey = d;
    subKey = n;
    print(n);
    print("MOD ${(e * d) / fi}");
    print("Public KEY: $publicKey");
    print("Private KEY: $privateKey");
  }

  int encrypt(int value) {
    var temp = value.modPow(publicKey, subKey);
    return temp;
  }

  int decrypt(int value) {
    var temp = value.modPow(privateKey, subKey);
    return temp;
  }
}

class Elgamal {
  int p = 0;
  int g = 0;
  int x = 0;

  String encrypt(String text, int p, int g, int x) {
    var rand = new Random();
    int y = g.modPow(x, p);
    // (p,g,y) - public key
    String temp = "";
    for (int i = 0; i < text.length; i++) {
      var ch = text[i];

      int k = rand.nextInt(1 << 32) % (p - 2) + 1;

      int a = g.modPow(k, p);
      int b = (y.modPow(k, p) * text.codeUnitAt(i)) % p;
      temp += String.fromCharCode(a) + String.fromCharCode(b);
      //print("${String.fromCharCode(a)} | ${String.fromCharCode(b)}");
    }

    return temp;
  }

  String decrypt(String text, int p, int x) {
    String temp = "";
    for (int i = 1; i < text.length; i++) {
      int a = text.codeUnitAt(i - 1);
      int b = text.codeUnitAt(i);

      if (a != 0 && b != 0) {
        int demM = b * a.modPow(p - 1 - x, p) % p;
        if (demM > 96 && demM < 123 || demM > 64 && demM < 91 || demM == 32) {
          temp += String.fromCharCode(demM);
        }

        // print("$a | $b");
      }
    }
    return temp;
  }
}

void main() {
  // var rsa = new RSA();
  // rsa.keyGen(3557, 2579);
  // rsa.encrypt(111111);
  // rsa.decrypt(4051753);

  // in view check number is Prime
  var elg = Elgamal();
  String test =
      elg.encrypt("Decrypt string with Elgamal algoritm", 3571, 123, 8);
  elg.decrypt(test, 3571, 8);
  // elg.encrypt("Марина", p, g, x)
}
