

class EarthQuake{
  
  //todo: implement some sort of proper earthquake scale
  PVector force; // amount of force felt on ground (keeping as PVector in case I wanna experiment with vertical earthquakes)
  float tick, counter;
  EarthQuake(float force_magnitude){
    this.force = new PVector(force_magnitude, 0);
    this.tick = 0;
    this.counter = 0.01;
  }
  
  void shake(Building building){
    

    //ArrayList<Point> points = building.get_sorted_points();
    ArrayList<Point> support_points = building.get_support_points();

    //ArrayList<Point> sorted = building.get_sorted_points();
    HashMap<Float, Integer> sorted = get_first_occurence_of_each_y(building.get_sorted_points(), 5);
    //for (Point p: sorted){
    //  if !(s_
    //}
    
    float coef;
    Point p1, p2;
    building.distribute_gravitational_forces(); //todo: do this once in mainloop 
    building.reset_earthquake_forces();
    
    for (Point[] points: get_earthquake_traversal_order(building)){
      p1 = points[0];
      p2 = points[1];
      if (support_points.contains(p1))
        p1.earthquake_force = new PVector(this.force.x, this.force.y);
      //coef = 1.0/(1 + sorted.get(p1.position.y)) * sin(this.tick + PI/2) * 100;
      
      //TODO: FOLLOWING LINE'S "/(sorted.size() - sorted.indexOf(p1)" SECTION CAUSES ISSUES WHEN COUNTING NEIGHBOURS ABOVE
      coef = sin(this.tick + PI/2) * -sup_dist(p2, support_points)/(1 + sorted.get(p1.position.y));
      if (coef != 0){
        this.force.mult(coef);
        p2.earthquake_force.add(this.force);
        this.force.mult(1/coef);
      }
    }
    this.move_building(building);
    this.tick += 0.05;
    //if (this.tick % 20 == 0) this.force.mult(-1);
    //float w = 0.1;
    //if (this.tick > w || this.tick < -w) this.counter *= -1;
  }
  
  private void move_building(Building building){
    PVector acceleration;
    ArrayList<Point> sp = building.get_support_points();
    HashSet<Point> support_points = new HashSet<Point>();
    for (Point p: sp) support_points.add(p);
    
    for (Point p: building.graph.keySet()){
      if (support_points.contains(p)) continue;
      acceleration = new PVector(p.earthquake_force.x, p.earthquake_force.y);

      acceleration.mult(1/p.m);
      p.velocity.x = acceleration.x;
      //p.velocity.add(acceleration);
      p.position.add(p.velocity);
    }
  
  }
  
}
