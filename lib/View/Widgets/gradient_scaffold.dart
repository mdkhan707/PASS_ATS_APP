// widgets/gradient_scaffold.dart
import 'package:flutter/material.dart';
import 'package:pass_ats/constants/gradient.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  const GradientScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        drawer: drawer,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
