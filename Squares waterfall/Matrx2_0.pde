//int x = 100;
//int y = 100;
//int str = 255;

Scia[] scie = new Scia[200];

void setup(){
  size(400, 400);
  //frameRate(30);
  background(0);
  for(int i=0; i<scie.length; i++)  
    scie[i] = new Scia();
  //x = 100;
  //str = 255;
}

void draw(){  
  background(0);
  for(int i=0; i<scie.length; i++)
    scie[i].display();
    
  for(int i=0; i<scie.length; i++){
    if(scie[i].getY() > height+100){
      scie[i] = new Scia();
    }
  }
  
}

class Square{
  int x;
  int y;
  int l;
  int r, g, b, str;
  int speed;
  
  Square(int l){
    this.l = l;
  }
  
  void setSpeed(int speed){
    this.speed = speed;
  }
  
  void setFill(int r, int g, int b, int str){
    this.r = r;
    this.g = g;
    this.b = b;
    this.str = str;
  }
  
  void setXY(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void move(){
    y+=this.speed;
  }
  
  void move(int speed){
    y+=speed;
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void display(){
    noStroke();
    fill(r, g, b, str);
    rect(x,y,l,l);
  }
}

class Scia{
  Square[] squares = new Square[20];
  int x = (int)random(width);
  int y = 0;
  int str = 255;
  int speed = 0;

  Scia(){
    speed = (int)random(3, 8);
    for(int i=0; i < squares.length; i++) {
      squares[i] = new Square((int(random(20))));
      y-=20;
      squares[i].setXY(x, y);      
      squares[i].setFill(255, 0, 255, str);
      //Verde
      //squares[i].setFill(140, 195, 110, str);
      squares[i].setSpeed(speed);
      str = str - 30;
      //println(str);
    }
  }
  
  int getX(){
    return squares[0].getX();
  }
  
  int getY(){
    return squares[0].getY();
  }
  
  void display(){
    for(int i=0; i < squares.length; i++) {
      // scia continua
      //squares[i].move();
      //Scia disordinata
      squares[i].move(speed);
      squares[i].display();
    }
  }
}