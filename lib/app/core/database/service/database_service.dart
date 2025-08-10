import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:tracka/app/core/database/service/database_migration_service.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _database;

  Database get db => _database!;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'tracka.db');

    // reset db
    // await deleteDatabase(path);
    print('\x1B[32m dbPath :D -------------------- ${path}\x1B[0m');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    DatabaseMigrationService migrationService = DatabaseMigrationService(db);
    //Create
    await migrationService.createTables();
    // Migrate
    // Seed
    await migrationService.seedDatabase();
  }
}
