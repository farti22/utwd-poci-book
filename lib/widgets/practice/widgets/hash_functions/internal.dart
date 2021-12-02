import 'dart:math';

class DiffieHelmanConnector {
  int p;
  int g;
  int A = 0;
  int B = 0;
  DiffieHelmanConnector(this.p, this.g);
}

class DiffieHelmanUser {
  late int publicKey;
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

void main() {
  var algoritm = DiffieHelmanConnector(23, 5);
  var alice = DiffieHelmanUser(6, algoritm, true);
  var bob = DiffieHelmanUser(15, algoritm, false);

  print(alice.getSessionKey());
  print(bob.getSessionKey());
}
