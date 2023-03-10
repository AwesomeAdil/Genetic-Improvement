class Floor{
  float x, y, wid, hei;
  Floor(){
    x = 100;
    y = 100;
    wid = 400;
    hei = 400;
  }
  
  Floor(float fx, float fy, float fwid, float fhei){
    x = fx;
    y = fy;
    wid = fwid;
    hei = fhei;
  }
  
  void exist(){
    fill(200, 200, 200);
    rect(x,y, wid, hei);
  }
  
  void checkStand(Player p){
     if((x<=p.x && p.x <= (x + wid)) && ((y-40) < p.y && p.y < (y-20)) && !p.standing) {
     p.stand();
     p.y = y - 40;
    
   }
  }
}
