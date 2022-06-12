

class Earthquake{
  
  //todo: implement some sort of proper earthquake scale
  PVector force; // amount of force felt on ground (keeping as PVector in case I wanna experiment with vertical earthquakes)
  Earthquake(float force_magnitude){
    this.force = new PVector(force_magnitude, 0);
    
  }
  
  void shake(Building building){
    
    PVector Torque = new PVector(0, 0);
    PVector net_force = new PVector(0, 0);
    PVector acceleration = new PVector(0, 0);
    PVector new_point_2;
    
    ArrayList<Point> points = building.get_sorted_points();
    PVector support_point = building.get_support_points().get(0).position;
    
    building.distribute_gravitational_forces(); //todo: do this once in mainloop 
    
    for (int i = points.size() - 1; i >= 0; i--){
      // finding net force:
      Torque.x = this.force.x * dist(points.get(i).position.x,
                                     points.get(i).position.y,
                                     support_point.x,
                                     support_point.y);
                                     
      net_force.x = points.get(i).force.x;
      net_force.y = points.get(i).force.y;
      net_force.add(Torque);
      
      //finding acceleration and new velocity:
      acceleration.x = net_force.x;
      acceleration.y = net_force.y;
      acceleration.mult(1/points.get(i).m);
      points.get(i).velocity.add(acceleration);
      
      
    }
  }

}
