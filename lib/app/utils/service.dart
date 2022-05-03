import 'package:get_it/get_it.dart';

import '../data/local/manager/db_manager.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerSingleton(AppDatabase(openConnection()));
}
