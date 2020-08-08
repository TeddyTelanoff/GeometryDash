class Player
{
  static final char CHAR = 'G';
  
  PVector position;
  float jumpHeight;
  float gravity;
  
  Player(PVector position, float jumpHeight, float gravity)
  {
    this.position = position;
    this.jumpHeight = jumpHeight;
    this.gravity = gravity;
  }
  
  PVector intPos()
  {
    return new PVector(floor(position.x), floor(position.y));
  }
  
  void draw()
  {
    fill(#00FF00);
    noStroke();
    rect(position.x * blockWidth, position.y * blockHeight, blockWidth, blockHeight);
  }
}
