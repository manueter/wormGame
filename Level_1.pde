class Level_1
{ 
  int pisoH = 150;
  PImage bkground;
  
  Gusano gus;
  int offset;
  int gvty;
  
  Floor floor;
  
  public Level_1()
  {
    bkground = loadImage("assets/images/background/cielo.png");
    bkground.resize(width, height);
    
    floor = new Floor();
    gvty = -35;
  }
  
  public void display(Gusano gus)
  {
    background(0);  
    this.offset = gus.offset*2;    //Defino velocidad de mov de "fondo" y "stuff".
    image(bkground, offset, -50);
    image(bkground, offset + bkground.width, -50);
    
    floor.place(1);
    
    if(gus.apoyado(this.floor)){gus.gravedad = 0;}
    else{gus.gravedad = gvty;}
    
    gus.display();
  }
}
