final float updateDelay = 0.14;

float blockWidth, blockHeight;

long millis;
float deltaTime;

float et = updateDelay;

String[][] levels =
{
  {
    "..........",
    "..........",
    "G.......A.",
    "##########"
  },
  {
    ".............",
    ".............",
    "G.......AA...",
    "############."
  }
};

int level;

Level l;

void setup()
{
  fullScreen();
  
  nextLevel();
}

void draw()
{ 
  deltaTime = (float) (millis() - millis) / 1000;
  millis = millis();
  
  background(57);
  
  if (et >= updateDelay)
  {
    et = 0;
    
    l.update();
  }
  et += deltaTime;
  
  l.draw();
}

void keyReleased()
{
  if (keyCode == 32)
    l.jump();
}

void win()
{
  noLoop();
}

void lose()
{
  noLoop();
}

void nextLevel()
{
  if (level >= levels.length)
  {
    win();
    return;
  }
  
  l = new Level(levels[level]);
  
  level++;
}
