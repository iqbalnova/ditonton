import 'package:core/common/db/database_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'ssl_pinning.dart';

class CoreInjection {
  static Future<void> initializeDependencies(GetIt locator) async {
    // helper
    final db = await DatabaseHelper.initDb();
    locator.registerLazySingleton<DatabaseHelper>(
      () => DatabaseHelper(database: db),
    );

    // external
    final client = await getSSLPinningClient();
    locator.registerFactory<http.Client>(() => client);
  }
}
