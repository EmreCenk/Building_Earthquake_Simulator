
import java.util.PriorityQueue;
import java.util.Comparator;

ArrayList<Point> merge(ArrayList<Point> p1, ArrayList<Point> p2){
  // merges two sorted lists (assuming both are sorted in ascending order
  
  ArrayList<Point> final_list = new ArrayList<Point>();
  int p1_counter = 0;
  int p2_counter = 0;
  
  while (p1_counter < p1.size() && p2_counter < p2.size()){
    if (p1.get(p1_counter).position.y < p2.get(p2_counter).position.y){
      final_list.add(p1.get(p1_counter));
      p1_counter += 1;
    }
    else{
      final_list.add(p2.get(p2_counter));
      p2_counter += 1;
    }
  }
  
  if (p1_counter == p1.size()){
    for (int i = p2_counter; i < p2.size(); i++)
      final_list.add(p2.get(i));
  }
  
  else{
    for (int i = p1_counter; i < p1.size(); i++)
      final_list.add(p1.get(i));
  }
  
  return final_list;
  
}

ArrayList<Point> merge_sort(ArrayList<Point> nod){
  if (nod.size() <= 1) return nod;
  ArrayList<Point> half_1 = new ArrayList<Point>();
  ArrayList<Point> half_2 = new ArrayList<Point>();
  int midpoint = nod.size()/2;
  for (int i = 0; i < midpoint; i++) half_1.add(nod.get(i));
  for (int i = midpoint; i < nod.size(); i++) half_2.add(nod.get(i));
  return merge(merge_sort(half_1), merge_sort(half_2));
}

ArrayList<Point> HashSet_to_ArrayList(HashSet<Point> set){
  ArrayList<Point> final_ = new ArrayList<Point>();
  for (Point point: set) final_.add(point);
  return final_;
}


class PointComparator implements Comparator<Point>{
  // class used to compare points depending on y coordinate (this class is used for the priority queue)
  
  public int compare(Point p1, Point p2){
    if (p1.position.y < p2.position.y) return 1;
    else if (p1.position.y > p2.position.y) return -1;
    return 0;
  }
}

ArrayList<Point[]> get_earthquake_traversal_order(Building building){
  Point current_node;
  ArrayList<Point> neighbours;
  
  ArrayList<Point[]> order_to_traverse = new ArrayList<Point[]>();
  PriorityQueue<Point> to_travel = new PriorityQueue<Point>(building.graph.keySet().size(), new PointComparator());

  for (Point support_point: building.get_support_points()){
    to_travel.add(support_point);
  }

  // storing what we've travelled to
  HashMap<Point, Boolean> travelled = new HashMap<Point, Boolean>();
  for (Point point: building.graph.keySet())
    travelled.put(point, false);
    
  while (to_travel.size() > 0){
    current_node = to_travel.poll();
    if (travelled.get(current_node)) continue;
    travelled.put(current_node, true);
    neighbours =  merge_sort(HashSet_to_ArrayList(building.graph.get(current_node)));
    for (int i = neighbours.size() - 1; i >= 0; i--){
      if (travelled.get(neighbours.get(i))) continue;
      order_to_traverse.add(new Point[] {current_node, neighbours.get(i)});
      to_travel.add(neighbours.get(i));
    }
   
  }
  return order_to_traverse;
}

HashMap<Float, Integer> get_first_occurence_of_each_y(ArrayList<Point> sorted_points, int interval){
  HashMap<Float, Integer> final_hash = new HashMap<Float, Integer>();
  
  // two pointer system
  int left = 0;
  int right = 0;
  int index = 0;

  while (right < sorted_points.size()){
    if (sorted_points.get(right).position.y - sorted_points.get(left).position.y < interval)
      right += 1;
      
    else{
      index = right;
      while (left < right){
        final_hash.put(sorted_points.get(left).position.y, index);
        left += 1;
      }
    }
      
  }
  right -= 1;
  index = right;
  while (left <= right){
    final_hash.put(sorted_points.get(left).position.y, index);
    left += 1;
  }

  return final_hash;
}


float sup_dist(Point point, ArrayList<Point> support_points){
  float min_dist = 1000000000;
  for (Point sup_point: support_points){
    min_dist = min(min_dist, dist(sup_point.position.x, sup_point.position.y, point.position.x, point.position.y));
  }
  return min_dist;
}
