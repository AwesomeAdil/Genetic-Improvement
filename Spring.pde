class Spring{
  float x, y;
  String name;
  Spring(){
    x = 200;
    y = 200;
  }
  
  Spring(float sx, float sy) {
    x = sx;
    y = sy;
  }
  
  void exist(){
    fill(255, 0, 0);
    circle(x, y, 50);  
  }
  
  void checkCollision(Player p){
    if(dist(x, y, p.x, p.y) <= 40) {
      p.vy = -16;
      p.standing = false;
    }
  }
}
