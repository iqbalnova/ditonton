import 'package:core/di.dart';
import 'package:movie/di.dart';
import 'package:series/di.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Initialize feature modules
  await CoreInjection.initializeDependencies(locator);
  await MovieInjection.initializeDependencies(locator);
  await SeriesInjection.initializeDependencies(locator);
}
