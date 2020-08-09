class Level
{
  Player player;
  HashMap<PVector, Block> blocks;
  PVector size;
  String[] map;
  
  Level(String... map)
  {
    this.map = map;
    
    genMap();
  }
  
  void genMap()
  {
    blocks = new HashMap();
    
    for (int y = 0; y < map.length; y++)
      for (int x = 0; x < map[y].length(); x++)
        switch(map[y].charAt(x))
        {
          case Player.CHAR:
            blocks.put(new PVector(x, y), new Block(Block.AIR));
            player = new Player(new PVector(x, y), 0.75, 0.25);
            break;
          case Block.BLOCK:
            blocks.put(new PVector(x, y), new Block(Block.BLOCK));
            break;
          case Block.SPIKE:
            blocks.put(new PVector(x, y), new Block(Block.SPIKE));
            break;
          case Block.SHADOW:
            blocks.put(new PVector(x, y), new Block(Block.SHADOW));
            break;
          case Block.ACID:
            blocks.put(new PVector(x, y), new Block(Block.ACID));
            break;
          
          default:
            blocks.put(new PVector(x, y), new Block(Block.AIR));
            break;
        }
  }
  
  void update()
  {
    if (!blocks.containsKey(player.intPos()))
    {
      nextLevel();
      return;
    }
    
    if (blocks.get(new PVector(player.intPos().x, player.intPos().y + 1)).type != Block.BLOCK)
    {
      player.applyGravity();
      
      PVector before = player.intPos();
      player.update();
      
      for (int y = int(before.y); y < player.intPos().y; y++)
      {
        if (blocks.containsKey(new PVector(player.intPos().x, y)))
        {
          if (blocks.get(player.intPos()).type == Block.SPIKE)
          {
            lose();
            return;
          }
          else if (blocks.get(player.intPos()).type == Block.BLOCK)
          {
            player.position = new PVector(player.position.x, y - 1);
          }
        }
      }
    }
    
    player.position.x++;
    if (blocks.containsKey(player.intPos()))
      if (!(blocks.get(player.intPos()).type == Block.AIR || blocks.get(player.intPos()).type == Block.SHADOW))
      {
        lose();
        return;
      }
  }
  
  void draw()
  {
    player.draw();
    
    for (int y = 0; y < map.length; y++)
      for (int x = 0; x < map[y].length(); x++)
      {
        blocks.get(new PVector(x, y)).draw(new PVector(x, y));
      }
  }
  
  void jump()
  {
    if (blocks.containsKey(new PVector(player.intPos().x, player.intPos().y + 1)))
      if (blocks.get(new PVector(player.intPos().x, player.intPos().y + 1)).type == Block.BLOCK)
        player.jump();
    player.update();
  }
}
