class Puerta
{
  float posX,posY;
  int ancho=200;
  PImage puerta;
  PImage puerta_bright;
  public boolean tocada=false;
  
  Puerta()
  {
    posX = 1300;
    posY= 555;
  }

  void display(float x, float y)
  {
    puerta = loadImage("assets/images/stuff/puertaFin.png");
    puerta.resize(ancho,ancho);
    this.posX = x;
    this.posY = y;
    image(puerta,posX,y);
  }
  
  void touch(float x,float y)
  {
    puerta_bright = loadImage("assets/images/stuff/puertaBright.png");
    puerta_bright.resize(ancho,ancho);
    
    this.posX = x;
    this.posY = y;
    image(puerta_bright,x,y);
    
    tocada = true;
  }
  
  public float getPosX(){return posX;}
  public void setPosX(float posX){this.posX=posX;}
  public float getAncho(){return ancho;}
}
