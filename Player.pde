class Player
{
  static final char CHAR = 'G';
  
  PVector position;
  float jumpHeight;
  float gravity;
  float yForce;
  
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
  
  void update()
  {
    position.y += yForce;
  }
  
  void jump()
  {
    yForce = 0;
    yForce -= jumpHeight;
  }
  
  void applyGravity()
  {
    yForce += gravity;
  }
  
  void draw()
  {
    translate(-(position.x - 1) * blockWidth, -position.y * blockHeight + (height - (5 * blockHeight)));
    image(resize(Iplayer, blockWidth, blockHeight), position.x * blockWidth, position.y * blockHeight);
  }
}
