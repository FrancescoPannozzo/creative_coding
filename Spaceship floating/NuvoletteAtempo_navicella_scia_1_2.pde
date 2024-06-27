import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer mySound;
FFT fftLin;

PShape s; //nuvoletta
int x = 0;
int ns = 12;

PShape [] ss = new PShape[ns];
float speedn = random(0.2, 1);
PVector [] cs = new PVector[ns];

int nc = 40; //n particelle scia
PVector [] circles = new PVector[nc]; //scia navicella

int nh = 20; //numero case
PVector [] houses = new PVector[nh];
int speedh = 8; //velocità case

int nm = 10; //numero montagne
PVector [] mountains = new PVector[nm];
float speedm = 3; //velocità montagne

int nhills = 10; //numero colline
PVector [] hills = new PVector[nhills];
float  speedHills= 6; //velocità colline

PVector [] colors = new PVector[nc];

int speedLaser = 10;

boolean isShoot = false;
boolean wait = false;

PVector laserxy;
float lx;
int ly;

void setup() {  
  size(500, 300);
  //fullScreen();
  background(41, 182, 246);
  for (int i = 0; i < ns; i++) {
    ss[i] = loadShape("nuvoletta.svg");
    cs[i] = new PVector( (int)random(-80, width/2), 
      (int)random(0, height-height/2), 
      random(1, 2) );
  }

  for (int i = 0; i < nc; i++) {
    circles[i] = new PVector(0, 0);
    colors[i] = new PVector(random(250, 255), random(0, 255), random(0, 255));
  }

  for (int i = 0; i < nh; i++) {
    houses[i] = new PVector( random(5, width), random(height-80, height-40), random(20, 30));
  }

  //creo montagne
  for (int i = 0; i < nm; i++) {
    float dim = random(100, 200);
    mountains[i] = new PVector( random(1, width + dim), random( height/2-80, height/2 ), dim);
  }

  for (int i = 0; i < nhills; i++) {
    hills[i] = new PVector( i*150, random(height/2+30, height/2+80), random(300, 350));
  }

  laserxy= new PVector(mouseX, mouseY);
  lx = mouseX;
  ly = mouseY;

  minim = new Minim(this);
  mySound = minim.loadFile("lego.mp3");
  mySound.play();

  fftLin = new FFT(mySound.bufferSize(), mySound.sampleRate());
  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  fftLin.linAverages( ns );
}

void draw() {
  //background(41, 182, 246);

  //background(0);
  //Effetto fade-out 
  //fill(41, 182, 246, 180);
  //rect(0, 0, width, height);

  if (keyPressed) {
    if (key == 'f') {
      mySound.skip(1500);
    } else if (key == 'r') {
      mySound.play(mySound.position()-5000);
    }
    println("key pressed");
  }


  float speedn = 1;
  if (mousePressed) {
    fill(41, 182, 246, 90);
    rect(0, 0, width, height);
    speedn = 2;
    speedh = 20;
    speedm = 4;
    speedHills = 7;
  } else {
    background(41, 182, 246);
    speedn = 1;
    speedh = 10;
    speedm = 1;
    speedHills = 3;
  }


  for (int i = 0; i < ns; i++) {
    shape(ss[i], cs[i].x -= cs[i].z*speedn, cs[i].y, map(abs(mySound.mix.get(3)*80), 0, 40, 70, 80), map(abs(mySound.mix.get(3)*80), 0, 40, 70, 80));
    if (cs[i].x < -40)
      cs[i].set(width+40, cs[i].y, cs[i].z);
  }

  for (int i = 0; i < nm; i++) {
    fill(121, 85, 72);
    if (mountains[i].x<=(-mountains[i].z))mountains[i].set(width + mountains[i].z, mountains[i].y, mountains[i].z);
    else mountains[i].set(mountains[i].x-=speedm, mountains[i].y, mountains[i].z);
    strokeWeight(2.5);
    stroke(0, 255, 255);
    triangle(mountains[i].x, mountains[i].y, 
      mountains[i].x - mountains[i].z*10, height + mountains[i].z*10, 
      mountains[i].x + mountains[i].z*10, height + mountains[i].z*10);
  }

  for (int i = 0; i < nhills; i++) {
    if (hills[i].x<=(-hills[i].z))hills[i].set(width+hills[i].z, hills[i].y, hills[i].z);
    else hills[i].set(hills[i].x-=speedHills, hills[i].y, hills[i].z);
    ellipseMode(CORNER);
    fill(76, 175, 80);
    strokeWeight(2.5);
    stroke(205, 220, 57);
    ellipse(hills[i].x, hills[i].y, hills[i].z, hills[i].y ); //height - hills[i].y
  }

  fill(232, 30, 99);
  rect(0, height - 40, width, 40);

  for (int i = 0; i < nh; i++) {
    if (houses[i].x<=0)houses[i].set(width, houses[i].y, houses[i].z);
    else houses[i].set(houses[i].x-=speedh, houses[i].y, houses[i].z);
    fill(120, 140, 150); 
    strokeWeight(2.5);
    stroke(255, 255, 255);
    rect(houses[i].x, houses[i].y, 25, height + houses[i].y);
  }

  for (int i = 0; i < nc; i++) {
    if (circles[i].x<=0)circles[i].set(mouseX, mouseY);
    else circles[i].set(circles[i].x-=i+1, circles[i].y);

    fill(255, 255, 35);
    strokeWeight(2);
    stroke(random(250, 255), random(0, 255), random(0, 255));
    triangle(mouseX, mouseY-20, mouseX, mouseY+20, mouseX+30, mouseY);
    noStroke();
    ellipseMode(CENTER);
    fill(colors[i].x, colors[i].y, colors[i].z);   
    ellipse(circles[i].x, circles[i].y, map(abs(mySound.mix.get(3)*80), 0, 40, 10, 60), 20);
  }



  if (!wait && keyPressed && key == 'z') {
    isShoot = true;
    laserxy.set(mouseX+30, mouseY);
    wait = true;
  }
  if (isShoot) {  
    fill(255, 255, 35);
    strokeWeight(2);
    stroke(244, 67, 54);
    ellipseMode(CENTER); 
    if (laserxy.x>width+30) {
      isShoot = false;
      wait = false;
    } else laserxy.set(laserxy.x+=speedLaser, laserxy.y);
    ellipse(laserxy.x, laserxy.y, 60, 10);
    //ellipse(lx, ly, 30, 10);
    println("bang!");
  }
  println(lx + " " + speedLaser);



  /**
   triangle((int)mountains[0].x, (int)mountains[0].y, 
   (int)mountains[0].x - (int)mountains[0].z, (int)mountains[0].y + (int)mountains[0].z, 
   (int)mountains[0].x + (int)mountains[0].z, (int)mountains[0].y + (int)mountains[0].z);
   */
  //triangle(100, 20, 100-30, 20+30, 100+30, 20+30);

  //println(((int)mountains[0].x + (int)mountains[0].z) + " " + ((int)mountains[0].y + (int)mountains[0].z));

  //println(mountains[0].x + " " + mountains[0].y + " " + mountains[0].z);

  //rect(10, 10, 10, 10);
}