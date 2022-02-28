import processing.sound.SoundFile;
SoundFile music, fireSound;

float frameAlJugar =0;
float framesJugados, segundosJugados, frameMusica;
float cueMusica, posMusica;
float totalMusicFrame, totalMusicDuration;

Gusano gusano;
Menu menu;
Level_0 level0;
Level_1 level1;
boolean changeLevel;

String nameFileSound = "";
String pathFileSound = "";

void setup ()
{
  frameRate(15);  //15 frames por segundo.
  size(1360,768);
  //fullScreen();
  
  changeLevel=false; 
  music = new SoundFile(this, "assets/sounds/music/wormTunnel_lowQ.mp3");
  totalMusicFrame = music.frames(); 
  totalMusicDuration = music.duration();
  fireSound = new SoundFile(this, "assets/sounds/effects/fire.mp3");
  menu = new Menu();
  gusano = new Gusano(90);
  
  level0 = new Level_0(); level0.setValues();
  level1 = new Level_1(); //level1.setValues();
} 


void draw()
{
  if(menu.pausado || menu.inicio)
  {
    if(music.isPlaying()){music.stop();}
    if(!fireSound.isPlaying()){ fireSound.loop();}
    fireSound.amp(1);
    
    if(menu.salir){salir();}
    menu.display();
    
    if(menu.jugando)
    {
      //MODO PAUSA 
      cueMusica = cueMusica + segundosJugados;
      menu.jugando = false;
    }
  }
  else
  {   
    menu.reset();    
    fireSound.amp(0.7);
    
    if(!menu.jugando)
    {
      frameAlJugar = frameCount;
      menu.jugando = true;
    }
    else
    {
      //vuelta despues de pausa. 
      framesJugados = frameCount-frameAlJugar;
      segundosJugados = framesJugados/frameRate;
      posMusica = cueMusica+segundosJugados;
      frameMusica = posMusica*15;
    }
    
    if(frameMusica < totalMusicFrame-1  && posMusica < totalMusicDuration-0.1) 
    {
      if(!music.isPlaying() )
      {
        music.jump(cueMusica);
      }
    }
    else
    {
      posMusica = 0;
      cueMusica = 0;
      frameAlJugar = frameCount;
      //music.stop();
      music.jump(0);
    }
     

    if(changeLevel)
    { 
      gusano.nivelCompleto = false;
      level1.display(gusano);
    }
    else
    {
      gusano.nivelCompleto = false;
      if(level0.reseteado) {level0.setValues(); level0.reseteado = false;} 
      
      if(!music.isPlaying())
      {  
        if(frameMusica < totalMusicFrame  && posMusica < totalMusicDuration) music.loop(); 
      }
      
      level0.display(gusano);
      if(gusano.getPosY()>height+gusano.getSize())
      {
        finJuego();
        noLoop();
        volverAlMenu();
      }
    }
  }
  
}

void finJuego()
{
  menu.inicio = true;
  menu.pausado = false; 
  menu.jugando = false;
  
  posMusica = 0;
  cueMusica = 0;
  
  gusano.reset();
  gusano.muerto = true;
  changeLevel=false;
  background(0);
        
  textAlign(CENTER, CENTER);
  fill(224, 0, 30, 204);
  textSize(280);
  text("Has muerto", width/2, height/2);  
  
  fill(204, 20, 50, 84);
  textSize(180);
  text("Has muerto", width/2, (height/2)-80);
  text("Has muerto", width/2, (height/2)+160);  
  
  
  fill(204, 220, 0, 60);
  textSize(18);
  text("< presione ENTER o RETURN para continuar >", width/2, (height/2)+350);
}

void volverAlMenu()
{
  menu.pausado = true;  
}

void salir()
{
  Runtime.getRuntime().exit(1);
}

void keyReleased()
{
  if(key=='w'||key=='W')
  {
    if(gusano.apoyado) {gusano.w = false; gusano.saltado=false;}   
  }
  if(key=='s'||key=='S')
  {
    gusano.s = false;
  }
  if(key=='a'||key=='A')
  {
    gusano.a = false;
    gusano.inercia=false;
  }
  if(key=='d'||key=='D')
  {
    gusano.d = false;
    gusano.inercia=false;
  }
}


void keyPressed()
{  
  if (key =='r')
  {
    changeLevel=false; 
    gusano.inercia = false;
    //gusano.setPosition(0,height-pisoH-gusano.getSize());
  }
  
  if(key==ENTER || key==RETURN)
  {
    if(gusano.muerto){    loop(); volverAlMenu(); }
  }
  if(key=='m' || key=='M')
  {
    volverAlMenu();
  }
  
  
  if(key=='w'||key=='W')
  {
    gusano.w = true;
    if(gusano.nivelCompleto && gusano.apoyado) 
    {
      changeLevel=true; 
    }
  }
  if(key=='s'||key=='S')
  {
    gusano.s = true;
  }
  if(key=='a'||key=='A')
  {
    gusano.a = true;
  }
  if(key=='d'||key=='D')
  {
    gusano.d = true;
  }  
}
