import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  AppwriteClient._();
  static late Client _client;

  static late Databases databases;
  static late Account auth;
  static late Realtime realtime;

  static void init() {
    _client = Client().setProject('6797abfa00371afd71ee').setSelfSigned(status: true);
    databases = Databases(_client);
    auth = Account(_client);
    realtime = Realtime(_client);
  }
}
