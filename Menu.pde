class Menu
{
  public boolean inicio, pausado, salir, jugando;
  Fuego[] fuegos;
  public Menu()
  {
    inicio = true;
    pausado = false;
    salir = false;
    jugando = false;
    background(0);
    fuegos = new Fuego[2];
    fuegos[0] = fuegos[1] = new Fuego();
  }
  
  void reset()
  {
    fuegos[0] = null;
    fuegos[1] = null;
  }
  
  void display()
  {
    salir = false;
    background(0);
    iniciar();
    salir();
    if(fuegos[0]==null || fuegos[1] ==null){ fuegos[0] = new Fuego();  fuegos[1] = new Fuego(); }
    fuegos[1].display(0);
    fuegos[1].display(350);
    fuegos[0].display(550);
    fuegos[0].display(950);
    fuegos[0].display(1150);
    
    
    //Si esta dentro de INICIO
    if(mouseX>(width/2)-200 && mouseX<(width/2)+200)
    {
      if(mouseY<(height/2) && mouseY>(height/2)-150) 
      {
        fill(255, 255, 0, 200);
        textSize(100);
        
        if(!inicio) {text("Continuar", width/2, height/2-100);}
        else{text("Inicio", width/2, height/2-100);  }
        
        if(mousePressed) { pausado = false; inicio = false;}
      }
      
    }
    
    //Si esta dentro de SALIR
    if(mouseX>(width/2)-200 && mouseX<(width/2)+200)
    {
      if(mouseY<(height/2)+200 && mouseY>(height/2)+50) 
      {
        fill(255, 255, 0, 200);
        textSize(100);
        text("Salir", width/2, height/2+100);  
        
        if(mousePressed) salir = true;
      }
    }
  }
  
  void iniciar()
  {
    textAlign(CENTER, CENTER);
    fill(255, 255, 230, 50);
    textSize(100);
    if(!inicio){text("Continuar", width/2, height/2-100);  }
    else{text("Inicio", width/2, height/2-100);  }
  }

  void salir()
  {
    textAlign(CENTER, CENTER);
    fill(255, 255, 230, 50);
    textSize(100);
    text("Salir", width/2, height/2+100);  
  }

  
}
