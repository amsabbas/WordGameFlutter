import './utils.dart';

final Map<WSOrientation, WSCheckOrientationFn> wsCheckOrientations = {
  WSOrientation.horizontal: (int x, int y, int h, int w, int l) {
    return w >= x + l;
  },
  WSOrientation.vertical: (int x, int y, int h, int w, int l) {
    return h >= y + l;
  },
  WSOrientation.diagonal: (int x, int y, int h, int w, int l) {
    return w >= x + l && h >= y + l;
  },
};