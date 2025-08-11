import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseMigrationService {
  // This class is responsible for managing database migrations.
  // It will handle the logic to check the current database version
  // and apply necessary migrations to update the database schema.

  static DatabaseMigrationService? _instance;
  final Database db;

  DatabaseMigrationService._internal(this.db);

  factory DatabaseMigrationService(Database db) {
    return _instance ??= DatabaseMigrationService._internal(db);
  }

  // seed the database with initial data
  Future<void> seedDatabase() async {
    // Check if the database is empty
    const uuid = Uuid();
    final nowEpoch = DateTime.now().toString();
    final newUserId = uuid.v4();
    await db.insert('user', {
      'id': newUserId,
      'username': 'user',
      'password_hash': '04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb',
      'logged_in': 0,
      'created_at': nowEpoch,
      'updated_at': nowEpoch,
    });

    await db.insert('setting', {'user_id': newUserId, 'dark_mode': 1});

    // Sensor types
    final sensorTypes = [
      {'name': 'GPS Speed', 'unit': 'm/s', 'data_type': 'number'},
      {'name': 'Heart Rate', 'unit': 'bpm', 'data_type': 'number'},
      {'name': 'Accelerometer X', 'unit': '(m/s)*2', 'data_type': 'number'},
      {'name': 'Accelerometer Y', 'unit': '(m/s)*2', 'data_type': 'number'},
      {'name': 'Accelerometer Z', 'unit': '(m/s)*2', 'data_type': 'number'},
      {'name': 'Gyroscope', 'unit': 'deg/s', 'data_type': 'number'},
      {'name': 'Pedometer', 'unit': 'steps', 'data_type': 'number'},
      {'name': 'Device Motion', 'unit': null, 'data_type': 'json'},
      {'name': 'Magnetometer', 'unit': 'uT', 'data_type': 'number'},
      {'name': 'Barometer', 'unit': 'hPa', 'data_type': 'number'},
      {'name': 'Bluetooth', 'unit': null, 'data_type': 'json'},
    ];

    for (final e in sensorTypes) {
      await db.insert('sensor_type', {
        'id': uuid.v4(),
        'name': e['name'],
        'unit': e['unit'],
        'data_type': e['data_type'],
        'description': '',
        'created_at': nowEpoch,
        'updated_at': nowEpoch,
      });
    }
  }

  Future<void> createTriggers() async {
    await db.execute('''
    CREATE TRIGGER IF NOT EXISTS create_default_settings
    AFTER INSERT ON user
    BEGIN
      INSERT INTO setting (
        user_id,
        dark_mode
      )
      VALUES (
        NEW.id, 
        0 -- Default dark_mode off, adjust if needed
      );
    END;
  ''');
  }

  Future<void> createTables() async {
    await db.execute('''
      CREATE TABLE user(
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL,
        password_hash TEXT NOT NULL,
        logged_in INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE setting(
        user_id TEXT PRIMARY KEY,
        dark_mode INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
    CREATE TABLE sensor_type(
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL UNIQUE,
      unit TEXT,
      data_type TEXT NOT NULL DEFAULT 'number', 
      description TEXT,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE session(
      id TEXT PRIMARY KEY,
      user_id TEXT NOT NULL,
      start_ts INTEGER NOT NULL,
      end_ts INTEGER,
      title TEXT,
      device_id TEXT,
      phone_position TEXT,
      route_polyline TEXT,
      distance_m REAL DEFAULT 0,
      elevation_gain_m REAL DEFAULT 0,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE measurement(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      session_id TEXT NOT NULL,
      sensor_type_id TEXT NOT NULL,
      ts INTEGER NOT NULL,
      value REAL,
      raw TEXT,
      sample_index INTEGER,
      FOREIGN KEY (session_id) REFERENCES session (id) ON DELETE CASCADE,
      FOREIGN KEY (sensor_type_id) REFERENCES sensor_type (id)
    )
  ''');

    await db.execute('''
    CREATE TABLE session_stat(
      session_id TEXT PRIMARY KEY,
      avg_speed REAL,
      max_speed REAL,
      avg_hr REAL,
      max_hr REAL,
      total_distance REAL,
      elevation_gain REAL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL,
      FOREIGN KEY (session_id) REFERENCES session (id) ON DELETE CASCADE
    )
  ''');
  }
}
