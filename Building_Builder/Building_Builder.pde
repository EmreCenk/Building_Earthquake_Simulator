


Point p1, p2;
Line lad;
void setup(){
  size(800, 800);
  p1 = new Point(new PVector(100, 200));
  p2 = new Point(new PVector(50, 300));
  lad = new Line(p1, p2);
  //p1.apply_force(new PVector(25, 10));
  frameRate(10);
  
  Building kk = new Building();
  kk.add_line(lad);
  kk.print_graph();
  //}
  
}




void draw(){
  background(255);
  lad.update();
  lad.paint();



  //draw_vector(p1.position, new PVector(25, 10));
  draw_vector(p2.position, new PVector(50, 0));


  
}

void keyPressed(){
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  p2.apply_force(new PVector(50, 0));

  //noLoop();
}
