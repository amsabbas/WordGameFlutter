import 'package:flutter/material.dart';

class CustomCircularProgressIndicator {
  static CircularProgressIndicator getIndicator(BuildContext context,Color? color) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
    );
  }
}
