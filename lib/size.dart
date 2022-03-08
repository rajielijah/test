const double designHeight = 812;
const double designWidth = 375;

double resWidth(width, sWidth) {
  return width / designWidth * sWidth;
}

double resHeight(height, sHeight) {
  return height / designHeight * sHeight;
}