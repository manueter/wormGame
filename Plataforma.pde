class Plataforma
{
  float r; 

  Plataforma(int h)
  {
  }

  void display(float xpos, float ypos, float szx, float szy)
  {
    fill(250,150,200);
    stroke(200,0,0);
    rect(xpos,ypos,szx,szy);
  }
  
}
