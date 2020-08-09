final float updateDelay = 0.14;
final PVector blocks = new PVector(16/2*3, 10/2*3);

float blockWidth, blockHeight;

// Assets Stuff

PImage Iblock, Ispike, Ishadow, Iacid, Iplayer;

// Time Stuff

long millis;
float deltaTime;

float et = updateDelay;

// Level Stuff

String[][] levels;

int level;

Level l;

Boolean cont;

// GUI Stuff

Button respawnB;

void setup()
{
  fullScreen();
  imageMode(CORNER);
  
  blockWidth  = width  / blocks.x;
  blockHeight = height / blocks.y;
  
  levels =
    new String[][]
    {
      loadStrings("tutorial.lvl"),
      //loadStrings("insane.lvl")
      {}
    };
  
  //
  
  Iblock  = loadImage( "block.png"  );
  Ispike  = loadImage( "spike.png"  );
  Ishadow = loadImage( "shadow.png" );
  Iacid   = loadImage(  "acid.png"  );
  Iplayer = loadImage( "player.png" );
  
  //
  
  respawnB = new Button(new PVector(100, 100), new PVector(width - 100, height - 100), color(100), color(69), color(32));
  
  //
  
  nextLevel();
}

void draw()
{
  if (cont == null)
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
  else if (cont)
  {
    win();
  }
  else
  {
    lose();
  }
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
  background(57);
  
  fill(#00FF00);
  textAlign(CENTER, CENTER);
  textSize(height/3);
  text("You Won!", width/2, height/2);
  
  cont = true;
}

void lose()
{
  background(#FF0000);
  
  fill(57);
  textAlign(CENTER, CENTER);
  textSize(height/3);
  text("You Lost!", width/2, height/2);
  
  cont = false;
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
