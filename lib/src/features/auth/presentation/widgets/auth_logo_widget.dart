import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class AuthLogoWidget extends StatelessWidget {
  const AuthLogoWidget({
    super.key,
    this.size = Sizes.p120,
    this.topMargin = Sizes.p180,
    this.bottomMargin = Sizes.p48,
    this.assetPath = 'assets/logo_min.svg',
  });

  final double size;
  final double topMargin;
  final double bottomMargin;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        margin: EdgeInsets.only(
          top: topMargin,
          bottom: bottomMargin,
        ),
        child: SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
