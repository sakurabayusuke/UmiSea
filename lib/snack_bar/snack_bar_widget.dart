import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/snack_bar/snack_bar_notifier.dart';

class SnackBarWidget extends ConsumerStatefulWidget {
  const SnackBarWidget({super.key});

  @override
  ConsumerState<SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends ConsumerState<SnackBarWidget> {
  @override
  Widget build(BuildContext context) {
    final snackState = ref.watch(snackBarNotifierProvider);

    Future.microtask(
      () {
        if (snackState.isEmpty) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              snackState,
              style: BodyTypography.middle.copyWith(
                color: UmiSeaColors.gray000,
              ),
            ),
            backgroundColor: UmiSeaColors.gray800,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(bottom: 32, right: 24, left: 24),
          ),
        );
        Future.delayed(const Duration(seconds: 5),
            () => ref.read(snackBarNotifierProvider.notifier).clearState());
      },
    );
    return Container();
  }
}
