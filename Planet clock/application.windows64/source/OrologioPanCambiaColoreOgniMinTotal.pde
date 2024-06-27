/** Orologio **/

int startTime = millis();
int currentTime = 0;
int checkSec = 0;
boolean inSec = true;

float fi = radians(90 - (6 * second())); 

float fip = 0;
float t = 1;

float currentSec;

float fim2, fih2;
float t2 = 1;
float t3 = 1;

int r = 255;
int g = 255;
int b = 255;

int rc = 225;
int gc = 228;
int bc = 15;

void setup() {
  size(600, 600);
  background(r, g, b);
}

void draw() {
  currentTime = millis() - startTime;
  background(r, g, b);

  fill(rc, gc, bc);
  //fill(mouseX, mouseY, (mouseX+mouseY)%250);
  ellipse(300, 300, 380, 380);

  if (inSec) {
    inSec = false;
    println("currenTime = " + currentTime/1000);
    checkSec = currentTime/1000;
    println("sec = " + checkSec);
    println(hour() + ":" + minute() + ":" + second());
    currentSec = second();

    if ( second() == 0) {
      r = int(random(255));
      g = int(random(255));
      b = int(random(255));

      rc = int(random(255));
      gc = int(random(255));
      bc = int(random(255));
    }
  }

  if (currentTime/1000 > checkSec) {
    inSec = true;
  }


  fi = radians(90 - (6 * second()));


  fill(255, 228, 15);
  ellipse(300+(200*cos(fi)), 300-(200*sin(fi)), 20, 20);

  strokeWeight(3);
  fill(231, 47, 39);
  fip = radians(90 - t);      
  ellipse((300+(200*cos(fi))+(40*cos(fip))), (300-(200*sin(fi))-(40*sin(fip))), 10, 10);
  t = t+6;

  strokeWeight(10);
  line(300, 300, 300+(200*cos(fi)), 300-(200*sin(fi)));

  float fim = radians(90 - (6 * minute()));
  fill(170, 198, 27);
  ellipse(300+(200*cos(fim)), 300-(200*sin(fim)), 30, 30);
  //rect(300,300,10,10);

  strokeWeight(5);
  fill(194, 222, 242);
  fim2 = radians(90 - t2);      
  ellipse((300+(200*cos(fim))+(40*cos(fim2))), (300-(200*sin(fim))-(40*sin(fim2))), 15, 15);
  t2 = t2+1.5;

  strokeWeight(14);
  line(300, 300, 300+(150*cos(fim)), 300-(150*sin(fim)));

  float fih = radians(90 - (30 * hour()));
  fill(46, 20, 141);
  ellipse(300+(200*cos(fih)), 300-(200*sin(fih)), 40, 40);

  strokeWeight(8);
  fill(255, 228, 15);
  fih2 = radians(90 - t3);      
  ellipse((300+(200*cos(fih))+(50*cos(fih2))), (300-(200*sin(fih))-(50*sin(fih2))), 20, 20);
  t3 = t3+0.3;

  strokeWeight(20);
  line(300, 300, 300+(100*cos(fih)), 300-(100*sin(fih)));

  fill(0, 102, 153);
}