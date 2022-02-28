
class Fuego
{
  int imageCount;
  int frame;
  PImage[] fuegos;
  
  float posX,posY;
  PImage fuego;
  
  public Fuego()
  {
    posY = height-200;
  }
  
  public void display(int x)
  {
    imageCount = 6; 
    fuegos=new PImage[imageCount];
    frame = (frame+1)%imageCount;
    //fuego = loadImage("assets/images/stuff/fuego_00.png");    
    
    for (int i=0; i<imageCount; i++)
    {
      String filename = "assets/images/stuff/fuego_"+nf(i,2) + ".png";
      fuegos[i] = loadImage(filename);  
      fuegos[i].resize(410,200);
    }   
    

    image(fuegos[frame],x-50,posY);   
    
  }

}
