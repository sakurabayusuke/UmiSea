import 'package:flutter/material.dart';
import 'package:umi_sea/setting/data_source_screen.dart';
import 'package:umi_sea/setting/setting_enum.dart';

class SettingNavigator {
  static final _repository = SettingNavigator._internal();
  factory SettingNavigator() => _repository;
  SettingNavigator._internal();

  Widget getScreen(SettingEnum setting) {
    switch (setting) {
      case SettingEnum.dataSource:
        return const DataSourceScreen();
      default:
        return const Text("Error");
    }
  }
}
