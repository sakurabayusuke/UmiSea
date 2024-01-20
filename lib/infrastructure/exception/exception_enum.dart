enum ExceptionEnum {
  exception(errorMessage: "なんらかの障害が発生しました"),
  timeoutError(errorMessage: "サーバーから応答がありません"),
  networkError(errorMessage: "ネットワークに接続されていません"),
  serverError(errorMessage: "サーバーに障害が発生しています"),
  platformError(errorMessage: "なんらかの障害が発生しました");

  final String errorMessage;
  const ExceptionEnum({required this.errorMessage});
}
