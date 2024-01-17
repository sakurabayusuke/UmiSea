enum Icon {
  filter(path: "assets/images/icons/filter.svg"),
  coral(path: "assets/images/icons/coral.svg"),
  back(path: "assets/images/icons/back.svg"),
  go(path: "assets/images/icons/go.svg"),
  settings(path: "assets/images/icons/settings.svg");

  final String path;
  const Icon({required this.path});
}
