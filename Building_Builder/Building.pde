

import java.util.Map;

class Building{
  // what's a building, if not just a bunch of lines stuck together?
  ArrayList<Line> lines; // a list of lines in case I need them at some point
  HashMap<Point, ArrayList<Point>> graph; // maps points to points that they are adjacent to (basically an adjacency list where the points are nodes and lines are edges)
  Building(){
    this.lines = new ArrayList<Line>();
    this.graph = new HashMap<Point, ArrayList<Point>>();
  }
  
  
  void add_node(Point point_1, Point point_2){
    if (this.graph.get(point_1) == null){
      ArrayList<Point> a = new ArrayList<Point>();
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
  
  Point find_starting_node(){
    //the highest node (lowest y value) is always the starting node when traversing the graph (since the weight of that node will be on every thing that is connected to it, that's where we start)
    float max_height = this.lines.get(0).p1.position.y;
    Point start_node = this.lines.get(0).p1;
    for (Point some_point: this.graph.keySet()){
      if (some_point.position.y < max_height){ // up is negative on the screen, being high means having a low y value
        max_height = some_point.position.y;
        start_node = some_point;
      }
    }
    return start_node;
    
  }
  void update(){
    for (Line l: this.lines) l.update();
  }
  void paint(){
    for (Line l: this.lines) l.paint();
  }
  

  void print_graph(){
    for (Point name: this.graph.keySet()) {
      PVector asdf = name.position;
      println(asdf, ": ");
      for (Point p: this.graph.get(name)){
        PVector value = p.position;
        println("-", value);
      }
  
    println();println();
  
    }
  }
  
}
