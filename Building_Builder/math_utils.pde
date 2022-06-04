

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
