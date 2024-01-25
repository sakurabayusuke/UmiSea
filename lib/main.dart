import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/infrastructure/repository/shared_preference_repository.dart';
import 'package:umi_sea/initial_consent_screen.dart';
import 'package:umi_sea/map/main_map/map_screen.dart';
import 'package:umi_sea/setting/initial_consent_repository.dart';
import 'package:umi_sea/snack_bar_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceRepository().init();
  MobileAds.instance.initialize();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

final logger = Logger();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needConsentScreen = !ref.read(initialConsentRepositoryProvider);

    final mainScreen = needConsentScreen
        ? const InitialConsentScreen()
        : Stack(
            children: [
              MapScreen(),
              const SnackBarWidget(),
            ],
          );

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
      home: mainScreen,
    );
  }
}
