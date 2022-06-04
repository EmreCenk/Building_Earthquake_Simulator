

float dot_product(PVector a, PVector b){
  return a.x * b.x + a.y * b.y;
}

PVector project(PVector a, PVector b){
  // projects vector a onto vector b
  // doesn't modify original vectors
  
  PVector new_v = new PVector(b.x, b.y);
  new_v = new_v.mult(dot_product(a, b)/pow(b.mag(), 2));
  return new_v;
}

PVector polar_to_cartesian(float r, float theta){
  // converts polar coordinates to cartesian
  PVector cart = new PVector();  
  cart.x = r*cos(theta);
  cart.y = r*sin(theta);
  return cart;
}


PVector rotate_around_pivot(PVector pivot, PVector point, float theta){
  // rotates a point around a pivot by theta
  
  float tempX = point.x - pivot.x;
  float tempY = point.y - pivot.y;
  float current_angle = atan2(tempY, tempX);
  
  PVector rotated_p = polar_to_cartesian(dist(0, 0, tempX, tempY), current_angle - theta);
  
  rotated_p.x += pivot.x;
  rotated_p.y += pivot.y;
  return rotated_p;

}
