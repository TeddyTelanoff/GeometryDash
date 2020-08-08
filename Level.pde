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
    size = new PVector(map[0].length(), map.length);
    
    blockWidth = width / size.x;
    blockHeight = height / size.y;
    
    for (int y = 0; y < map.length; y++)
      for (int x = 0; x < map[y].length(); x++)
        switch(map[y].charAt(x))
        {
          case Player.CHAR:
            blocks.put(new PVector(x, y), new Block(Block.AIR));
            player = new Player(new PVector(x, y), 1.5, 0.25);
            break;
          case Block.BLOCK:
            blocks.put(new PVector(x, y), new Block(Block.BLOCK));
            break;
          case Block.SPIKE:
            blocks.put(new PVector(x, y), new Block(Block.SPIKE));
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
      player.position.y += player.gravity;
      
      if (blocks.containsKey(player.intPos()))
        if (blocks.get(player.intPos()).type == Block.SPIKE)
        {
          lose();
          return;
        }
    }
    
    player.position.x++;
    if (blocks.containsKey(player.intPos()))
      if (blocks.get(player.intPos()).type != Block.AIR)
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
        player.position.y -= player.jumpHeight;
  }
}
