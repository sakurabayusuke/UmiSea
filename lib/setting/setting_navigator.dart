import 'package:flutter/material.dart';
import 'package:umi_sea/setting/data_source_screen.dart';
import 'package:umi_sea/setting/license/license_list_screen.dart';
import 'package:umi_sea/setting/setting_enum.dart';
import 'package:umi_sea/setting/term_of_service_screen.dart';

class SettingNavigator {
  static final _repository = SettingNavigator._internal();
  factory SettingNavigator() => _repository;
  SettingNavigator._internal();

  Widget getScreen(SettingEnum setting) {
    switch (setting) {
      case SettingEnum.dataSource:
        return const DataSourceScreen();
      case SettingEnum.license:
        return const LicenseListScreen();
      case SettingEnum.termOfService:
        return const TermOfServiceScreen();
      default:
        return const Text("Error");
    }
  }
}
