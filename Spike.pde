class Spike{
  float x, y, s;
  
  Spike() {
    x=100;
    y=120;
    s=30;
  }
  
  Spike(float sx, float sy, float ss) {
    x=sx;
    y=sy;
    s=ss;
  }


void exist(){
  triangle(x, y, s);
}



void triangle(float x, float y, float s) {
  fill(200, 200, 200);
  beginShape();
  vertex(x, y-s);
  vertex(x+s*sqrt(3)/2, y+s*.5);
  vertex(x-s*sqrt(3)/2, y+s*.5);
  endShape(CLOSE);
}
  
  
  void checkCollision(Player p){
    if(dist(x, y, p.x-7, p.y+5) <= s) p.reset(true);
  }
}
