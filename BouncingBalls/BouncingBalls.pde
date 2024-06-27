import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer mySound;
FFT fftLin;

int nBall = 60;

Ball[] balls = new Ball[nBall];

void setup() {  
  size(600, 600);
  //background(255);

  for (int i=0; i < balls.length; i++) {
    balls[i] = new Ball();
  }

  minim = new Minim(this);
  mySound = minim.loadFile("germanyToGermany.mp3");
  mySound.play();
  fftLin = new FFT(mySound.bufferSize(), mySound.sampleRate());
  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  fftLin.linAverages( 30 );
}

void draw() {
  if (keyPressed) {
    if (key == 'f') {
      mySound.skip(1500);
    } else if (key == 'r') {
      mySound.play(mySound.position()-5000);
    }
    println("key pressed");
  }

  //background(0);
  //Effetto fade-out 
  fill(0, 20);
  rect(0, 0, width, height);

  fftLin.forward( mySound.mix );

  for (int i=0; i < balls.length; i++) {
    balls[i].move();
    balls[i].display();
  }

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
  float w = random(10, 60);
  float h = w;
  float r;
  float g;
  float b;
  float fade;
  float caso;
  float change;

  Ball() {
    xp = random((w/2), width-(w/2));
    yp = random((w/2), height-(w/2));
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    fade = random(30, 255);
    change = random(0.5, 1);
    caso = round(random(1, 4));
    //System.out.println(caso);
  }

  void updateSpeed(float change) {
    this.change = change;
  }

  void display() {
    noStroke();
    fill(r, g, b, fade);
    ellipse(xp, yp, map(fftLin.getAvg(0), 0, 44, 10, 60), map(fftLin.getAvg(0), 0, 44, 10, 60));    
    //ellipse(xp, yp, abs(mySound.mix.get(10)*60),abs(mySound.mix.get(10)*60));
    updateSpeed(map(fftLin.getAvg(0), 0, 44, 0.05, 4));//0.05 , 4 is perfect
    //println(abs(mySound.mix.get(10)*100));
  }

  void move() {
    if (caso == 1) {
      xp+=change;
      yp+=change;
      if (yp>height-(w/2)) caso = 2;
      if (xp>width-(w/2)) caso = 4;
    }
    if (caso == 2) {
      xp+=change;
      yp-=change;
      if (yp<(w/2)) caso = 1;
      if (xp>width-(w/2)) caso = 3;
    }
    if (caso == 3) {
      xp-=change;
      yp-=change;
      if (yp<(w/2)) caso = 4;
      if (xp<(w/2)) caso = 2;
    }
    if (caso == 4) {
      xp-=change;
      yp+=change;
      if (yp>height-(w/2)) caso = 3;
      if (xp<(w/2)) caso = 1;
    }
  }
}