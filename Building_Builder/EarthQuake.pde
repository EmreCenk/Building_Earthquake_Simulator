

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
    
    //PVector Torque = new PVector(0, 0);
    //PVector net_force = new PVector(0, 0);
    //PVector acceleration = new PVector(0, 0);
    //PVector new_point_2;
    
    //ArrayList<Point> points = building.get_sorted_points();
    ArrayList<Point> support_points = building.get_support_points();
    ArrayList<Point> sorted = building.get_sorted_points();
    IntList s_coord = new IntList();
    //for (Point p: sorted){
    //  if !(s_
    //}
    
    Point sup_point = support_points.get(0);
    float coef;
    Point p1, p2;
    building.distribute_gravitational_forces(); //todo: do this once in mainloop 
    building.reset_earthquake_forces();
    
    for (Point[] points: get_earthquake_traversal_order(building)){
      p1 = points[0];
      p2 = points[1];
      if (support_points.contains(p1))
        p1.earthquake_force = new PVector(this.force.x, this.force.y);
      //coef = 1.0/(sorted.size() - sorted.indexOf(p1)) * sin(this.tick) * 100;
      
      //TODO: FOLLOWING LINE'S "/(sorted.size() - sorted.indexOf(p1)" SECTION CAUSES ISSUES WHEN COUNTING NEIGHBOURS ABOVE
      coef = sin(this.tick + PI/2) * -dist(sup_point.position.x, sup_point.position.y, p2.position.x, p2.position.y)/(sorted.size() - sorted.indexOf(p1));
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
    //println(this.tick, sin(this.tick));
  }
  
  private void move_building(Building building){
    PVector acceleration;
    for (Point p: building.graph.keySet()){
      acceleration = new PVector(p.earthquake_force.x, p.earthquake_force.y);

      acceleration.mult(1/p.m);
      p.velocity.x = acceleration.x;
      //println(p.velocity);
      //p.velocity.add(acceleration);
      p.position.add(p.velocity);
    }
  
  }
  
}
