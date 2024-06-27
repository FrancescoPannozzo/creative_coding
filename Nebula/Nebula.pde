int n = 1000;
Square[] fiocchi = new Square[n];

float alpha;

void setup() {
  size(400, 400, P2D);
  //fullScreen();
  //frameRate(40);
  //background(41, 182, 246);

  for (int i=0; i<n; i++) {  
    fiocchi[i] = new Square((int)(random(1, 5)));    
    //fiocchi[i].setFill(color(255, 255, 255, (int)(random(10, 255))));
    //fiocchi[i].setXY((random(width/4, width/3)), height+20 );
    fiocchi[i].setSpeed(random(1, 2));
    if (i >= 0 && i <= n/3 ) {
      fiocchi[i].setColor((int)(random(190, 240)), (int)(random(20, 100)), (int)(random(90, 150)), 255);
      fiocchi[i].setXY((random(width/5, width/3)), random(0, height+10) );
    }
    if (i >= n/3 && i <= (n/3 * 2) ) {
      fiocchi[i].setColor((int)(random(50, 120)), (int)(random(60, 130)), (int)(random(150, 200)), 255);
      fiocchi[i].setXY((random(width/4, width/2)), random(0, height+10) );
    }
    if (i >= (n/3 * 2) && i < n ) {
      fiocchi[i].setColor((int)(random(250, 255)), (int)(random(160, 235)), (int)(random(30, 60)), 255);
      fiocchi[i].setXY((random(width/2 - width/10, width/2)), random(0, height+10) );
    }
  }

  shapeMode(CENTER);

  alpha = 0;
  
}

void draw() {  
  blendMode(ADD);
  //background(41, 182, 246);
  background(0);
  //fill(0, 0, 0, 20);
  //fill(41, 182, 246, 50);
  //rect(-10, -10, width+20, height+20);


  for (int i=0; i<n; i++) {
    fiocchi[i].move();
    fiocchi[i].display();
    if (fiocchi[i].getY() < -20) { 
      //  fiocchi[i].setXY((random(width/4, width/3)), height+20 );
      if (i >= 0 && i <= n/3 ) {

        fiocchi[i].setXY((random(width/5, width/3)), random(height, height+10) );
      }
      if (i >= n/3 && i <= (n/3 * 2) ) {

        fiocchi[i].setXY((random(width/4, width/2)), random(height, height+10) );
      }
      if (i >= (n/3 * 2) && i < n ) {

        fiocchi[i].setXY((random(width/2 - width/10, width/2)), random(height, height+10) );
      }
    }
  }
}

class Square {
  float x;
  float y;
  float l, ltemp;
  int r, g, b, str;
  float speed;
  int fi = 0;
  PShape s;
  float raggio = 0;

  Square(float l) {
    this.l = l;
    ltemp = l;
    int i = (int)random(0, 4);
    switch(i) {
    case 0:
      s = loadShape("circle.svg");
      break;
    case 1:
      s = loadShape("square.svg");
      break;
    case 2:
      s = loadShape("triangle.svg");
      break;
    case 3:
      s = loadShape("x.svg");
      break;
    }
    r = (int)(random(10, 255));
    g = (int)(random(10, 255));
    b = (int)(random(10, 255));
    s.setFill(color((int)(random(10, 255)), (int)(random(10, 255)), (int)(random(10, 255)), (int)(random(10, 255))));
    //s.setFill(color(255, 255, 255, (int)(random(10, 255))));
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }

  float getSpeed() {
    return speed;
  }

  void setColor(int r, int g, int b, int str) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.str = str;
  }

  void setXY(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void move() {
    y-=speed;
    if (!(keyPressed && key == 's'))
      x-=( cos(radians(fi)) * map(y, height, 0, 1, 2.5));
    if ((keyPressed && key == 'd')){
      x++;
    }
    fi-=1%360;
    if (y<-20)fi=0;
  }

  void move2() {
    y-=speed;
    x-=( cos(radians(fi)) * 1);
    fi+=1%360;
    if (y<-20)fi=0;
  }

  void move(int speed) {
    y+=speed;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  void display() {
    //shape(s, x, y, map(mySound.mix.get(0), 0, 1, 20, 80), map(mySound.mix.get(1), 0, 1, 20, 80)); //mySound.right.get(1)*50 - map(mySound.mix.get(1), -1, 1, 10, 80
    //shape(s, x, y, ltemp, ltemp); //mySound.right.get(1)*50 - map(mySound.mix.get(1), -1, 1, 10, 80
    strokeWeight(ltemp);
    stroke(r, g, b);
    point(x, y);
    if (y < -10) {
      ltemp = l;
    }
    ltemp+=0.04;
    
  }
}