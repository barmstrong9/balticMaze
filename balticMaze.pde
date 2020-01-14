color black      = color(0, 0, 0);
color white      = color(255, 255, 255);
color blue       = color(0, 0, 255);
color red        = color(255, 0, 0);
color yellow     = color(255, 255, 0);
color darkYellow = color(244, 196, 48);
color green      = color(0, 255, 0);
color purple     = color(68, 14, 136);

String mazeFileName = "mazeDesign.txt";

int blocksX;
int blocksY;

int exitX;
int exitY;

int startX;
int startY;

int treasureX;
int treasureY;

int enemyX;
int enemyY;

int blockSize = 21;

int mapWidth;
int mapHeight;

int score = 0;
int enemiesDefeated = 0;

boolean gameOver      = false;
boolean enemyGameOver = false;

Position[][] maze;
Player player;

// How we move around in the maze
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      player.left();
      break;
    case UP:
      player.up();
      break;
    case RIGHT:
      player.right();
      break;
    case DOWN:
      player.down();
      break;
    }
  } else if (key == ' ') {
    player.attack();
  } else if (key == 'r') {
    reset();
  }
}


void setup() {
  size(1250, 540);
  background(white);
  drawMaze();

  player = new Player(startX, startY);

  System.out.println("Start is at (" + startX + "," + startY +")");  
  System.out.println("Exit is at (" + exitX + "," + exitY +")");
}


void draw() {
  if (!gameOver) {
    for (int row=0; row<blocksY; ++row) {
      for (int col=0; col<blocksX; ++col) {
        maze[row][col].draw();
      }
    }
    fill(red);
    textSize(12);
    textAlign(CENTER+5);
    text("Complete the maze,", width/3.1, height/2.2);
    text("Room 2", width/1.2, height/2.2);
    fill(darkYellow);
    text("Collect the treasure,", width/2.4, height/2.2);
    fill(black);
    text("And defeat the enemies.", width/1.95, height/2.2);

    fill(black);
    text("Use the arrow keys to move and SPACE next to an enemy to defeat them.", width/3.3, height/2.1);
    text("Click the 'r' key to reset the maze", width/2.5, height/2);
    text("Room 2 will open when you have completed Room 1 and Room 3 when you have completed Room 2", width/3.9, height/1.9);
    
    fill(blue);
    text("Room 1", width/8, height/2.2);
    fill(green);
    text("Room 3", width/8, height/1.9);
    fill(purple);
    text("Room 4", width/1.2, height/1.9);
    player.draw();
  } else {
    background(black);
    textSize(2*blockSize);
    fill(255);
    textAlign(CENTER);
    text("You Escaped! Congratulations!", 0.5*mapWidth, 0.5*mapHeight);
    text("Press R to restart the maze", 0.5*mapWidth, 0.6*mapHeight);
    text("Score:"+score, 0.5*mapWidth, 0.7*mapHeight);
  }  
  if (enemyGameOver) {
    background(black);
    textSize(2*blockSize);
    fill(255);
    textAlign(CENTER);
    text("You lost! You didn't defeat the enemy!", 0.5*mapWidth, 0.5*mapHeight);
    text("Press R to restart the maze", 0.5*mapWidth, 0.6*mapHeight);
  }
  doors();
}

void drawMaze() {
  // Load the maze text file
  String[] text = loadStrings(mazeFileName);
  
  blocksX = text[0].length();
  blocksY = text.length;

  mapWidth  = blocksX*blockSize;
  mapHeight = blocksY*blockSize;

  maze = new Position[blocksY][];

  // Determine maze size and locations of start, exit, treasure and enemies
  for (int row=0; row<blocksY; ++row) {

    maze[row] = new Position[blocksX];

    for (int col=0; col<blocksX; ++col) {    

      char c = text[row].charAt(col);

      boolean isWall     = c == 'X';      
      boolean isExit     = c == 'E';
      boolean isStart    = c == 'S';
      boolean isTreasure = c == 'T';
      boolean isEnemy    = c == 'B';
      boolean wasEnemy   = c == 'B';

      maze[row][col] = new Position(col, row, isWall, isTreasure, isEnemy, wasEnemy); 

      if (isExit) {
        exitX = col;
        exitY = row;
      }
      if (isStart) {
        startX = col;
        startY = row;
      }
      if (isTreasure) {
        treasureX = col;
        treasureY = row;
      }
      if (isEnemy) {
        enemyX = col;
        enemyY = row;
      }
      if (wasEnemy) {
        enemyX = col;
        enemyY = row;
      }
    }
  }
  for (int row=1; row<blocksY-1; ++row) {
    for (int col=1; col<blocksX-1; ++col) {
      maze[row][col].up    = maze[row-1][col]; 
      maze[row][col].right = maze[row][col+1];
      maze[row][col].down  = maze[row+1][col];
      maze[row][col].left  = maze[row][col-1];
    }
  }
}

void doors() {
    if (player.pos.x == 27 && player.pos.y == 1 && player.pos.right.isWall && enemiesDefeated == 2 && score == 2) {
    player.pos.right.isWall = false;
  } else if (player.pos.x == 11 && player.pos.y == 11 && player.pos.down.isWall && enemiesDefeated == 4 && score == 4) {
    player.pos.down.isWall = false;
  } else if (player.pos.x == 27 && player.pos.y == 21 && player.pos.right.isWall && enemiesDefeated == 6 && score == 6) {
    player.pos.right.isWall = false;
  } else if (player.pos.x == 46 && player.pos.y == 11 && player.pos.down.isWall && enemiesDefeated >= 6 && score >= 6) {
    player.pos.down.isWall = false;
  } else if (player.pos.x == 46 && player.pos.y == 13 && player.pos.up.isWall && enemiesDefeated >= 6 && score >= 6) {
    player.pos.up.isWall = false;
  } else if (player.pos.x == 55 && player.pos.y == 23 && player.pos.right.isWall && enemiesDefeated == 8 && score == 8) {
    player.pos.right.isWall = false;
  }
}


void reset() {
  score = 0;
  enemiesDefeated = 0;
  gameOver = false;
  enemyGameOver = false;
  setup();

}
