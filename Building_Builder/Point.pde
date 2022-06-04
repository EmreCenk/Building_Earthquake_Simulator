

float DEFAULT_MASS = 10;
float DEFAULT_RADIUS = 25;

class Point{
  
  float m, radius;
  PVector position, force, torque;
  //force is for displacement (translation/shifting)
  //torque is used to calculate rotation
  
  Point(PVector position){
    this.position = position;
    
    this.radius = DEFAULT_RADIUS;
    this.m = DEFAULT_MASS;

    this.force = new PVector(0, 0);
    this.torque = new PVector(0, 0);  
  }
  
  void apply_force(PVector f){
    this.force.add(f);
  }
  
  void paint(){
    circle(this.position.x, this.position.y, this.radius);
  }

}
