import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Repository/shared_preference_repository.dart';
import 'package:umi_sea/map/main_map/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceRepository().init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sea Farlen',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: UmiSeaColors.blue400,
          onPrimary: UmiSeaColors.gray000,
          secondary: UmiSeaColors.yellow500,
          onSecondary: UmiSeaColors.gray900,
          error: UmiSeaColors.red500,
          onError: UmiSeaColors.gray900,
          background: UmiSeaColors.gray000,
          onBackground: UmiSeaColors.gray900,
          surface: UmiSeaColors.gray000,
          onSurface: UmiSeaColors.gray900,
        ),
      ),
      home: const MapScreen(),
    );
  }
}
