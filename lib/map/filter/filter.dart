import 'package:umi_sea/Component/maker/maker.dart';

enum Filter {
  coral(englishName: "coral", japaneseName: "珊瑚", maker: Maker.coral);

  final String englishName;
  final String japaneseName;
  final Maker maker;
  const Filter({
    required this.englishName,
    required this.japaneseName,
    required this.maker,
  });
}
