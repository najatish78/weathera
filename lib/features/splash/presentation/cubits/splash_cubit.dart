import 'package:bloc/bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/failures/base_failure.dart';
import '../../../../core/utils/failures/http/http_failure.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  Future<void> startCounter() async {
    emit(state.copyWith(status: SplashStatus.loading));

    // Without a key every weather call fails with 401: stop here instead.
    if (AppConstant.openWeatherApiKey.isEmpty) {
      emit(
        state.copyWith(
          status: SplashStatus.error,
          failure: const UnauthorizedFailure(),
        ),
      );
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!isClosed) emit(state.copyWith(status: SplashStatus.done));
  }
}
