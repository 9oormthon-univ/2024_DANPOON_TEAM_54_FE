import 'package:flutter/material.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/colors.dart';

class LoadingScreen extends StatelessWidget {
  static String get routeName => "loading";
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      ),
    );
  }
}
