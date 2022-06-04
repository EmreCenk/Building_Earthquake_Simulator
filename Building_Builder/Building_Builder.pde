


Point p1, p2;
Line l;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(100, 300));
  l = new Line(p1, p2);
  
}




void draw(){
  background(255);
  l.paint();
}
