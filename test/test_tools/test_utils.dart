import 'package:color_juggler/bootstrap/get_it_model.dart';

void getItReplaceFactory<T extends Object>(T Function() builder) {
  if (getIt.isRegistered<T>()) getIt.unregister<T>();
  getIt.registerFactory<T>(builder);
}

void getItReplaceLazySingleton<T extends Object>(T Function() builder) {
  if (getIt.isRegistered<T>()) getIt.unregister<T>();
  getIt.registerLazySingleton<T>(builder);
}

void getItReplaceSingleton<T extends Object>(T object) {
  if (getIt.isRegistered<T>()) getIt.unregister<T>();
  getIt.registerSingleton<T>(object);
}
