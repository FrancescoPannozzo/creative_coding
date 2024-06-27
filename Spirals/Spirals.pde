import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer mySound;
FFT fftLin;

int nBall = 256;

Ball[] balls = new Ball[nBall];

//float max = 0;
//float max2 = 0;

void setup() {  
  size(600, 600, P3D);
  //background(255);

  for (int i=0; i < balls.length; i++) {
    balls[i] = new Ball();
  }

  minim = new Minim(this);
  mySound = minim.loadFile("test.mp3");
  mySound.play();
  fftLin = new FFT(mySound.bufferSize(), mySound.sampleRate());
  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  fftLin.linAverages( nBall );
  
}

void draw() {
  
  //background(0);
  
  //Effetto fade-out 
  fill(0, 100);
  rect(0, 0, width, height);
  
  if (keyPressed) {
    if (key == 'f') {
      mySound.skip(1500);
    } else if (key == 'r') {
      mySound.play(mySound.position()-10000);
    }
    println("key pressed");
  }

  fftLin.forward( mySound.mix );

  for (int i=0; i < balls.length; i++) {
    balls[i].move();
    balls[i].display(i);
  }
  

/*
  float temp = fftLin.getAvg(0);//map(fftLin.getAvg(0), 0, 1, 0, 1);
  if(temp>max)
    max = temp;
  //println(max);
  
  //println(map(fftLin.getAvg(0), 1, max, 1, 50));
  rect(100,100,map(fftLin.getAvg(0), 0, max, 1, 50),map(fftLin.getAvg(0), 0, max, 1, 50));

  int dx = width/nBall;
  for(int i=0; i < balls.length; i++){
    rect(i*dx, height-map(fftLin.getAvg(i), 1, max, 1, 100), dx, map(fftLin.getAvg(i), 1, max, 1, 100) );
  }
  
  float temp2 = fftLin.getAvg(19);//map(fftLin.getAvg(0), 0, 1, 0, 1);
  if(temp2>max2)
    max2 = temp2;
  //println(max2);
  
  rect(300,100,map(fftLin.getAvg(19), 0, max2, 1, 50),map(fftLin.getAvg(19), 0, max2, 1, 50));
  //println(map(fftLin.getAvg(19), 0, max2, 1, 50));
  */
}

// This is called on exit
void stop() {
  println("Shuting down");
  mySound.close();
  minim.stop();       // close minim
  super.stop();
}

class Ball {
  float xp;
  float yp;
  float w = random(4, 10);
  float h = w;
  float r;
  float g;
  float b;
  float fade;
  float caso;
  float boost;
  float baseSpeed;
  float speed;
  float fi = random(0, 4);
  float rfi = random(2, 8);
  float max = 0;
  float maxZero = 0;
  float temp = 0;

  boolean greenDirection = false;
  boolean redDirection = false;
  boolean blueDirection = false;

  Ball() {
    xp = random((width/2) - 10, (width/2)+10);//random((w/2), width-(w));
    yp = random(height);// random((w/2), height-(w/2));
    r = random(100, 255);//random(0, 200);
    g = random(100, 255);//random(0, 255);
    b = random(100, 255);
    fade = random(30, 255);
    baseSpeed = random(0.1, 4);
    boost = 0;//random(0.5, 1);
    speed = baseSpeed;
    caso = 10;//round(random(10,11));//round(random(1, 4));
    //System.out.println(caso);
  }

  void changeColor() {
    
    if (g >= 255) { //per bicolore solo un valore >=255 e <=0
      greenDirection = true;
    } else if (g <= 0) {
      greenDirection = false;
    }
    if (greenDirection) {
      g-=5;
    } else {
      g+=5;
    }
    
    
    if (r >= 250) {
      redDirection = true;
    } else if (r <= 50) {
      redDirection = false;
    }
    if (redDirection) {
      r-=3; //0.5
    } else {
      r+=3;
    }
    
    if (b >= 250) {
      blueDirection = true;
    } else if (b <= 50) {
      blueDirection = false;
    }
    if (blueDirection) {
      b-=2; //0.3
    } else {
      b+=2;
    }
   
  }

  void updateSpeed(float boosted) {
    speed = baseSpeed + boosted;
  }

