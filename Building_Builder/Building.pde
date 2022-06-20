

import java.util.Map;
import java.util.HashSet;
class Building{
  // what's a building, if not just a bunch of lines stuck together?
  ArrayList<Line> lines; // a list of lines in case I need them at some point
  HashMap<Point, HashSet<Point>> graph; // maps points to points that they are adjacent to (basically an adjacency list where the points are nodes and lines are edges)
  float tipping_angular_speed, tipping_angular_acceleration, relative_theta;
  Building(){
    this.tipping_angular_speed = 0;
    this.tipping_angular_acceleration = 0;
    this.relative_theta = 0;
    this.lines = new ArrayList<Line>();
    this.graph = new HashMap<Point, HashSet<Point>>();
  }
  
  
  void add_node(Point point_1, Point point_2){
    if (this.graph.get(point_1) == null){
      HashSet<Point> a = new HashSet<Point>();
      a.add(point_2);
      this.graph.put(point_1, a);
    }
    else this.graph.get(point_1).add(point_2);

  
  }
  void add_line(Line l){
    this.add_node(l.p1, l.p2);
    this.add_node(l.p2, l.p1);
    this.lines.add(l);
  }
  
  ArrayList<Point> get_points(){
    ArrayList<Point> points = new ArrayList<Point>();
    for (Point point: this.graph.keySet()) points.add(point);
    return points;
   }
  ArrayList<Point> get_sorted_points(){
    // returns a list of points sorted in ascending order (depending on their height)

    return merge_sort(this.get_points());
  }

  
  void reset_forces(){
    for (Point name: this.graph.keySet()) {
      name.force.x = 0;
      name.force.y = 0;
    }

  }
  void reset_earthquake_forces(){
    for (Point name: this.graph.keySet()) {
      name.earthquake_force.x = 0;
      name.earthquake_force.y = 0;
    }

  }
  void distribute_gravitational_forces(){
    // the order that we traverse the points is crucial
    // to find the proper net force, we have to traverse the points from highest to lowest height
    
    this.reset_forces();
    float magnitude;
    PVector pole_vector = new PVector(0, 0);
    int non_visited_neighbour_count;
    
    //HashMap<Point, Boolean> travelled = new HashMap<Point, Boolean>();
    //for (Point p: this.graph.keySet()) travelled.put(p, false);
    
    ArrayList<Point> points = this.get_sorted_points();
    for (Point p: points){
      non_visited_neighbour_count = 0;
      p.apply_force(new PVector(0, p.m * g)); // F = m*a (in this case, a=g to calculate force of gravity on the point)
      
      // count how many of the neighbours we haven't travelled to yet: 
      for (Point neighbour: this.graph.get(p)){
        if (neighbour.position.y >= p.position.y) // neighbour is below us in terms of height, so we haven't travelled to this neighbour yet
          non_visited_neighbour_count += 1;
      }
      
      magnitude = p.force.mag() / non_visited_neighbour_count;
      
      for (Point neighbour: this.graph.get(p)){
        if (neighbour.position.y <= p.position.y) continue;// neighbour is higher than us in terms of height, we've already travelled to this node
        pole_vector.x = neighbour.position.x; pole_vector.y = neighbour.position.y;
        pole_vector.sub(p.position);
        pole_vector.normalize().mult(magnitude);
        neighbour.apply_force(pole_vector);

      }
      
    }    

    //for (Line l: this.lines) l.update();
  }
  
  void draw_forces(){
    stroke(color(255, 0, 0));
    for (Point name: this.graph.keySet()) {
      draw_vector(name.position, name.force);
    }
    stroke(0);
  }
  
  void draw_earthquake_forces(){
    stroke(color(64, 13, 94));
    for (Point name: this.graph.keySet()) {
      draw_vector(name.position, name.earthquake_force);
    }
    stroke(0);
  }
  PVector get_center_of_mass(){
    return calculate_center_of_mass(this.get_points());
  }
  
  Point get_lowest_height(){
    Point lowest = this.lines.get(0).p1;
    for (Point point: this.graph.keySet()) {
      if (point.position.y > lowest.position.y) lowest = point;
    }
    return lowest;
  }
  
  void correct_support_points(Point lowest_point){
    for (Point point: this.graph.keySet()){
      point.position.y = min(point.position.y, lowest_point.position.y);
    }
    
  }
  
  ArrayList<Point> get_support_points(){
    ArrayList<Point> points = new ArrayList<Point>();
    Point lowest = this.get_lowest_height();

    float threshold = 1;
    for (Point point: this.graph.keySet()){
      if (abs(point.position.y - lowest.position.y) <= threshold) points.add(point);
    }
    
    return points;
  }
  
  void rotate_around_point(PVector pivot_point, float theta){
    for (Point point: this.graph.keySet()){
      point.position = rotate_around_pivot(pivot_point, point.position, theta);
    }
  }
  
  void check_and_tip(){
    ArrayList<Point> points = this.get_support_points();
    Point lowest_x = points.get(0);
    Point highest_x = points.get(0);
    for (Point point: points){
      if (point.position.x <= lowest_x.position.x) lowest_x = point;
      if (point.position.x >= highest_x.position.x) highest_x = point;
    }
    PVector center_of_mass = this.get_center_of_mass();

    float coef = 1;
    Point to_rotate = lowest_x;
    boolean rotate_ = false;
    if (center_of_mass.x < lowest_x.position.x) {
      coef = -1;
      to_rotate = lowest_x;
      rotate_ = true;
    }
    else if (center_of_mass.x > highest_x.position.x){
      rotate_ = true;
    }

    if (rotate_){
      float distance = dist(center_of_mass.x, center_of_mass.y, highest_x.position.x, highest_x.position.y);
      this.tipping_angular_acceleration = 0.8 * cos(this.relative_theta)/distance;
      this.tipping_angular_speed  += this.tipping_angular_acceleration;
      this.relative_theta -= this.tipping_angular_speed;
  
      this.rotate_around_point(to_rotate.position, radians(coef * this.relative_theta));
      
      ArrayList<Point> w = merge_sort(points);
      this.correct_support_points(w.get(w.size() - 1));
    }
  }
  
  void draw_center_of_mass(){
    PVector O = this.get_center_of_mass();
    circle(O.x, O.y, 20);
  }
  
  void paint(){
    for (Line l: this.lines) l.paint();
  }
  

  void print_graph(){
    for (Point name: this.graph.keySet()) {
      PVector asdf = name.position;
      for (Point p: this.graph.get(name)){
        PVector value = p.position;
        //println("-", value);
      }
  
    //println();//println();
  
    }
  }
  
}
