part of 'splash_cubit.dart';

enum SplashStatus { initial, loading, done, error }

class SplashState {
  final SplashStatus status;
  final Failure? failure;

  SplashState._({required this.status, this.failure});

  SplashState.initial() : status = SplashStatus.initial, failure = null;

  SplashState copyWith({SplashStatus? status, Failure? failure}) {
    return SplashState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'SplashState {status: $status}';
  }
}
