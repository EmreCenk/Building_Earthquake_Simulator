


Point p1, p2, p3, p4, p5, p6;
Building kk, kk1;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(223, 540));
  p2 = new Point(new PVector(265, 230));
  p3 = new Point(new PVector(150, 350));
  p4 = new Point(new PVector(423, 420));
  p5 = new Point(new PVector(350, 573));
  p6 = new Point(new PVector(500, 300));
  
  //p1.apply_force(new PVector(25, 10));
  frameRate(75);
  //noLoop();
  kk = new Building();
  kk1 = new Building();
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
  
  Point p1copy = new Point(p1.position);
  Point p2copy = new Point(p2.position);
  Point p3copy = new Point(p3.position);
  
  kk1.add_line(new Line(p1copy, p2copy));
  kk1.add_line(new Line(p2copy, p3copy));
  kk1.add_line(new Line(p1copy, p3copy));


  //kk.print_graph();

}




void draw(){
  background(255);
  //kk.update();
  //kk.check_and_tip();
  //kk.paint();
  //kk.draw_forces();
  
  kk1.update();
  kk1.check_and_tip();
  kk1.paint();
  kk1.draw_forces();
  fill(0);
  stroke(0);
  kk.draw_center_of_mass();
  fill(255);

  
  //float average = 0;
  
  //for (Point name: kk.graph.keySet()) {
  //  average += name.force.mag();
  //}
  //println(average);
  noLoop();

  
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
