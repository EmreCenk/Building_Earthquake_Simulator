

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
