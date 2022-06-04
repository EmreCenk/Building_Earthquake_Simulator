


Point p1, p2;
Line l;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(100, 300));
  l = new Line(p1, p2);
  p1.apply_force(new PVector(25, 10));
  frameRate(75);
}




void draw(){
  background(255);
  l.update();
  l.paint();
  
  draw_vector(p1.position, new PVector(25, 10));
  
  l.angular_velocity.mult(1000);
  println(l.angular_velocity);
  stroke(color(255, 0, 0));
  draw_vector(p1.position, l.angular_velocity);
  l.angular_velocity.mult(0.001);
  stroke(0);
}

void keyPressed(){
  redraw();
  p1.apply_force(new PVector(25, 10));
  noLoop();
}
