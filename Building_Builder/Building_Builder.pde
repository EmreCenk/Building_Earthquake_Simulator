
PVector Fga, Fgb, ca, cb;
PVector Fa, Fra, Fb, Frb;

void setup(){
  Fga = new PVector(0, 100); //10 N of force down
  Fgb = new PVector(0, 100); //10 N of force down
  
  ca = new PVector(-100, 100);
  cb = new PVector(150, 80);
  
  
  Fa = new PVector(0, 0);
  Fb = new PVector(0, 0);
  size(800, 800);

  //frameRate(0.5);
  noLoop();
}

PVector[] get_forces(PVector Fga, PVector Fgb, PVector pole1, PVector force_exsting_on_p1, PVector pole2, PVector force_existing_on_p2){
  PVector Fa = new PVector(force_exsting_on_p1.x, force_exsting_on_p1.y);
  Fa.add(project(Fga, pole1));
  PVector Fra = new PVector(Fga.x, Fga.y);
  Fra.sub(Fa);
  
  PVector Fb = new PVector(force_existing_on_p2.x, force_existing_on_p2.y);
  Fb.add(project(Fgb, pole2));
  PVector Frb = new PVector(Fgb.x, Fgb.y);
  Frb.sub(Fb);
  
  return new PVector[] {Fa, Fra, Fb, Frb};
  
}


void draw(){

  PVector[] w = get_forces(Fga, Fgb, ca, Fa, cb, Fb);
  Fa = w[0];
  Fra = w[1];
  Fb = w[2];
  Frb = w[3];
  
  background(255);
  
  PVector o = new PVector(width/2, height*0.3);
  
  stroke(color(255, 0, 0));
  draw_vector(o, cb);
  draw_vector(o, ca);
  
  stroke(color(0, 0, 0));
  draw_vector(o, Fga);
  
  stroke(color(128,0,128));
  draw_vector(o, Fgb);
  
  stroke(color(0, 255, 0));
  draw_vector(o, Fa);
  draw_vector(o, Fb);
  
  stroke(color(0, 0, 255));
  draw_vector(o.add(Fa), Fra);
  
  stroke(color(255, 0, 255));
  draw_vector(o.sub(Fa).add(Fb), Frb);
  
  Fga = new PVector(Frb.x, Frb.y);
  Fgb = new PVector(Fra.x, Fra.y);
  
}

void keyPressed(){
  redraw();

}
