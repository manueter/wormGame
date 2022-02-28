class Level_0
{
  public boolean reseteado =false;
  int pisoH = 150;
  int offset=0;
  PImage bkground;
  Techo techo;
  Floor[] pisos;
  Fuego[] fuegos;

  Columna columna; 
  Puerta puerta;
  
  int gvty;
  //Gusano gusano;
  
  public Level_0()
  {
  }
  
  public void setValues()
  {
    //this.gusano = gusano;
    //this.offset =  gus.offset;
    bkground = loadImage("assets/images/background/barro5.png");
    bkground.resize(width, height);
    
    techo = new Techo();
    
    pisos = new Floor[4];
    pisos[0] = new Floor(0,height-pisoH,300,pisoH);
    pisos[1] = new Floor(0,height-pisoH,300,pisoH);
    pisos[2] = new Floor(950,height-pisoH,200,pisoH);
    pisos[3] = new Floor(1350,height-pisoH,width,pisoH);


    fuegos = new Fuego[2];
    fuegos[0] = fuegos[1] = new Fuego();
  
    columna = new Columna();
    puerta = new Puerta();
    
    gvty = -35;
    //gus.setPosition(0,height-300-gus.getSize());
  }
  
  
  public void display(Gusano gus)
  {
    //fuegos[0] = fuegos[1] = new Fuego();
    this.offset = gus.offset*2;    //Defino velocidad de mov de "fondo" y "stuff".
    image(bkground, offset, -50);
    image(bkground, offset + bkground.width, -50);    //Se cargan dos para que uno se repita al final del otro.
    
    techo.display(0);
    techo.display(width);
    
    //Offset movimiento del entorno.
    if (offset < -bkground.width)offset=0; 
    
    fuegos[1].display(350+offset);
    fuegos[0].display(550+offset);
    fuegos[0].display(950+offset);
    fuegos[0].display(1150+offset);
    
    columna.display(100 + offset, height-pisoH-30);
    columna.display(450 + offset, height-pisoH-30);
    
    if(gusano.entreLimites(puerta.getPosX(),puerta.getPosX()+puerta.getAncho()))
    {
      puerta.touch(1450+offset,height-pisoH-puerta.getAncho()); //Ancho es igual que alto.
      gusano.nivelCompleto = true;
    }  
    else
    {
      puerta.display(1450+offset,height-pisoH-puerta.getAncho()); //Ancho es igual que alto.
      gusano.nivelCompleto = false;
    }
    
    columna.display(150 + offset, height-pisoH-30);
    
    pisos[0].place(0+offset); 
    pisos[1].place(450+offset); 
    pisos[2].place(950+offset); 
    pisos[3].place(1350+offset); 
    
    int i=0;
    while(i<pisos.length)
    {
      if(gus.apoyado(pisos[i]))
      { 
        gus.gravedad=0;
        break;
      }
      else
      {
        gus.gravedad = 0;
        gus.gravedad = gvty;
      }
      i++;
    }
    
    
    gus.display();
    columna.display(150 + offset, height-pisoH-30);
    columna.display(500 + offset, height-pisoH-30);
    columna.display(1000 + offset, height-pisoH-30);
  }
  
  
  public void reset()
  {
    pisoH = 150;
    offset=0;
    bkground = null;
    techo = null;
    pisos = null;
    fuegos = null;
  
    columna = null; 
    puerta = null;
    
    gvty = 0;
    reseteado = true;
  }
}
