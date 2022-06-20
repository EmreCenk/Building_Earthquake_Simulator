 //<>//


Point p1, p2, p3, p4, p5, p6, p1copy, p2copy, p3copy;
ArrayList<Point> points0;
Building kk, kk1;
EarthQuake E;

void setup() {
  strokeWeight(2);
  size(800, 800);
  frameRate(75);
   
  E = new EarthQuake(0.05);

  points0 = new ArrayList<Point>();
  int n = 10;
  int h = 400;
  int w = 300;
  for (int i = 0; i < n/2; i++){
    points0.add(new Point(new PVector(300, 100 + i*h/n)));
  }
  for (int i = 0; i < n/2; i++){
    points0.add(new Point(new PVector(300 + w, 100 + i * h/n)));
  }


  kk1 = new Building();
  //for (int i = 0; i < points0.size() - 1; i++){
  //  kk1.add_line(new Line(points0.get(i), points0.get(i+1)));
  //  kk1.add_line(new Line(points0.get(i), points0.get((i+n/2)%n)));
  //}
  
  //kk1.add_line(new Line(p1, p4));
  //kk1.add_line(new Line(p2, p5));
  //kk1.add_line(new Line(p3, p6));
  
  //kk1.add_line(new Line(p1, p2));
  //kk1.add_line(new Line(p2, p3));

  //kk1.add_line(new Line(p4, p5));
  //kk1.add_line(new Line(p5, p6));

  //kk1.add_line(new Line(p3, p6));


  for (int i = 0; i < points0.size() - 1; i++) {
    for (int j = i + 1; j < points0.size(); j++) {
      kk1.add_line(new Line(points0.get(i), points0.get(j)));
    }
  } 

}




void draw() {
  background(255);


  kk1.distribute_gravitational_forces();
  kk1.check_and_tip();
  kk1.paint();

  
  
  E.shake(kk1);
  kk1.draw_forces();
  kk1.draw_earthquake_forces(); 
  
  fill(0);
  stroke(0);
  kk1.draw_center_of_mass();
  fill(255);



  //noLoop();


  //float average = 0;

  //for (Point name: kk.graph.keySet()) {
  //  average += name.force.mag();
  //}
  //noLoop();
}

void keyPressed() {
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 's') {
    p2.apply_force(new PVector(0, 10000));
  }
}