  void display(int i) {

    //println(map(fftLin.getAvg(0), 0, 44, 10, 60));
    
    
    if (map(fftLin.getAvg(0), 0, 44, 10, 60)>60) {      
      //  rect(xp-20, yp-20, map(fftLin.getAvg(0), 0, 44, 10, 60), map(fftLin.getAvg(0), 0, 44, 10, 60));  
      changeColor();
    }
    
    // else
    
  temp = fftLin.getAvg(i);//map(fftLin.getAvg(0), 0, 1, 0, 1);
  if(temp>max)
    max = temp;
    
    noStroke();
    fill(r, g, b, map(fftLin.getAvg(0), 0, 44, 0, 250));//fill(r, g, b, map(fftLin.getAvg(0), 0, 44, 0, 250));
    
  //ellipse(xp, yp, w, w );
  
  if(i < nBall/4)
    ellipse(xp, yp, map(temp, 0, max, w, w+40), map(temp, 0, max, w, w+40) ); //10 80
  else
    ellipse(xp, yp, map(temp, 0, max, w, w+30), map(temp, 0, max, w, w+30) );// 4 60
  
    /*
    if(i < 6)
      ellipse(xp, yp, map(fftLin.getAvg(i), 0, max, 1, 100), map(fftLin.getAvg(i), 1, max, 1, 100));    
    else
      ellipse(xp, yp, map(fftLin.getAvg(i), 0, max, 1, 1000), map(fftLin.getAvg(i), 1, max, 1, 1000));
    */
    //stroke(r, g, b, map(fftLin.getAvg(0), 0, 44, 0, 44));
    //strokeWeight(10);
    //line(width/2, height/2, xp, yp);
    //line(width, 0, xp, yp);
    //line(0, width, xp, yp);
    //line(width, height, xp, yp);
    //ellipse(xp, yp, abs(mySound.mix.get(10)*60),abs(mySound.mix.get(10)*60));
    
    float showBoost;
    //if(i < nBall/4)
    //  showBoost = round(map(fftLin.getAvg(i), 0, max, 0, 14));
    //else
      showBoost = round(map(fftLin.getAvg(i), 0, max-(max/3), 0, 12)); 
    updateSpeed(showBoost/2);
    println(showBoost/2);
    //println(round(map(temp, 0, max, 1, 6)));//0.05 , 4 is perfect
    //println();
    //updateSpeed(abs(mySound.mix.get(0)*10));
    //println(map(fftLin.getAvg(0), 0, 88, 0.5, 4));
    //println(abs(mySound.mix.get(0)*10));
    //println(map(fftLin.getAvg(6), 0, 2, 10, 60));
  }

  void move() {
    fi+=rfi;
    
    if (caso == 10) {
      //w = random(4, 10);
      //r = 255;
      //g = 255;
      //b = 255;
      xp+=( cos(radians(fi)) * 8);      
      yp+=( sin(radians(fi)) * 2)+1;
      if (yp>height-(w/2)) yp = 0;//caso = 13;//caso = 3; yp = 0; per neve
      if (xp>width-(w/2)) caso = 4;
      if (xp<0) caso = 5;
    }
    if (caso == 11) {
      w = random(4, 10);
      r = 255; // 0
      g = 255;
      b = 255;
      xp+=( sin(radians(fi)) * 2);     
      yp+=speed; //con ( cos(radians(fi)) * 2) fa cerchio, anche + valore fa spirale
      if (yp>height-(w/2)) yp = 0;//caso = 12;//caso = 2;
      if (xp>width-(w/2)) caso = 4; 
      if(xp<0) caso = 5;
    }
    //------------- su
    if (caso == 13) {
      w = random(4, 5);
      yp-=speed;
      if (yp<0) caso = 10;//caso = 2;   
    }
    if (caso == 12) {
      w = random(4, 5);
      yp-=speed;
      if (yp<0) caso = 11;//caso = 2;   
    }
    //-------------
    if (caso == 2) {
      xp+=speed;      
      yp-=speed;
      if (yp<(w/2)) caso = 11;
      if (xp>width-(w/2)) caso = 3;
    }
    if (caso == 3) {
      xp-=speed;     
      yp-=speed;
      if (yp<(w/2)) caso = 10;
      if (xp<(w/2)) caso = 2;
    }
    if (caso == 4) {
      xp-=speed;      
      yp+=speed;
      if (yp>height-(w/2)) caso = 3;//caso = 3;
      if (xp<(w/2)) caso = 5;
    }
    
     if (caso == 5) {
      xp+=speed;
     
      yp+=speed;
      if (yp>height-(w/2)) caso = 2;//caso = 3;
      if (xp<(w/2)) caso = 11;
    }
  }
}
