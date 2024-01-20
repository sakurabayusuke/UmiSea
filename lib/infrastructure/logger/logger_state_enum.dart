enum LoggerStateEnum {
  trace(title: "[Trace]"),
  debug(title: "[Debug]"),
  info(title: "[Info]"),
  warning(title: "[Warning]"),
  exception(title: "[Exception]");

  final String title;
  const LoggerStateEnum({required this.title});
}
