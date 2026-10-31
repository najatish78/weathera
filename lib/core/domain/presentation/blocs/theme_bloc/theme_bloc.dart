import 'package:weathera/core/domain/presentation/blocs/theme_bloc/theme_event.dart';
import 'package:weathera/core/domain/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/datasource/theme_local_datasource.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalDataSource baseLocalDataSourcel;

  bool _isDark = true;

  bool get isDark => _isDark;
  ThemeBloc({required this.baseLocalDataSourcel})
    : super(
        ThemeInitial(
          isDarkMode: baseLocalDataSourcel.getCurrentAppTheme() ?? true,
        ),
      ) {
    _isDark = baseLocalDataSourcel.getCurrentAppTheme() ?? true;
    on<ChangeThemeEvent>((event, emit) async {
      final result = await baseLocalDataSourcel.changeAppTheme(
        event.isDarkMode,
      );
      if (result) {
        if (event.isDarkMode) {
          _isDark = event.isDarkMode;
          emit(DarkThemeState());
        } else {
          _isDark = event.isDarkMode;
          emit(LightThemeState());
        }
      }
    });
    on<RefreshThemeEvent>((event, emit) {
      if (_isDark) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
