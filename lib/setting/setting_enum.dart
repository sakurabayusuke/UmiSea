enum SettingEnum {
  aboutThisService(displayName: "このサービスについて"),
  subScription(displayName: "サブスクリプション"),
  termOfService(displayName: "利用規約"),
  license(displayName: "ライセンス"),
  dataSource(displayName: "データ出典");

  final String displayName;
  const SettingEnum({required this.displayName});
}
