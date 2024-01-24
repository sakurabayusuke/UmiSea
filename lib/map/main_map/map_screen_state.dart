class MapScreenState {
  const MapScreenState({
    required this.initialized,
    required this.bottomSheetIsAnimating,
  });

  final bool initialized;
  final bool bottomSheetIsAnimating;

  MapScreenState copyWith({
    bool? initialized,
    bool? bottomSheetIsAnimating,
  }) {
    return MapScreenState(
      initialized: initialized ?? this.initialized,
      bottomSheetIsAnimating:
          bottomSheetIsAnimating ?? this.bottomSheetIsAnimating,
    );
  }
}
