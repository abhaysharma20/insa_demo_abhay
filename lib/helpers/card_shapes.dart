import 'package:flutter/material.dart';

class TransparentBorderShape extends RoundedRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.lineTo(rect.width, 0.0);
    path.lineTo(rect.width, rect.height);
    path.lineTo(0.0, rect.height);

    const cutoutWidth = 20.0;
    final cutoutHeight = rect.height / 2;

    path.lineTo(0.0, rect.height / 2 - cutoutHeight / 2);

    path.lineTo(0.0, rect.height / 2 + cutoutHeight / 2);

    path.close();

    return path;
  }
}
