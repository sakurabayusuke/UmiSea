class MapScreenState {
  const MapScreenState(
      {required this.initialized,
      required this.coralIsDisplaying,
      required this.splashIsEnd});

  final bool initialized;
  final bool coralIsDisplaying;
  final bool splashIsEnd;

  MapScreenState copyWith(
      {bool? initialized, bool? coralIsDisplaying, bool? splashIsEnd}) {
    return MapScreenState(
      initialized: initialized ?? this.initialized,
      coralIsDisplaying: coralIsDisplaying ?? this.coralIsDisplaying,
      splashIsEnd: splashIsEnd ?? this.splashIsEnd,
    );
  }
}
