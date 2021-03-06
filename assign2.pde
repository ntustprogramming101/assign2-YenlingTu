float lifeX=-130;

float soldierX=-160;
float soldierY=80*int(random(2,6));
float soldierSpeedX=4;

float cabbageX=80*int(random(0,8));
float cabbageY=80*int(random(2,6));

//moving 
boolean idle = true;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

int groundhogX, groundhogY, groundhogSpeed;
final int SPACING = 80;
final int X_GROUNDHOG = 320;
final int Y_GROUNDHOG = 80;


final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;

final int BUTTON_TOP =360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT =248;
final int BUTTON_RIGHT =392;

PImage bg,soil,cabbage,life1,life2,life3,groundhog,soldier,title,gameover,restartNormal,startHovered,startNormal,restartHovered,groundhogDown,groundhogRight,groundhogLeft;
int gameState = GAME_START;


void setup() {

  size(640, 480, P2D);

//background
bg=loadImage("img/bg.jpg");
soil=loadImage("img/soil.png");
life1=loadImage("img/life.png");
life2=loadImage("img/life.png");
life3=loadImage("img/life.png");
cabbage=loadImage("img/cabbage.png");
groundhog=loadImage("img/groundhogIdle.png");
soldier=loadImage("img/soldier.png");
title=loadImage("img/title.jpg");
startHovered=loadImage("img/startHovered.png");
startNormal=loadImage("img/startNormal.png");
restartHovered=loadImage("img/restartHovered.png");
restartNormal=loadImage("img/restartNormal.png");
groundhogDown=loadImage("img/groundhogDown.png");
groundhogLeft=loadImage("img/groundhogLeft.png");
groundhogRight=loadImage("img/groundhogRight.png");
gameover=loadImage("img/gameover.jpg");
  //groundhog
  groundhogX = X_GROUNDHOG;
  groundhogY = Y_GROUNDHOG;
  groundhogSpeed = 80/16;

}

void draw() {
  frameRate(60);
  switch(gameState){
    case GAME_START:
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(title,0,0);
        image(startHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(title,0,0);
        image(startNormal,248,360);
      }
      break;
    
    case GAME_RUN:
      //Background
      background(bg);
      image(bg,0,0);
      image(soil,0,160,640,320);
      image(life1,lifeX+70,10);
      image(life2,lifeX+140,10);
      image(life3,lifeX+210,10); 
      image(cabbage,cabbageX,cabbageY);
     //DrawGrass
       noStroke();
      fill(124, 204, 25);
      rect(0,145,640,15);
      //DrawSun
      stroke(255,255,0);
      strokeWeight(5);
      fill(253, 184, 19);
      ellipse(590,50,120,120);
      //Soldier
      image(soldier,soldierX,soldierY);
      soldierX+=soldierSpeedX;//Soldier Movement
      if(soldierX >= 640){soldierX = -80;}//Soldier Movement 
  
    //GroundHog Movement
 if(idle){
      image(groundhog,groundhogX,groundhogY);
    }
    
    if(downPressed){
      idle = false;
      leftPressed = false;
      rightPressed = false;
      image(groundhogDown,groundhogX,groundhogY);
      groundhogY += groundhogSpeed;
            }
        if(groundhogY%80 == 0){
        downPressed = false;
        idle = true;
         } 
    
    if(leftPressed){
      idle = false;
      downPressed = false;
      rightPressed = false;
      image(groundhogLeft,groundhogX,groundhogY);
      groundhogX -= groundhogSpeed;
      if(groundhogX%80 == 0){
        leftPressed = false;
        idle = true;
      }
    }
    
    if(rightPressed){
      idle = false;
      leftPressed = false;
      downPressed = false;
      image(groundhogRight,groundhogX,groundhogY);
      groundhogX += groundhogSpeed;
      if(groundhogX%80 == 0){
        rightPressed = false;
        idle = true;
      }
    }
    
    // Player boundary detection
    if(groundhogX<0){
      leftPressed = false;
      idle = true;
      groundhogX = 0;
    }
    if(groundhogX>width-SPACING){
      rightPressed = false;
      idle = true;
      groundhogX = width-SPACING;
    }
    if(groundhogY>height-SPACING){
      downPressed = false;
      idle = true;
      groundhogY = height-SPACING;
    }

    
    //EatCabbage
    if( groundhogX < cabbageX+80 && groundhogX+80 > cabbageX && groundhogY < cabbageY+80 && groundhogY+80 > cabbageY){
              lifeX+=70;
       cabbageX=700;
       }
    //Crash
    if( groundhogX < soldierX+80&& groundhogX+80 > soldierX && groundhogY < soldierY+80 && groundhogY+80 > soldierY){
        groundhogX=320;
        groundhogY=80;
       lifeX-=70;
       }
   // GameLose
     if(lifeX==-270){
       gameState=GAME_OVER;
       cabbageX=80*int(random(0,7));
       lifeX=-130;
      } 
     break;
     
   case GAME_OVER:
    if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(gameover,0,0);
        image(restartHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(gameover,0,0);
        image(restartNormal,248,360);
      }
      
      // reset
    
      if(mousePressed){
        soldierY = 160+80*floor(random(4));
        cabbageX = 80*floor(random(8));
        cabbageY = 160+80*floor(random(4));
        groundhogX = X_GROUNDHOG;
        groundhogY = Y_GROUNDHOG;
        gameState = GAME_RUN;
      }


      break;
    }
  }
  
void keyPressed(){
   if(key == CODED){
      switch(keyCode){
        case DOWN:
          downPressed = true;
          break;
        case LEFT:
          leftPressed = true;
          break;
        case RIGHT:
          rightPressed = true;
          break;
      }
    }

  }

void keyReleased(){
   if(key == CODED){
      switch(keyCode){
        case DOWN:
          downPressed = true;
          break;
        case LEFT:
          leftPressed = true;
          break;
        case RIGHT:
          rightPressed = true;
          break;
      }
}
  }
