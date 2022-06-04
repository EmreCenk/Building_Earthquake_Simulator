


class Line{

  Point p1, p2;
  float length_;
  PVector torque, force, velocity, center, angular_velocity;
  Line(Point p1, Point p2){
    this.p1 = p1;
    this.p2 = p2;
    
    this.length_ = dist(p1.position.x, p1.position.y, p2.position.x, p2.position.y);
    this.p1.line_length = this.length_;
    this.p2.line_length = this.length_;
    this.p1.pair = p2.position;
    this.p2.pair = p1.position;
    
    this.torque = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    this.angular_velocity = new PVector(0, 0);
  }
  
  void update_net_torque(){
    this.torque = new PVector(0, 0);
    this.torque.add(this.p1.torque);
    this.torque.add(this.p2.torque);
  }
  
  void update_net_force(){
    this.force = new PVector(0, 0);
    this.force.add(this.p1.force);
    this.force.add(this.p2.force);
  }
  
  void update_center(){
     this.center = new PVector((this.p1.position.x + this.p2.position.x)/2, (this.p1.position.y + this.p2.position.y)/2); 
  }
  void paint(){
    this.p1.paint();
    this.p2.paint();
    line(this.p1.position.x, this.p1.position.y, this.p2.position.x, this.p2.position.y);
  }
  
  void reset_forces(){
    this.p1.force = new PVector(0, 0);
    this.p2.force = new PVector(0, 0);
    
    this.p1.torque = new PVector(0, 0);
    this.p2.torque = new PVector(0, 0);
  }
  
  
  void update(){
    
    this.update_net_force();
    this.update_net_torque();
    this.update_center();
    
    //torque:
    float moment_of_inertia1 = (this.p1.m * this.p1.m * this.length_)/2;
    float moment_of_inertia2 = (this.p2.m * this.p2.m * this.length_)/2;
    PVector angular_acceleration = new PVector(this.torque.x, this.torque.y);
    angular_acceleration.mult(1/(moment_of_inertia1 + moment_of_inertia2));
    this.angular_velocity.add(angular_acceleration);
    
    p1.position = rotate_around_pivot(this.center, p1.position, this.angular_velocity.mag());
    p2.position = rotate_around_pivot(this.center, p2.position, this.angular_velocity.mag());
    
    // FIRST DO TORQUE (since translations changes center, you would need to update again)  
    //translations:
    PVector acceleration = this.force.mult(1/(this.p1.m + this.p2.m));
    this.velocity.add(acceleration);
    this.p1.position.add(this.velocity);
    this.p2.position.add(this.velocity);
    

    
    this.reset_forces();

  }
}
