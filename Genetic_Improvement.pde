PImage bground;
PImage trophy;

Population ninjas;
Fireball fireballs[]= new Fireball[4];
Spike spikes[] = new Spike[8];
Spring springs[] = new Spring[4];
Floor floors[] = new Floor[5];

void setup() {
  size(1000, 700);
  ninjas = new Population(50);
  startup();
  bground=loadImage("bground.jpg");
  bground.resize(width, height);
  trophy=loadImage("trophy.png");
  trophy.resize(50, 50);
  strokeWeight(3);
  fill(200, 200, 200);
  textSize(32);
  textAlign(CENTER);
                  
  //for(int i = 0; i<4; i++) fireballs[i] = new Fireball();
  for(int i = 0; i<4; i++){
    if(i%2==0) springs[i] = new Spring(width*0.9, height - height*0.2 * i - 30);
    else springs[i] = new Spring(width*0.1, height - height*0.2 * i - 30);
  }

  
  for(int i = 0; i<5; i++){ 
    if (i==0) floors[i] = new Floor(0, height-10, width, 10);
    else if(i%2 == 1) floors[i] = new Floor(0, height-height*0.2*(i), width*0.8, 10);
    else floors[i] = new Floor(width*0.2, height-height*0.2 * (i), width*0.8, 10);
  }
  
}


void draw() {
  background(bground);
  image(trophy, width-60,30);
  checkCollisions();  
  geneticAlgorithm();
  
}

void checkCollisions(){
  ninjas.update();
  for(Fireball f: fireballs){
    f.move();
    for(Player p : ninjas.players) f.checkCollision(p);
  }
  
  for(Spike s: spikes){
    s.exist();
    for(Player p : ninjas.players) s.checkCollision(p);
  }
  
  for(Spring s: springs){
    s.exist();
    for(Player p : ninjas.players) s.checkCollision(p);
  }
  
  for(Floor f: floors){
    f.exist();
    for(Player p : ninjas.players) f.checkStand(p);
  }
}


void startup(){
  spikes[0] = new Spike(width*0.35, height - 30, 30);
  spikes[1] = new Spike(width*0.73, height - 30, 30);
  spikes[2] = new Spike(width*0.25, height - 30, 30);
  spikes[3] = new Spike(width*0.25, height*0.8 - 10, 30);
  spikes[4] = new Spike(width*0.20, height*0.8 - 10, 30);
  spikes[5] = new Spike(width*0.40, height*0.6 - 10, 30);
  spikes[6] = new Spike(width*0.60, height*0.6 - 10, 30);
  spikes[7] = new Spike(width*0.50, height*0.8 - 10, 30);
  
  fireballs[0] = new Fireball(width-30, 390, -7, 0);
  fireballs[1] = new Fireball(30, 250, 7, 0);
  fireballs[2] = new Fireball(30, 190, 3, 0);
  fireballs[3] = new Fireball(30, 170, 5, 0);
  
  for(Player ninja: ninjas.players) ninja.reset(false);
}


void geneticAlgorithm(){
  if(ninjas.allFinished()){
    ninjas.calculateFitnesses();
    ninjas.naturalSelection();
    ninjas.mutateChildren();
    if(ninjas.gen % 5 == 0) ninjas.increaseMoves();
    startup();
  }
}
