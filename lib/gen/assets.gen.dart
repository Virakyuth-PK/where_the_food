/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/add_to_cart.png
  AssetGenImage get addToCart =>
      const AssetGenImage('assets/images/png/add_to_cart.png');

  /// File path: assets/images/png/filter.png
  AssetGenImage get filter =>
      const AssetGenImage('assets/images/png/filter.png');

  /// File path: assets/images/png/logo_wtf.png
  AssetGenImage get logoWtf =>
      const AssetGenImage('assets/images/png/logo_wtf.png');

  /// File path: assets/images/png/magnifier.png
  AssetGenImage get magnifier =>
      const AssetGenImage('assets/images/png/magnifier.png');

  /// File path: assets/images/png/shopping_cart.png
  AssetGenImage get shoppingCart =>
      const AssetGenImage('assets/images/png/shopping_cart.png');

  /// File path: assets/images/png/soramitsu_logo.png
  AssetGenImage get soramitsuLogo =>
      const AssetGenImage('assets/images/png/soramitsu_logo.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
