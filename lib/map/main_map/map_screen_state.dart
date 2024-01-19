class MapScreenState {
  const MapScreenState({
    required this.initialized,
    required this.splashIsEnd,
  });

  final bool initialized;
  final bool splashIsEnd;

  MapScreenState copyWith({
    bool? initialized,
    bool? splashIsEnd,
  }) {
    return MapScreenState(
      initialized: initialized ?? this.initialized,
      splashIsEnd: splashIsEnd ?? this.splashIsEnd,
    );
  }
}
