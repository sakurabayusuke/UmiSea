class MapScreenState {
  const MapScreenState(
      {required this.initialized,
      required this.coralIsDisplaying,
      required this.splashIsEnd,
      required this.bottomSheetIsVisible});

  final bool initialized;
  final bool coralIsDisplaying;
  final bool splashIsEnd;
  final bool bottomSheetIsVisible;

  MapScreenState copyWith(
      {bool? initialized,
      bool? coralIsDisplaying,
      bool? splashIsEnd,
      bool? bottomSheetIsVisible}) {
    return MapScreenState(
        initialized: initialized ?? this.initialized,
        coralIsDisplaying: coralIsDisplaying ?? this.coralIsDisplaying,
        splashIsEnd: splashIsEnd ?? this.splashIsEnd,
        bottomSheetIsVisible:
            bottomSheetIsVisible ?? this.bottomSheetIsVisible);
  }
}
