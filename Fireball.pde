class Fireball{
  float x, y, vx, vy;
  Fireball(){
    x = width;
    y = 0;
    vx = -3;
    vy = 0;
  }
  Fireball(float fx, float fy, float fvx, float fvy){
    x = fx;
    y = fy;
    vx = fvx;
    vy = fvy;
  }

  void move() {
    x+=vx;
    y+=vy;
    fill(247, 134, 15);
    circle(x, y, 30);
    if(x>width+20) x-=width;
    else if(x<-20) x+=width;
    if(y>height+20) y-=height;
    else if(y<-20) y+=height;
  }
  
  void checkCollision(Player p){
    if(dist(x, y, p.x, p.y) <= 35) p.reset(true);
  }
}
