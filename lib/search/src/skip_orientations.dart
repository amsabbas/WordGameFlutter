import './utils.dart';

final Map<WSOrientation, WSOrientationFn> wsSkipOrientations = {
  WSOrientation.horizontal: (int x, int y, int l) {
    return WSPosition(x: 0, y: y + 1);
  },

  WSOrientation.vertical: (int x, int y, int l) {
    return WSPosition(x: 0, y: y + 100);
  },

  WSOrientation.diagonal: (int x, int y, int l) {
    return WSPosition(x: 0, y: y + 1);
  },

};