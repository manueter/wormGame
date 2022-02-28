class Columna
{
  PImage columna;
  int szX, szY, posY;
  
  Columna()
  {
    posY = 50;
    szX = 90;
  }
  
  void display(int posX, int alto)
  {
    columna = loadImage("assets/images/stuff/columnaDestroyed.png");
    image(columna,posX,posY,szX,alto);
  }
}
