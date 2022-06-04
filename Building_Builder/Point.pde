

class Point{
  
  float m, radius;
  PVector position, force, torque;
  //force is for displacement (translation/shifting)
  //torque is used to calculate rotation
  
  Point(float m, PVector position){
    this.m = m;
    this.position = position;
    
    this.radius = 25;
    this.force = new PVector(0, 0);
    this.torque = new PVector(0, 0);  
  }
  
  void apply_force(PVector f){
    this.force.add(f);
  }
  

}
