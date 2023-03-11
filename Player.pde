class Player{
  float x, y, vx, vy;
  PImage sprite;
  boolean standing, win;
  boolean first, second;
  boolean human, died, finished;
  Brain brain;
  int curstep = 0;
  float fitness = 0;
  boolean right = true;
  boolean show = true;
  boolean best = false;
  float maxX = 0;
  Player(boolean isPlaying, boolean showBest){
    x=30;
    y=height-100;
    vx=0;
    vy=0;
    sprite = loadImage("player.png");
    sprite.resize(80,80);
    standing = false;
    win = false;
    human = isPlaying;
    brain = new Brain(20);
    brain.randomize(20);
    died = false;
    finished = false;
    show = showBest;
  }
  
  void reset(boolean death){
    if(human || !death){
      x = 30;
      y = height-100;
      vx = 0;
      vy = 0;
      standing = false;
    }else if(!finished){
      
      died = true;
    }
  }
 
  void decide(){
    if(curstep < brain.numsteps && !died && !win){
      int action = brain.steps.get(curstep);
      if(action == 0) stop();
      else if(action == 1) right();
      else if(action == 2) left();
      else if(action == 3) jump();
      curstep++;
      move();
    }else{
      finished = true;
    }
  }
 
  void move() {
    if (!win){
      x+=vx;
      y+=vy;
      maxX = max(x, maxX);
      sprite.resize(80,80);
      if(!best) fill(255, 0,0);
      else fill(0,255,0);
      if(show) image(sprite, x-40, y-40);
      else rect(x-40, y-40, 40, 80);
      if(dist(x-7,y+5,width-60,30)<=90) win=true;
      grav();
      if (x < 0 || x > width || y < 0 || y > height) reset(true);
    }
  }
  
  void grav() {
    if(!standing) vy+=1;
  }
  
  void stand(){
    if(!standing){
      first = true;
      second = true;
      standing = true;
      vy = 0;
      if(show || best){
       if(right) sprite = loadImage("player.png");
       else sprite = loadImage("playerleft.png");
      }
    }
      
  }
  
  void jump(){
    if(show || best){
      if(right) sprite = loadImage("jump.png");
      else sprite = loadImage("jumpleft.png");
    }
    
    if(standing && first){
      vy= -8;
      standing = false;
      first = false;
    }else if(second){
      vy= -6;
      standing = false;
      second = false;
    }
  }
  
  void right(){
    if(!right && (show || best)){
      if(!standing) sprite = loadImage("jump.png");
      else sprite = loadImage("player.png");
    }
    right = true;
    vx = 7;
  }
  
  void left(){
    if(right && (show || best)){
      if(!standing) sprite = loadImage("jumpleft.png");
      else sprite = loadImage("playerleft.png");
    }
    right = false;
    vx = -7;
  }
  
  void stop(){
    vx = 0;
  }
  
  Player make_child(boolean show){
    Player child = new Player(false, show);
    child.brain = brain.clone();
    child.died = died;
    return child;
  }
  
  
  // NEED TO STOP PROCRASTINATING ON THIS .... soon
  void calculateFitness() {
    fitness = maxX;
    if(died) fitness *= 0.9;
    fitness *= fitness * fitness;
  }
  
  
  
}
