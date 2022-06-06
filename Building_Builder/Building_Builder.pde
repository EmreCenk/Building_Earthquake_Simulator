


Point p1, p2, p3, p4, p5, p6;
Building kk;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(150, 350));
  p3 = new Point(new PVector(50, 350));
  p4 = new Point(new PVector(123, 400));
  p5 = new Point(new PVector(200, 100));
  p6 = new Point(new PVector(400, 300));
  
  //p1.apply_force(new PVector(25, 10));
  frameRate(10);
  noLoop();
  kk = new Building();
  //kk.add_line(new Line(p1, p2));
  //kk.add_line(new Line(p2, p3));
  //kk.add_line(new Line(p1, p3));
  //kk.add_line(new Line(p3, p4));
  //kk.add_line(new Line(p4, p5));
  //kk.add_line(new Line(p5, p6));

  //kk.add_line(new Line(p1, p3));
  //kk.add_line(new Line(p1, p6));
  //kk.add_line(new Line(p4, p6));
  
  Point[] w = {p1, p2, p3, p4, p5, p6};
  for (int i = 0; i < w.length - 1; i++){
    for (int j = i + 1; j < w.length; j++){
      kk.add_line(new Line(w[i], w[j]));
    }
  } 
  
  //kk.print_graph();

}




void draw(){
  background(255);
  kk.update();
  kk.paint();
  kk.draw_forces();
  
  fill(0);
  stroke(0);
  kk.draw_center_of_mass();

  float average = 0;
  
  for (Point name: kk.graph.keySet()) {
    average += name.force.mag();
  }
  println(average);
  

  
}

void keyPressed(){
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 's'){
    p2.apply_force(new PVector(0, 10000));
    println("yes");
  }
}
