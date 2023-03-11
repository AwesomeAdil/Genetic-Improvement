class Brain{
  static final float mutation_rate = 0.1;
  int numsteps;
  ArrayList<Integer> steps;
  int step = 0;
  Brain(int size){
    numsteps = size;
    steps = new ArrayList<Integer>();
  }
  
  void randomize(int size){
    for(int i = 0; i < size; i++) steps.add(getRandDir()); 
  }

  int getRandDir(){
    int rand = floor(random(4));
    return rand;
  }
  
  Brain clone(){
    Brain clone = new Brain(numsteps);
    for(int i = 0; i < numsteps; i++) clone.steps.add(steps.get(i));
    return clone;
  }
  
  void mutate(boolean died, int deathStep){
    float delta = 1;
    if(!died) delta = 1.5;
    for(int i=0; i < numsteps; i++){
       float mutation_chance = random(delta);

       // increases chance of mutation significantly if died here
       if(died && i > deathStep - 5) mutation_chance = random(delta * 0.2);
       
       //mutate
       if(mutation_chance < mutation_rate) steps.set(i, getRandDir());
    }
  }
  
  Brain breed(Brain other, int alter){
    Brain offspring = new Brain(numsteps);
    for(int i=0; i < numsteps; i++){
      if(i % 2 == alter) offspring.steps.add(steps.get(i));
      else  offspring.steps.add(other.steps.get(i));
    }
    return offspring;
  }
  
  void addMoves(int addition){
    numsteps += addition;
    for(int i = 0; i < addition; i++) steps.add(getRandDir());
  }
}
