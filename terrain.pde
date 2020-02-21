ArrayList<PVector> arr;
int size = 20;
int rows, cols;
float ter[][];

float move = 1;

void setup() {
  size(800, 800, P3D);
  //colorMode(HSB, 200);
  colorMode(RGB, 200);
  noStroke();
  cols=1200/size;
  rows=1200/size;
  rows+=20;

  ter=new float[rows+1][cols+2];
  arr=new ArrayList<PVector>();
}

int mode=1;
void setArr() {
  move-=1.0/((float)size)*1.6;

  if (mode==1) {
    float yf=move;
    for (int i=0; i<=cols; i++) {
      float xf=0;
      for (int j=0; j<=rows; j++) {
        ter[j][i]=map(noise(xf, yf), 0, 1, -200, 170);
        xf+=0.1;
      }
      yf+=0.1;
    }
  } else if (mode==2) {
    float yf=move;
    for (int i=0; i<=cols; i++) {
      float xf=0;
      for (int j=0; j<=rows; j++) {
        ter[j][i]=map(noise(xf, yf), 0, 1, -250, 50);
        xf+=0.1;
      }
      yf+=0.1;
    }
  }
}

void keyPressed() {
  if (key=='1') mode=1;
  else if (key=='2') mode=2;
  else if (key=='a' || key=='A') fillFlag=!fillFlag;
  else if (key=='s' || key=='S') strokeMode=(strokeMode+1)%3;
  else if (keyCode==UP) zoomIn=true;
  else if (keyCode==DOWN) zoomOut=true;
  else if (keyCode==LEFT) moveLeft=true;
  else if (keyCode==RIGHT) moveRight=true;
}
void keyReleased() {
  if (keyCode==LEFT) moveLeft=false;
  else if (keyCode==RIGHT) moveRight=false;
  else if (keyCode==UP) zoomIn=false;
  else if (keyCode==DOWN) zoomOut=false;
}

boolean fillFlag=true, moveLeft=false, moveRight=false;
boolean zoomIn=false, zoomOut=false;
int strokeMode=0;
float scl=1;
int tx=0, ty=0;

void draw() {
  if (moveLeft) tx+=20;
  else if (moveRight) tx-=20;

  if (zoomIn) scl+=0.01;
  else if (zoomOut) scl-=0.01;

  translate(width/2, height/2);
  scale(scl);
  translate(-width/2, -height/2);
  translate(tx, ty);
  setArr();

  background(0, 0, 0);
  noFill();

  translate(300, 300, 0);
  rotateX(PI/3);
  translate(-700, -700);

  for (int i=0; i<2; i++) {
    for (int y=0; y<=cols; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x=0; x<=rows; x++) {
        color c = setColor(map(ter[x][y], -150, 150, 0, 300));
        if (strokeMode==0) noStroke();
        else if (strokeMode==1) stroke(0, 100);
        else if (strokeMode==2) stroke(255, 100);

        if (fillFlag) fill(c, 100); 
        else noFill();

        vertex(x*size, y*size, ter[x][y]);
        vertex(x*size, (y+1)*size, ter[x][y+1]);
      }
      endShape();
    }
  }

  showPanel();
}

color setColor(float h) {
  color c = color(0, 0, 0);
  if (h<20)
    c = color(0, 0, 200, 160);
  else if (h<50)
    c=color(0, 0, 200*(h/50));
  else if (h<100)
    c=color(0, 100*(h/100), 200*(h/100));
  else if (h<150)
    c=color(0, 200*(h/150), 50*(h/150));
  else if (h<180)
    c=color(0, 200*(h/180), 0);
  else if (h<230)
    c=color(150*(h/230), 170*(h/230), 150*(h/230));
  else if (h<300)
    c=color(150+100*(h/260), 150+100*(h/260), 150+100*(h/260));

  return c;
}

void showPanel() {
  pushMatrix();
  stroke(200);
  fill(200);
  strokeWeight(100);
  //ellipse(0, 0, 400, 400);
  popMatrix();
  println(mouseX, mouseY);
}
