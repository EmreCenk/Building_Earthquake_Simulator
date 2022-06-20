

float DEFAULT_MASS = 10;
float DEFAULT_RADIUS = 25;

class Point{
  
  float m, radius, line_length;
  PVector position, force, torque, pair, velocity, earthquake_force;
  color colour, outline_colour;
  //force is for displacement (translation/shifting)
  //torque is used to calculate rotation
  
  Point(PVector position){
    this.position = position;
    
    this.radius = DEFAULT_RADIUS;
    this.m = DEFAULT_MASS;

    this.force = new PVector(0, 0);
    this.earthquake_force = new PVector(0, 0);
    this.torque = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    
    this.line_length = 0; // if this point is a part of a line, then this length symbolizes the length of that line
    this.pair = new PVector(0, 0);
    this.colour = color(255, 255, 255);
    this.outline_colour = color(0, 0, 0);
  }
  
  void apply_force(PVector f){
    
    //todo: below looks potentially risky
    this.pair.sub(this.position);
    PVector torque_f = project(f, this.pair);
    this.pair.add(this.position);
    this.torque.add(new PVector(torque_f.x * this.line_length/2, torque_f.y * this.line_length/2));
  
    this.force.add(f);
  
  }
  
  void paint(){
    fill(this.colour);
    stroke(this.outline_colour);
    circle(this.position.x, this.position.y, this.radius);
  }
}
