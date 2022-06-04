


class Line{

  Point p1, p2;
  float length_;
  PVector torque, force;
  Line(Point p1, Point p2){
    this.p1 = p1;
    this.p2 = p2;
    this.length_ = dist(p1.position.x, p1.position.y, p2.position.x, p2.position.y);
    this.torque = new PVector(0, 0);
  }
  
  void get_net_torque(){
    this.torque = new PVector(0, 0);
    this.torque.add(this.p1.torque);
    this.torque.add(this.p2.torque);
  }
  
  void get_net_force(){
    this.force = new PVector(0, 0);
    this.force.add(this.p1.force);
    this.force.add(this.p2.force);
  }
  
  void paint(){
    this.p1.paint();
    this.p2.paint();
    line(this.p1.position.x, this.p1.position.y, this.p2.position.x, this.p2.position.y);
  }
}
