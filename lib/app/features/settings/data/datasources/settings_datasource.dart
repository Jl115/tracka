import 'package:tracka/app/core/database/controller/database_controller.dart';
import 'package:tracka/app/features/settings/data/models/settings_model.dart';

class SettingsDataSource {
  final _key = 'setting';

  final _databaseController = DatabaseController();

  Future<SettingsModel> load() async {
    final jsonMap = await _databaseController.getJoinedValue(table1: _key, table2: 'user');
    return SettingsModel.fromJson(jsonMap);
  }

  Future<void> save(SettingsModel model) async {
    final userId = await _databaseController.getCurrentUserId();

    await _databaseController.update(
      table: 'setting',
      data: model.toDatabaseModel(),
      where: 'user_id',
      whereArgs: [userId],
    );
  }
}
