import 'package:flutter/material.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: アプリタイトルが決まり次第適用
      title: 'UmiSea',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Center(
        child: Text(
          "珊瑚礁",
          style:
              BodyTypography.largeBold.copyWith(color: UmiSeaColors.yellow500),
        ),
      ),
    );
  }
}
