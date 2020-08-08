class Block
{
  static final char AIR   = '.';
  static final char BLOCK = '#';
  static final char SPIKE = 'A';
  
  char type;
  
  Block(char type)
  {
    this.type = type;
  }
  
  void draw(PVector position)
  {
    switch(type)
    {
      case AIR:
        noFill();
        stroke(32);
        rect(position.x * blockWidth, position.y * blockHeight, blockWidth, blockHeight);
        break;
      case BLOCK:
        fill(100);
        stroke(64);
        rect(position.x * blockWidth, position.y * blockHeight, blockWidth, blockHeight);
        break;
      case SPIKE:
        pushMatrix();
          translate(position.x * blockWidth, position.y * blockHeight);
          beginShape();
            fill(#FF0000);
            stroke(64);
            vertex(0.5 * blockWidth, 0);
            vertex(1 * blockWidth, 1 * blockHeight);
            vertex(0, 1 * blockHeight);
          endShape();
        popMatrix();
        break;
    }
  }
}
