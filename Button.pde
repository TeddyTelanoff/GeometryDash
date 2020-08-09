class Button
{
  ButtonEvent[] buttonEvents;
  PVector position, size;
  color col, normal, hover, pressed;
  boolean Bhover, Bpressed;
  
  Button(PVector position, PVector size, color normal, color hover, color pressed, ButtonEvent... buttonEvents)
  {
    this.position = position;
    this.size = size;
    this.normal = normal;
    this.hover = hover;
    this.pressed = pressed;
    this.buttonEvents = buttonEvents;
    
    col = normal;
  }
  
  void draw()
  {
    fill(col);
    noStroke();
    rect(position.x, position.y, size.x, size.y, 5);
  }
  
  void mouseMoved()
  {
    if
    (
      (mouseX >= position.x && mouseX <= position.x - size.x)
        &&
      (mouseY >= position.y && mouseY <= position.y - size.y)
    )
    {
      Bhover = true;
      
      if (!Bpressed)
        col = hover;
    }
    else
      Bhover = false;
  }
  
  void mousePressed()
  {
    Bpressed = true;
    
    if (Bhover)
    {
      col = pressed;
    }
  }
  
  void mouseReleased()
  {
    if (Bhover && Bpressed)
      for (ButtonEvent buttonEvent : buttonEvents)
        buttonEvent.onClicked();
    
    Bpressed = false;
  }
}
