class Gusano 
{
  String rootImg = "assets/images/worm/worm_";
  PImage[] imagesRight;
  PImage[] imagesLeft;
  int imageCount;
  int frame;
  
  PImage saltoR, saltoL;
  PImage quietoR, quietoL;
  PImage crouchR, crouchL;
  
  float posX, posY;
  float szx, szy;
  int velocidad = 16;
  public int offset;
  
  float topeSalto;
  
  public boolean w,a,s,d;
  
  public int gravedad;
  public boolean apoyado;
  public boolean quieto  =  true;
  public boolean saltado = false;
  public boolean inercia = false;
  public boolean muerto  = false;
  public boolean nivelCompleto = false;
  boolean left=false;  
  
  
  Gusano(int size)
  {
     posX=0; posY=0;
     szx=szy=size;
     CargaImagenes(); 
     gravedad = 0;
     offset = 0;
  }
  
  public float getPosX(){return posX;}
  public float getPosY(){return posY;}
  public float getSize(){return szy;}
  public void setPosition(float posX, float posY){this.posX=posX; this.posY=posY; topeSalto = 400;}
  
  void CargaImagenes()
  {
    cargaAnimacion(3);
    quietoR = loadImage(rootImg+"right_00.gif");
    quietoL = loadImage(rootImg+"left_00.gif");
    saltoR  = loadImage(rootImg+"right_jump.gif");
    saltoL  = loadImage(rootImg+"left_jump.gif");
    crouchR = loadImage(rootImg+"right_crouch.gif");
    crouchL = loadImage(rootImg+"left_crouch.gif");
  }
  
  void cargaAnimacion(int count)
  {
    
    imageCount = count;
    imagesRight=new PImage[imageCount];
    imagesLeft =new PImage[imageCount];
    
    for (int i=0; i<imageCount; i++)
    {
      String filename = rootImg + "right_"+nf(i,2) + ".gif";
      imagesRight[i] = loadImage(filename);  
      filename = rootImg + "left_"+nf(i,2) + ".gif";
      imagesLeft[i] = loadImage(filename);  
    }     
  }
  
  void display()
  {
    frame = (frame+1)%imageCount;
    //quieto = true;
   
    if(w)
    {
      //SALTO
      if(!saltado)
      {
        //SALTO primer impulso
        if(s){agache();}
        else{salto();}
        
        quieto = false;
        if(posY>=topeSalto)
        {
          
          if(a||d)
          {
            if(left){ posX-=velocidad+25;  this.offset+=velocidad/4;  quieto=false;}
            else    { posX+=velocidad+25;  this.offset-=velocidad/4;  quieto=false;}
            posY += gravedad-40; //altura salto o intensidad 
          }
          else
          {
            //altura salto o intensidad 
            posY += gravedad-35;           
          }
        } 
        else
        {
          saltado = true;
        }
      }
      else //Puede ser que saltado=true o que apoyado=false
      {
        if(d){ posX+=velocidad+35;  this.offset-=velocidad/4;  left=false; quieto=false;  inercia=true;}
        if(a){ posX-=velocidad+35;  this.offset+=velocidad/4;  left=true;  quieto=false;  inercia=true;} 
        posY-=gravedad;
        if(!apoyado)
        {
          salto();
          
          if(!saltado)
          {
            //Cuando se activa/
            if(!inercia){posY-=gravedad*2;}
            
            saltado = true;  
            apoyado = false;
          }
          else
          {
          //Al llegar al punto max lo devuelve hacia abajo.
          //Rebote
          apoyado = false;
            posY-=gravedad*3; 
          } 
        }
        else
        {
          //Al apoyarse; y estar apretada la w.
          if(saltado) quieto(posX,posY);
        }
      }
    }  //FIN if(w)
    else    
    {
      //Si w no está presionado.
      if(s) 
      {
        //AGACHARSE
        if(d)
          {  
            left=false;
            inercia=true;
            posX+=velocidad;  
            this.offset-=velocidad/4;  
          }
          else if(a && posX>1)
          {
            left=true; 
            inercia=true; 
            posX-=velocidad;
            this.offset+=velocidad/4; 
          }
        agache();
      }
      else
      {
        //w y s son false.
        //Si se mueve izquierda o derecha.
        if(apoyado)
        {
          w=false;
          saltado = false;
          if(d)
          {  
            left=false;
            inercia=true;
            posX+=velocidad;  
            this.offset-=velocidad/4; 
            
            image(imagesRight[frame],posX,posY,szx,szy);            
          }
          else if(a && posX>1)
          {
            left=true; 
            inercia=true; 
            posX-=velocidad;
            this.offset+=velocidad/4; 
            
            image(imagesLeft[frame],posX,posY,szx,szy); 
          }
          else{quieto(posX,posY);}  //Si no se mueve está quieto.
        }
        else
        {         
          //cayendo ??
          salto();
          posY-=gravedad*2;
          //Si no esta apoyado.
          if(posY <= height && inercia) //Verifica si no cayo por debajo del mapa.
            {
              //Cuando está cayendo, verifica si hay inercia.
              if(left){posX-=velocidad; this.offset+=velocidad/8; }
              else{    posX+=velocidad; this.offset-=velocidad/8; }      
            }
        }
        //FIN APOYADO.
      }
      //FIN S
    }
    //FIN W
  }  
    
  

  public void quieto(float x, float y)
  {
    quieto = true;
    //inercia = false;
    w = false;
    if(left){ a=false; image(quietoL,x,y,szx,szy);}
    else{     d=false; image(quietoR,x,y,szx,szy);}
  } 
  
  public void salto()
  {
    apoyado = false;
    
    if(left){ image(saltoL,posX,posY,szx,szy);}
    else{     image(saltoR,posX,posY,szx,szy);} 
  }
  
  public void agache()
  {
    if(left){  image(crouchL,posX,posY,szx,szy);}
    else{      image(crouchR,posX,posY,szx,szy);} 
  }


//ACTUALIZAR lograr que el objeto recibido puedan ser las plataformas.
  boolean apoyado(Floor obj)
  {
    apoyado=false;
    float dinf = dist (posX, posY, posX, obj.getY());
    float limX1= obj.getX();
    float limX2= limX1 + obj.getAncho();
    
    float limY = obj.getY();
    
    
    if(entreLimites(limX1,limX2))
    {
      if(posY+szy <= limY || posY > limY+szy)
      { 
        apoyado=false;
        return apoyado;
      }
      else
      {
        if (dinf>=5){ gusano.setPosition(posX, limY-szy+20); apoyado=true;}
        
        inercia=false; 
        apoyado = true;
        return apoyado;
      }
    }
    
    else return apoyado;
  }
  
  boolean entreLimites(float x1, float x2)
  {
    float mitadSize = this.szx/2;
    if(this.posX+mitadSize>=x1 && this.posX+mitadSize<=x2) return true;
    return false;
  }
  
  public void reset()
  {
    a=false;
    s=false;
    w=false;
    d=false;
    left = false;
    apoyado = false;
    quieto  =  true;
    saltado = false;
    inercia = false;
    muerto  = false;
    nivelCompleto = false;
    
    posX=0; posY=0;
    //szx=szy=size;
    //CargaImagenes(); 
    gravedad = 0;
    offset = 0;
  }
}
