import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardItemRender extends SingleChildRenderObjectWidget {
  final int index;
  final String value;

  const CardItemRender(
      {required Widget child,
      required this.index,
      required this.value,
      Key? key})
      : super(child: child, key: key);

  @override
  CardItem createRenderObject(BuildContext context) {
    return CardItem(index, value);
  }

  @override
  void updateRenderObject(BuildContext context, CardItem renderObject) {
    renderObject.index = index;
    renderObject.value = value;
  }
}

class CardItem extends RenderProxyBox {
  int index;
  String value;

  CardItem(this.index, this.value);
}
