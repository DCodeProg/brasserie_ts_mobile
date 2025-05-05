import 'package:flutter/material.dart';

class GradientSingleSchildScrollView extends StatelessWidget {
  const GradientSingleSchildScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      ColorScheme.of(context).surface,
      ColorScheme.of(context).surfaceContainer,
      ColorScheme.of(context).surfaceContainerLow,
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
      child: SingleChildScrollView(child: child),
    );
  }
}
