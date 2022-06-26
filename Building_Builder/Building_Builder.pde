 //<>// //<>// //<>// //<>// //<>// //<>//


Point p1, p2, p3, p4, p5, p6, p1copy, p2copy, p3copy;
ArrayList<Point> points0;
Building kk, kk1;
EarthQuake E;

void setup() {
  strokeWeight(2);
  size(800, 800);
  frameRate(75);
   
  E = new EarthQuake(0.05);
  kk1 = new Building();
  kk1.add_line(new Line(new Point(new PVector(width*0.4, height*0.6)), new Point(new PVector(width*0.6, height*0.9))));
  reset_building_outlines();

}




void draw() {
  background(255);
  
  if (kk1.graph.keySet().size() == 0) return;

  kk1.distribute_gravitational_forces();
  kk1.check_and_tip();

  
  
  E.shake(kk1);
  kk1.draw_forces();
  kk1.draw_earthquake_forces(); 
  
  fill(0);
  stroke(0);
  kk1.draw_center_of_mass();
  fill(255);
  

  kk1.paint();




  //noLoop();


  //float average = 0;

  //for (Point name: kk.graph.keySet()) {
  //  average += name.force.mag();
  //}
  //noLoop();
}


String mode = "point"; // "point" or "connection"

void keyPressed() {
  redraw();
  //redraw();
  //p1.apply_force(new PVector(25, 10));
  if (key == 'p')
    mode = "point";
  else if (key == 'c')
    mode = "connection";
    
  println(mode);
}

void reset_building_outlines(){

  for (Point point: kk1.graph.keySet()){
    point.outline_colour = point.colour;
  }
}


Point current_point = null;

void mousePressed(){
  reset_building_outlines();


  
  int p = coords_on_a_point(new PVector(mouseX, mouseY), kk1.points);
  
  if (p != -1){
    Point new_point = kk1.points.get(p);
    new_point.outline_colour = color(0, 0, 0);
    if (mode.equals("connection") && current_point != null && !new_point.equals(current_point)){
      kk1.add_line(new Line(current_point, new_point));
    }
    current_point = new_point;
  }
  else if (mode.equals("point")){
    if (current_point == null ) return;
    Point new_point = new Point(new PVector(mouseX, mouseY));
    kk1.add_line(new Line(current_point, new_point));    
    return;
  }

}
