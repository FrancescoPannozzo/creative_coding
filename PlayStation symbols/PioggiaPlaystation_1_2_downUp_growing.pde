Square[] fiocchi = new Square[150];

void setup() {
  size(400, 400, P2D);
  //frameRate(30);
  //background(41, 182, 246);

  for (int i=0; i<fiocchi.length; i++) {  
    fiocchi[i] = new Square((random(5, 10)));    
    //fiocchi[i].setFill(color(255, 255, 255, (int)(random(10, 255))));
    fiocchi[i].setXY((random(10, width)), (random(10, height)) );
    fiocchi[i].setSpeed(random(1, 3));
  }

  for (int i=0; i<fiocchi.length; i++) {
    println(fiocchi[i].getSpeed());
  }

  shapeMode(CENTER);
}

void draw() {  
  background(41, 182, 246);
  //fill(41, 182, 246, 50);
  //rect(0, 0, width, height);

  for (int i=0; i<fiocchi.length; i++) {
    if (i%2 == 0)
      fiocchi[i].move();
    else
      fiocchi[i].move2();

    fiocchi[i].display();

    if (fiocchi[i].getY() < -20) 
      fiocchi[i].setXY((random(width)), height+20);
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
    //s.setFill(color((int)(random(10, 255)), (int)(random(10, 255)), (int)(random(10, 255)), (int)(random(10, 255))));
    s.setFill(color(255, 255, 255, (int)(random(40, 255))));
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }

  float getSpeed() {
    return speed;
  }

  void setFill(int r, int g, int b, int str) {
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
    x+=( cos(radians(fi)) * 0.5);
    fi+=1%360;
  }

  void move2() {
    y-=speed;
    x-=( cos(radians(fi)) * 0.5);
    fi+=1%360;
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
    shape(s, x, y, ltemp, ltemp); //mySound.right.get(1)*50 - map(mySound.mix.get(1), -1, 1, 10, 80
    if(y < -20){ltemp = l;}
    ltemp+=0.12;
  }
}