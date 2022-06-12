 //<>//


Point p1, p2, p3, p4, p5, p6, p1copy, p2copy, p3copy;
Building kk, kk1;
void setup() {
  strokeWeight(2);

  size(800, 800);
  p1 = new Point(new PVector(323, 540));
  p2 = new Point(new PVector(365, 230));
  p3 = new Point(new PVector(250, 350));
  p4 = new Point(new PVector(523, 420));
  p5 = new Point(new PVector(450, 573));
  p6 = new Point(new PVector(600, 300));

  //p1.apply_force(new PVector(25, 10));
  frameRate(75);
  //noLoop();
  kk = new Building();
  kk1 = new Building();
  //kk1.add_line(new Line(p1, p2));
  //kk1.add_line(new Line(p2, p3));
  //kk1.add_line(new Line(p1, p3));
  //kk1.add_line(new Line(p3, p4));
  //kk1.add_line(new Line(p4, p5));
  //kk1.add_line(new Line(p5, p6));

  //kk1.add_line(new Line(p1, p3));
  //kk1.add_line(new Line(p1, p6));
  //kk1.add_line(new Line(p4, p6));

  Point[] w = {p1, p2, p3, p4, p5, p6};
  for (int i = 0; i < w.length - 1; i++) {
    for (int j = i + 1; j < w.length; j++) {
      kk1.add_line(new Line(w[i], w[j]));
    }
  } 

  p1copy = new Point(new PVector(p1.position.x, p1.position.y));
  p2copy = new Point(new PVector(p2.position.x, p2.position.y));
  p3copy = new Point(new PVector(p3.position.x, p3.position.y));

  //kk1.add_line(new Line(p1copy, p2copy));
  //kk1.add_line(new Line(p2copy, p3copy));
  //kk1.add_line(new Line(p1copy, p3copy));


  //kk.print_graph();
}




void draw() {
  background(255);
  //kk.update();
  //kk.check_and_tip();
  //kk.paint();
  //kk.draw_forces();

  kk1.distribute_gravitational_forces();
  kk1.check_and_tip();
  kk1.paint();
  kk1.draw_forces();
  fill(0);
  stroke(0);
  kk1.draw_center_of_mass();
  fill(255);


  frameRate(1);

  ArrayList<Point[]> alpha = get_earthquake_traversal_order(kk1);
  for (int i = 0; i < frameCount; i++) {

    stroke(color(0, 255, 0));
    PVector w = alpha.get(i)[0].position;
    PVector w2 = alpha.get(i)[1].position;
    println(w.y, w2.y);
    line(w.x, w.y, w2.x, w2.y);

    //draw_vector(w, w2);
  }
  println("\n\n");


  //noLoop();


  //float average = 0;

  //for (Point name: kk.graph.keySet()) {
  //  average += name.force.mag();
  //}
  ////println(average);
  //noLoop();
}

void keyPressed() {
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 's') {
    p2.apply_force(new PVector(0, 10000));
    ////println("yes");
  }
}
