import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:get_it/get_it.dart';

/// GetIt global instance accessible from everywhere in the app.
GetIt getIt = GetIt.instance;

/// GetIt initialization of all injected objects or their factories.
void initGetIt() {
  getIt.registerLazySingleton<ColorState>(ColorState.new);
  getIt.registerLazySingleton<ColorService>(ColorService.new);
  getIt.registerLazySingleton<ColorBloc>(ColorBloc.new);
}
