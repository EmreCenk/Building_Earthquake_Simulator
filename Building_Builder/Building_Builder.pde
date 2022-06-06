


Point p1, p2, p3, p4, p5, p6;
Building kk;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(200, 300));
  p3 = new Point(new PVector(50, 350));
  p4 = new Point(new PVector(123, 400));
  p5 = new Point(new PVector(200, 100));
  p6 = new Point(new PVector(400, 300));
  
  //p1.apply_force(new PVector(25, 10));
  frameRate(10);
  
  kk = new Building();
  kk.add_line(new Line(p1, p2));
  kk.add_line(new Line(p2, p3));
  kk.add_line(new Line(p3, p4));
  kk.add_line(new Line(p4, p5));
  kk.add_line(new Line(p5, p6));

  kk.print_graph();

}




void draw(){
  background(255);
  kk.update();
  kk.paint();

  kk.draw_forces();

  //draw_vector(p1.position, new PVector(25, 10));
  //draw_vector(p2.position, new PVector(50, 0));


  
}

void keyPressed(){
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 's'){
    p2.apply_force(new PVector(50, 0));
    println("yes");
  }
  //noLoop();
}
