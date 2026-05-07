
class AddState {
  final bool isSucceed;
  final bool isInitial;

  const AddState({required this.isSucceed, required this.isInitial});

  factory AddState.initial() => const AddState(isSucceed: false, isInitial: true);

  AddState copyWith({
    bool? isSucceed,
    bool? isInitial,
  }) {
    return AddState(isSucceed: isSucceed?? this.isSucceed, isInitial: isInitial ?? this.isInitial);
  }
}