import 'package:sqflite/sqflite.dart';
import 'package:tracka/app/core/database/service/database_service.dart';

abstract class DatabaseRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<Database> get db async => await _dbService.database;

  Future<List<Map<String, Object?>>> findAll({required String table, String? where, List<Object?>? whereArgs}) async {
    return await (await db).query(table, where: where, whereArgs: whereArgs);
  }

  Future<Map<String, Object?>?> findOne({
    required String table,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      final result = await (await db).query(table, where: where, whereArgs: whereArgs);
      if (result.isEmpty) return null;
      return result.first;
    } catch (e) {
      print('\x1B[31mError finding one in $table: $e\x1B[0m');
      return null;
    }
  }

  Future<int> create({required String table, required Map<String, Object?> value}) async {
    final db = await this.db;
    return await db.insert(table, value, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<int> update({
    required String table,
    required Map<String, Object?> data,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      var t = await (await db).update(table, data, where: where, whereArgs: whereArgs);
      print('\x1B[32mt -------------------- ${t}\x1B[0m');
      return t;
    } catch (e) {
      print('\x1B[32me -------------------- ${e}\x1B[0m');
      return 0; // Return 0 if update fails
    }
  }

  Future<int> delete({required String table, required String where, required List<Object?> whereArgs}) async {
    return await (await db).delete(table, where: where, whereArgs: whereArgs);
  }

  Future<Map<String, dynamic>> getJoinedValue({
    required String table1,
    required String table2,
    String? where, // Optional WHERE clause, e.g., 'users.id = ?'
    List<Object?>? whereArgs, // Arguments for the WHERE clause
  }) async {
    final db = await _dbService.database;
    String sql = 'SELECT * FROM $table1 LEFT JOIN $table2 ON $table2.id = $table1.${table2}_id';
    if (where != null && where.isNotEmpty) sql += ' WHERE $where';
    final result = await db.rawQuery(sql, whereArgs);
    if (result.isEmpty) return {};
    return result.first;
  }
}
