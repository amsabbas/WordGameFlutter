import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;

  const ImageScreen(this.imagePath, {Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.defaultColor,
      child: PhotoView(
        imageProvider: AssetImage(widget.imagePath),
      ),
    );
  }
}
