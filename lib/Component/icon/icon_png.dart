enum IconPng {
  coral(path: "assets/images/icons/coral.png", height: 168, width: 168),
  coralMarker(
      path: "assets/images/icons/coral_marker.png", height: 138, width: 93);

  final String path;
  final int height;
  final int width;
  const IconPng({
    required this.path,
    required this.height,
    required this.width,
  });
}
