

class EarthQuake{
  
  //todo: implement some sort of proper earthquake scale
  PVector force; // amount of force felt on ground (keeping as PVector in case I wanna experiment with vertical earthquakes)
  EarthQuake(float force_magnitude){
    this.force = new PVector(force_magnitude, 0);
    
  }
  
  void shake(Building building){
    
    //PVector Torque = new PVector(0, 0);
    //PVector net_force = new PVector(0, 0);
    //PVector acceleration = new PVector(0, 0);
    //PVector new_point_2;
    
    //ArrayList<Point> points = building.get_sorted_points();
    ArrayList<Point> support_points = building.get_support_points();
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
      coef = 1.0/building.graph.get(p1).size();

      //coef = dist(sup_point.position.x, sup_point.position.y, p2.position.x, p2.position.y)/building.graph.get(p1).size();
      if (coef != 0){
        this.force.mult(coef);
        p2.earthquake_force.add(this.force);
        this.force.mult(1/coef);
      }
    }
  }
  
}
