class MapScreenState {
  const MapScreenState(
      {required this.initialized, required this.coralIsDisplaying});

  final bool initialized;
  final bool coralIsDisplaying;

  MapScreenState copyWith({bool? initialized, bool? coralIsDisplaying}) {
    return MapScreenState(
      initialized: initialized ?? this.initialized,
      coralIsDisplaying: coralIsDisplaying ?? this.coralIsDisplaying,
    );
  }
}
