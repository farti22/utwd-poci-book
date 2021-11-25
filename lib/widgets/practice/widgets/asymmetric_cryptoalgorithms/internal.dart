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
    return 0;
  }

  int decrypt(int value) {
    var temp = value.modPow(privateKey, subKey);
    print(temp);
    return 0;
  }
}

int randomValue32() {
  String bits = "";
  int amountBits = 32;
  while (amountBits-- != 0) {
    bits += Random().nextInt(2).toString();
  }
  //print(bits);
  return int.parse(bits, radix: 2);
}

bool millerTest(int d, int n) {
  int a = 2 + (Random().nextInt(1 << 32) * (n - 2) % (n - 4));
  int x = a.modPow(d, n);

  if (x == 1 || x == n - 1) return true;

  while (d != n - 1) {
    x = (x * x) % n;
    d *= 2;
    if (x == 1) return false;
    if (x == n - 1) return true;
  }
  return false;
}

bool isPrime(int n, int k) {
  if (n <= 1 || n == 4) return false;
  if (n <= 3) return true;

  int d = n - 1;
  while (d % 2 == 0) {
    d ~/= 2;
  }
  for (int i = 0; i < k; i++) {
    if (!millerTest(d, n)) {
      return false;
    }
  }
  return true;
}

// Limit 32 bit
int randomPrime(int amountBits) {
  List<int> simplePrime = [2, 3, 5, 7, 11];
  int value = 0;
  while (true) {
    value = randomValue32();

    //First step
    bool test1 = true;
    for (var prime in simplePrime) {
      if (value % prime != 0) {
        test1 = false;
        break;
      }
    }

    if (!test1) continue;
    if (isPrime(value, amountBits)) {
      return value;
    }
    break;
  }
  return value;
}

class Elgamal {
  int p = 0;
  int g = 0;
  int x = 0;
  int keyGen() {
    int p = randomPrime(32);
    return p;
  }

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
    print(temp);
    return temp;
  }
}

void main() {
  // var rsa = new RSA();
  // rsa.keyGen(3557, 2579);
  // rsa.encrypt(111111);
  // rsa.decrypt(4051753);

  var elg = Elgamal();
  String test =
      elg.encrypt("Decrypt string with Elgamal algoritm", 3571, 123, 8);
  elg.decrypt(test, 3571, 8);
  // elg.encrypt("Марина", p, g, x)
}
