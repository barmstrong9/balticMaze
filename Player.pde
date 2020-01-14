class Player {

  int x, y;
  Position pos;
  public Player(int X, int Y) {
    x = X;
    y = Y; 
    pos = maze[y][x];
  } 

  void up() {
    if (pos.up != null && !pos.up.isWall) {
      pos = pos.up;
      y--;
      if (pos.isTreasure) {
        score++;
        pos.isTreasure = false;
      }
    }
  }
  void down() {
    if (pos.down != null && !pos.down.isWall) {
      pos=pos.down;
      y++;
      if (pos.isTreasure) {
        score++;
        pos.isTreasure = false;
        System.out.println(score);
      }
    }
  }
  void left() {
    if (pos.left != null && !pos.left.isWall) {
      pos=pos.left;
      x--;
      if (pos.isTreasure) {
        score++;
        pos.isTreasure = false;
      }
    }
  }
  void right() {
    if (pos.right != null && !pos.right.isWall) {
      pos=pos.right;
      x++;
      if (pos.isTreasure) {
        score++;
        pos.isTreasure = false;
      }
    }
  }

  void attack() {
    if (key == ' ') {
      if (pos.up.isEnemy) {
        pos.up.isEnemy = false;
        enemiesDefeated++;
        pos.up.wasEnemy = true;
      } else if (pos.down.isEnemy) {
        pos.down.isEnemy = false;
        enemiesDefeated++;
        pos.down.wasEnemy = true;
      } else if (pos.left.isEnemy) {
        pos.left.isEnemy = false;
        enemiesDefeated++;
        pos.left.wasEnemy = true;
      } else if (pos.right.isEnemy) {
        pos.right.isEnemy = false;
        enemiesDefeated++;
        pos.right.wasEnemy = true;
      }
    }
  } 

  void draw() {
    stroke(1.0);
    strokeWeight(1.0);
    fill(yellow);
    ellipse((0.5+x)*blockSize, (0.5+y)*blockSize, blockSize, blockSize);
    fill(black);
    ellipse((x+0.3)*blockSize, (y+0.35)*blockSize, 0.15*blockSize, 0.15*blockSize);
    ellipse((x+0.7)*blockSize, (y+0.35)*blockSize, 0.15*blockSize, 0.15*blockSize);
    noFill();
    strokeWeight(3.0);
    arc((x+0.5)*blockSize, (y+0.4)*blockSize, 0.8*blockSize, 0.8*blockSize, 0.5, PI-0.5);
    if (x==exitX && y==exitY) {
      gameOver=true;
    }
    if (pos.isEnemy) {
      enemyGameOver=true;
    }
  }
}
