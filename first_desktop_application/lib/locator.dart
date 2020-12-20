import 'package:first_desktop_application/app-level/services/root_service.dart';

import 'package:get_it/get_it.dart';

import 'shared/services/linker_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<LinkerService>(() => LinkerService());

  locator.registerLazySingleton(() => RootService());
}
