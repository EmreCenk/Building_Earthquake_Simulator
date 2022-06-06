

PVector calculate_center_of_mass(ArrayList<Point> points){
  
  float x = 0;
  float y = 0;
  float mass_sum = 0;
  for (int i = 0; i < points.size(); i++){
    x += points.get(i).position.x * points.get(i).m;
    y += points.get(i).position.y * points.get(i).m;
    mass_sum += points.get(i).m;
  }
  return new PVector(x/mass_sum, y/mass_sum);
}
