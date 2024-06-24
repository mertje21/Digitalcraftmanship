int width = 1700; // width of the screen/building
int height = 500; // height of the screen/ building
int centerX = width/2; // x middle point of circle 1
int centerY = height/2; // y middle point of circle 1
int centerX1 = 250; // x middle point of circle 2
int centerY1 = height/2; // y middle point of circle 2
int centerX2 = width-250; // x middle point of circle 3
int centerY2 = height/2; // y middle point of circle 3
int radius = 230; // the size of the circle 1 average creativity in Atlas building times 60
int radius1 = 230; // the size of the circle 2 average energy in Atlas building times 60
int radius2 = 214; // the size of the circle 3 average productivity in Atlas building times 60
int rectSize = 5; // Size of each rectangle (both width and height), all rectangels together form a circle. the bigger the rectangles, the less smooth it is
int[] levels = {225, 200, 150, 120, 100}; // 5 different intensities for the 3 colors
int[] segments = {0*5, 1*5, 3*5, 11*5, 7*5}; // Number of vertical segments per color based on the individual data of creatitivity in Atlas times a number to creat a full circle
int[] segments1 = {0*5,1*5, 5*5, 13*5, 3*5}; // Number of vertical segments per color based on the individual data of energy in Atlas times a number to creat a full circle
int[] segments2 = {1*4, 0*5, 9*4, 8*4, 4*4}; // Number of vertical segments per color based on the individual data of productivity in Atlas times a number to creat a full circle
void setup() {
  size(1700, 500); // the size of the screen/ building
  noLoop();
}

void draw() {
  background(255);// background color set to white
  drawGradientCircle(centerX2, centerY2, radius2, segments2, color(0,0,250,245), color(135,206,250,245));// the color of the last circle set to blue(starting and end color of gradient)
  drawGradientCircle(centerX, centerY, radius, segments, color(255, 50, 0,245), color(255, 200, 0,245));// the color of the last circle set to orange(starting and end color of gradient)
  drawGradientCircle(centerX1, centerY1, radius1, segments1, color(112, 41, 99,245), color(224, 176, 255,245));// the color of the last circle set to purple(starting and end color of gradient)
  

  save("atlas.jpg");// saving the screen as a picture
}

void drawGradientCircle(int centerX, int centerY, int radius, int[] segments, int darkestColor, int lightestColor) {
  int totalWidth = 0;
  for (int seg : segments) {
    totalWidth += seg * rectSize;
  }

  int startX = centerX - radius;
  int endX = startX + totalWidth;

  int currentLevelIndex = 0;
  int nextLevelIndex = 1;
  int currentLevelX = startX;

  for (int i = 0; i < segments.length; i++) {
    int segmentWidth = segments[i] * rectSize;
    for (int x = currentLevelX; x < currentLevelX + segmentWidth; x += rectSize) {
      float t = map(x, startX, endX, 0, 1);
      int interpolatedColor = lerpColor(darkestColor, lightestColor, t);
      drawColumn(x, centerX, centerY, radius, interpolatedColor);
    }
    currentLevelIndex++;
    if (nextLevelIndex < levels.length - 1) {
      nextLevelIndex++;
    }
    currentLevelX += segmentWidth;
  }
}

void drawColumn(int x, int centerX, int centerY, int radius, int interpolatedColor) {
  for (int y = 0; y < height; y += rectSize) {
    if (isWithinCircle(x, y, centerX, centerY, radius)) {
      fill(interpolatedColor);
      noStroke();
      rect(x, y, rectSize, rectSize);
    }
  }
}

boolean isWithinCircle(int x, int y, int centerX, int centerY, int radius) {// checking if every single rectangle is within the circle that is drawn
  float dx = x + rectSize / 2.0 - centerX;
  float dy = y + rectSize / 2.0 - centerY;
  return sq(dx) + sq(dy) <= sq(radius);
}
