import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umi_sea/Component/typography/label_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/Component/icon/icon.dart' as umi_icon;
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';

class FilterTile extends ConsumerWidget {
  const FilterTile({super.key, required this.filter});

  final Filter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(filterSheetNotifierProvider).filters[filter]!;
    final provider = ref.watch(filterSheetNotifierProvider.notifier);
    return Column(
      children: [
        IconButton(
          onPressed: () {
            provider.toggle(filter);
          },
          icon: SvgPicture.asset(
            umi_icon.Icon.coral.path,
            semanticsLabel: umi_icon.Icon.coral.name,
            width: 56,
            height: 56,
            colorFilter: ColorFilter.mode(
                isSelected
                    ? UmiSeaColors.blue400
                    : UmiSeaColors.blue400.withOpacity(0.5),
                BlendMode.srcIn),
          ),
        ),
        Text(
          filter.japaneseName,
          style: LabelTypography.middleBold,
        )
      ],
    );
  }
}
