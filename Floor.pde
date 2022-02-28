class Floor
{
  float ancho,alto;
  float x, y;
 
  Floor()
  {
    x = 0;
    ancho = width;
    y = height;
    alto = 11;
  }
  
  Floor(float x, float y, float ancho, float alto)
  {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }
  
  public void place(float x)
  {
    stroke(255,210,12);
    fill(0); 
    this.x = x;
    rect(x,y,ancho,alto,20,20,0,0);
  }  

  public float getX(){return x;}
  public float getY(){ return y; };
  public float getAncho(){return ancho;}
}
