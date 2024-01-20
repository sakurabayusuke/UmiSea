class MapScreenState {
  const MapScreenState({
    required this.initialized,
    required this.splashIsEnd,
    required this.bottomSheetIsAnimating,
  });

  final bool initialized;
  final bool splashIsEnd;
  final bool bottomSheetIsAnimating;

  MapScreenState copyWith({
    bool? initialized,
    bool? splashIsEnd,
    bool? bottomSheetIsAnimating,
  }) {
    return MapScreenState(
      initialized: initialized ?? this.initialized,
      splashIsEnd: splashIsEnd ?? this.splashIsEnd,
      bottomSheetIsAnimating:
          bottomSheetIsAnimating ?? this.bottomSheetIsAnimating,
    );
  }
}
