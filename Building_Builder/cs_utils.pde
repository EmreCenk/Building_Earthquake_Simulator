

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
  if (nod.size() == 1) return nod;
  ArrayList<Point> half_1 = new ArrayList<Point>();
  ArrayList<Point> half_2 = new ArrayList<Point>();
  int midpoint = nod.size()/2;
  for (int i = 0; i < midpoint; i++) half_1.add(nod.get(i));
  for (int i = midpoint; i < nod.size(); i++) half_2.add(nod.get(i));
  return merge(merge_sort(half_1), merge_sort(half_2));
}
