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
  static const int _baseSize = 56;
  static final TextStyle _baseTextStyle = LabelTypography.middleBold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(filterSheetNotifierProvider).filters[filter]!;
    final notifier = ref.watch(filterSheetNotifierProvider.notifier);

    var buttonSize = _baseSize;
    var textStyle = _baseTextStyle;
    if (768 < MediaQuery.of(context).size.width) {
      buttonSize = _baseSize * 2;
      textStyle = LabelTypography.e3LargeBold;
    }
    return Column(
      children: [
        IconButton(
          onPressed: () {
            if (isSelected) {
              notifier.removeCoralLayer(filter);
            } else {
              notifier.addCoralLayer(filter);
            }
          },
          icon: SvgPicture.asset(
            umi_icon.Icon.coral.path,
            semanticsLabel: umi_icon.Icon.coral.name,
            width: buttonSize.toDouble(),
            height: buttonSize.toDouble(),
            colorFilter: ColorFilter.mode(
                isSelected
                    ? UmiSeaColors.blue400
                    : UmiSeaColors.blue400.withOpacity(0.5),
                BlendMode.srcIn),
          ),
        ),
        Text(
          filter.japaneseName,
          style: textStyle,
        )
      ],
    );
  }
}
