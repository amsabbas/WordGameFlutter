import './utils.dart';

final Map<WSOrientation, WSOrientationFn> wsOrientations = {
  WSOrientation.horizontal: (int x, int y, int i) {
    return WSPosition(x: x + i, y: y);
  },

  WSOrientation.vertical: (int x, int y, int i) {
    return WSPosition(x: x, y: y + i);
  },
  WSOrientation.diagonal: (int x, int y, int i) {
    return WSPosition(x: x + i, y: y + i);
  },

};