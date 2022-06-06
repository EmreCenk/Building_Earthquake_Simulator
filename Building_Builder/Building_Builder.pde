


Point p1, p2;
Line lad;
Building kk;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(150, 300));
  lad = new Line(p1, p2);
  //p1.apply_force(new PVector(25, 10));
  frameRate(10);
  
  kk = new Building();
  kk.add_line(lad);
  kk.print_graph();
  
  ArrayList<Point> test_list = new ArrayList<Point>();
  test_list.add(new Point(new PVector(0, 100)));
  test_list.add(new Point(new PVector(0, 123)));
  test_list.add(new Point(new PVector(0, 333)));
  test_list.add(new Point(new PVector(0, 444)));
  test_list.add(new Point(new PVector(0, 111)));
  test_list.add(new Point(new PVector(0, 23)));
  test_list.add(new Point(new PVector(0, 32)));
  test_list.add(new Point(new PVector(0, 4)));
  test_list.add(new Point(new PVector(0, -12)));
  ArrayList<Point> sorted = merge_sort(test_list);

  for (Point k: sorted){
    println(k.position.y);
  }
  
}




void draw(){
  background(255);
  kk.update();
  kk.paint();



  //draw_vector(p1.position, new PVector(25, 10));
  draw_vector(p2.position, new PVector(50, 0));


  
}

void keyPressed(){
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 's')
    p2.apply_force(new PVector(50, 0));

  //noLoop();
}
