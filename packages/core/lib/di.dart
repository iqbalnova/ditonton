import 'package:core/common/db/database_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class CoreInjection {
  static Future<void> initializeDependencies(GetIt locator) async {
    // helper
    final db = await DatabaseHelper.initDb();
    locator.registerLazySingleton<DatabaseHelper>(
      () => DatabaseHelper(database: db),
    );

    // external
    locator.registerLazySingleton(() => http.Client());
  }
}
