class Population{
   int popsize;
   ArrayList<Player> players;
   int bestPlayer;
   int minStep;
   float bestFitness;
   float sumFitness;
   int gen;
   boolean found;
  Population(int size){
    popsize = size;
    players = new ArrayList<Player>();
    bestPlayer = 0;
    minStep = 100000;
    bestFitness = 0;
    sumFitness = 0;
    gen = 1;
    found = false;
    for(int i = 0; i < size; i++) players.add(new Player(false, false)); 
  }

  void calculateFitnesses(){
    for(Player p: players) p.calculateFitness();
  }
  
  void naturalSelection(){
    ArrayList<Player> new_generation = new ArrayList<Player>();
    setBestPlayer();
    fitnessSum();
    new_generation.add(players.get(bestPlayer).make_child());
    for(int i = 1; i < popsize; i++){
      Player parent = selectParent();
      new_generation.add(parent.make_child());
    }
    gen+=1;
    players = new_generation;
  }
  
  Player selectParent(){
    float rand = random(sumFitness);
    float runningSum = 0;
    for(Player p : players){
      runningSum += p.fitness;
      if(runningSum > rand) return p;
    }
    return null;
  }
  
  void mutateChildren(){
    for(int i = 1; i < players.size(); i++){
      if(players.get(i).died) players.get(i).brain.mutate(players.get(i).curstep);
      else players.get(i).brain.mutate(-1);
      players.get(i).died = false;
      players.get(i).finished = false;
    }
    players.get(0).died = false;
    players.get(0).finished = false;
    players.get(0).show = true;
  }
  
  void setBestPlayer(){
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < players.size(); i++){
      Player p = players.get(i);
      if(p.fitness > max){
        max = p.fitness;
        maxIndex = i;
      }
    }
    bestPlayer = maxIndex;
    
    if (max > bestFitness){
      bestFitness = max;
      Player topG = players.get(bestPlayer).make_child();
      topG.show = true;
      topG.best = true;
      players.add(topG);
    }
    
    if(players.get(bestPlayer).win){
      minStep = players.get(bestPlayer).curstep;
      found = true;
    }
    players.get(bestPlayer).show = true;
  }
  
  void update(){
    for(Player p: players){
     // if(p.brain.step > minStep) p.died = true;
       p.decide();
    }
  }
  
  void fitnessSum(){
    sumFitness = 0;
    for(Player p: players) sumFitness += p.fitness;
  }
  
  void increaseMoves(){
    if(players.get(0).brain.steps.size() < 10000 && !found){
      for(Player p : players) p.brain.addMoves(10);
    }
  }
  
  boolean allFinished(){
    for(Player p : players){
      if(!p.finished) return false;
    }
    return true;
  }

} 
