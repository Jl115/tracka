import 'dart:convert';

import 'package:crypto/crypto.dart';

class Hasher {
  Hasher._internal();
  static final Hasher instance = Hasher._internal();

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
