

float DEFAULT_MASS = 10;
float DEFAULT_RADIUS = 25;

class Point{
  
  float m, radius, line_length;
  PVector position, force, torque;
  //force is for displacement (translation/shifting)
  //torque is used to calculate rotation
  
  Point(PVector position){
    this.position = position;
    
    this.radius = DEFAULT_RADIUS;
    this.m = DEFAULT_MASS;

    this.force = new PVector(0, 0);
    this.torque = new PVector(0, 0);
    
    this.line_length = 0; // if this point is a part of a line, then this length symbolizes the length of that line
  }
  
  void apply_force(PVector f){
    this.force.add(f);
    this.torque.add(new PVector(f.x * this.line_length/2, f.y * this.line_length/2));

  }
  
  void paint(){
    circle(this.position.x, this.position.y, this.radius);
  }

}
