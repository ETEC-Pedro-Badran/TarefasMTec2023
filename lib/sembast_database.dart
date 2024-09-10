import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDatabase {
  String _dbPath = 'tarefas.db';

  Future<Database> getInstance() async {
    var factory = databaseFactoryWeb;

    // Open the database
    var db = await factory.openDatabase(_dbPath);

    return db;
  }
}
