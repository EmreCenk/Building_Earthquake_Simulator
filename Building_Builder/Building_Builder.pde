


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
}
