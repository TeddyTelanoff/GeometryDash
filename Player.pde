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
    image(resize(Iplayer, blockWidth, blockHeight), position.x * blockWidth, position.y * blockHeight);
  }
}
