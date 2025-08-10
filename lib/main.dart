import 'package:flutter/material.dart';
import 'package:tracka/app/app.dart';
import 'package:tracka/app/core/database/service/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.database; // Ensure the database is initialized
  runApp(const App());
}
