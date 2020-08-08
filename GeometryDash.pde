final float updateDelay = 0.14;

float blockWidth, blockHeight;

// Assets Stuff

PImage Iblock, Ispike, Iplayer;

// Time Stuff

long millis;
float deltaTime;

float et = updateDelay;

// Level Stuff

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
  imageMode(CORNER);
  
  Iblock  = loadImage("block.png");
  Ispike  = loadImage("spike.png");
  Iplayer = loadImage("player.png");
  
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

void mousePressed()
{
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

PImage resize(PImage img, float nWidth, float nHeight)
{
  int newWidth = int(nWidth);
  int newHeight = int(nHeight);
  
  PImage out = createImage(newWidth, newHeight, ARGB);
  
  int width = img.pixelWidth;
  int height = img.pixelHeight;
  
  for (int py = 0; py < newHeight; py++)
    for (int px = 0; px < newWidth; px++)
    {
      int x = int(map(px, 0, newWidth  - 1, 0, width  - 1));
      int y = int(map(py, 0, newHeight - 1, 0, height - 1));
      
      out.pixels[indexOf(px, py, out)] = img.pixels[indexOf(x, y, img)];
    }
  
  return out;
}

int indexOf(int x, int y, PImage image)
{
  return x + y * image.pixelWidth;
}
