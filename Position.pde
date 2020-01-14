public class Position {
  int x, y;
  float rectX, rectY;
  boolean isWall;
  boolean isTreasure;
  boolean isEnemy;
  boolean wasEnemy;
  boolean isStart;
  Position up, down, left, right;

  public Position(int X, int Y, boolean IsWall, boolean IsTreasure, boolean IsEnemy, boolean WasEnemy) {
    x = X;
    y = Y;
    rectX = X*blockSize;
    rectY = Y*blockSize;
    isWall = IsWall;
    isTreasure = IsTreasure;
    isEnemy = IsEnemy;
    wasEnemy = WasEnemy;
    up = null;
    right = null; 
    down = null;
    left = null;
  }

  void draw() {
    noStroke();
    if (isWall && rectX <=580 && rectY < 232) {
      fill(blue);
    } else if (isWall && rectX > 580 && rectY < 252) {
      fill(red);
    } else if (isWall && rectX <= 580 && rectY >= 252) {
      fill(green);
    } else if (isWall && rectX > 580 && rectY >= 252) {
      fill(purple);
    } else if (isTreasure) {
      fill(darkYellow);
    } else if (isEnemy) {
      fill(black);
    } else {
      fill(white);
    }

    rect(rectX, rectY, blockSize, blockSize);
  }
};
