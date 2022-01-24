import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/on_boarding/indie_3d_model.dart';
import 'package:zawadi/presentation/splash/on_boarding/indie_3d_model_controller.dart';
import 'package:zawadi/shared/app_assets/app_assets.dart';
import 'package:zawadi/shared/on_boarding/blend_mask.dart';

// import './indie_3d_model.dart';
// import 'package:shared/ui/blend_mask.dart';
// import './indie_3d_model_controller.dart';
// import 'main.dart';

class Indie3dPage extends StatelessWidget {
  const Indie3dPage({
    this.topTitle = '',
    this.bottomTitle = '',
    this.backgroundColor,
    this.image,
    this.pageIndex = 0,
    required this.controller,
    this.topTitleClipProgress = 0.0,
    this.bottomTitleClipProgress = 0.0,
    this.bottomTitleScale = 1.0,
    this.backgroundShapeOpacity = 0.85,
    Key? key,
  }) : super(key: key);

  final String topTitle;
  final String bottomTitle;
  final Color? backgroundColor;
  final ImageProvider? image;
  final int pageIndex;
  final double bottomTitleScale;

  final Indie3dModelController controller;

  final double topTitleClipProgress;
  final double bottomTitleClipProgress;
  final double backgroundShapeOpacity;

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final textScale = appSize.aspectRatio > 1 ? 1.15 : .8;
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          if (controller.initialized) ...{
            BlendMask(
              blendMode: BlendMode.hardLight,
              opacity: backgroundShapeOpacity,
              child: Indie3dModel(
                  controller: controller, pageIndex: pageIndex * 2 + 0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: appSize.height * (appSize.aspectRatio > 1 ? 1 : .80),
                child: Image(fit: BoxFit.fitHeight, image: image!),
              ),
            ),
            BlendMask(
              blendMode: BlendMode.exclusion,
              child: Indie3dModel(
                  controller: controller, pageIndex: pageIndex * 2 + 1),
            ),
            Align(
              alignment: Alignment.topRight,
              child: BlendMask(
                blendMode: BlendMode.difference,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 8, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildClippedText(topTitle, topTitleClipProgress,
                          72 * textScale, 0, 6, 1),
                      _buildClippedText(bottomTitle, bottomTitleClipProgress,
                          120 * textScale * bottomTitleScale, -10, 8, .9),
                    ],
                  ),
                ),
              ),
            ),
            BlendMask(
              opacity: 0.24,
              blendMode: BlendMode.colorDodge,
              child: Image(
                width: appSize.width,
                fit: BoxFit.none,
                image: const AssetImage(
                  AppAssets.noise,
                ),
              ),
            ),
          } else ...{
            const Center(
              child: Text(
                'Loading assets...',
                style: TextStyle(
                  // package: OnBoarding.pkg,
                  letterSpacing: 1.1,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          },
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0x99000000)],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                color: Colors.white,
                child: const Text(
                  'EXPLORE NOW',
                  style: TextStyle(
                    // package: OnBoarding.pkg,
                    letterSpacing: 1.1,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ClipRect _buildClippedText(String text, double progress, double fontSize,
      double yOffset, double spacing, double height) {
    return ClipRect(
      clipper: _Indie3dTextClipper(height: progress * fontSize, y: yOffset),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          // package: OnBoarding.pkg,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Staatliches',
          letterSpacing: spacing,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Indie3dTextClipper extends CustomClipper<Rect> {
  _Indie3dTextClipper({this.y = 0, this.height = 0});

  final double y;
  final double height;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, height + y, size.width, size.height - height);
  }

  @override
  bool shouldReclip(_Indie3dTextClipper oldClipper) {
    return true;
  }
}
