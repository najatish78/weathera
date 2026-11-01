part of 'outfit_cubit.dart';

enum OutfitStatus { initial, loading, error, success }

class OutfitState {
  final OutfitStatus status;
  final OutfitSuggestionModel? data;
  final Failure? failure;

  OutfitState._({required this.status, this.data, this.failure});

  OutfitState.initial()
    : status = OutfitStatus.initial,
      data = null,
      failure = null;

  OutfitState copyWith({
    OutfitStatus? status,
    OutfitSuggestionModel? data,
    Failure? failure,
  }) {
    return OutfitState._(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'OutfitState {status: $status}';
  }
}
