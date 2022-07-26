import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class GradinentTextGive extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final double fontSize;
  const GradinentTextGive(
      {Key? key, this.fontSize = 50, required this.text, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize),
      gradient: LinearGradient(
          colors: colors, begin: Alignment.bottomRight, end: Alignment.topLeft),
    );
  }
}
