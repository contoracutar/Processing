final int TotalWaves = 60;
final float mass = 3.5f;
final float stiffness = 0.95f;
final float friction = 0.975f;
PVector [] pos = new PVector[TotalWaves];
PVector [] velocity = new PVector[TotalWaves];

void setup(){
  size(500, 250);
  for (int i = 0; i < TotalWaves; i++){
    pos[i] = new PVector(map(i, 0, TotalWaves-1, 0, width), height/2);
    velocity[i] = new PVector(0, 0);
  }
}

void draw(){
  background(150);
  if(mouseY != pmouseY){
    int i = (int)map(mouseX, 0, width, 0, TotalWaves-1);
    if((pmouseY - pos[i].y) * (mouseY - pos[i].y) <= 0){
      velocity[i].y += (mouseY - pmouseY) * 2;
    }
  }
  for(int i = 0; i < TotalWaves; i++){
    if(i > 0){
      velocity[i] = (Hookeslaw(pos[i], velocity[i], pos[i-1], mass, stiffness, friction));
    }
    if(i < TotalWaves - 1){
      velocity[i] = (Hookeslaw(pos[i], velocity[i], pos[i+1], mass, stiffness, friction));
    }
    velocity[i] = (Hookeslaw(pos[i], velocity[i], new PVector(pos[i].x, height/2), mass, stiffness, friction));
    pos[i].y += velocity[i].y;
  }

  for(int i = 0; i < TotalWaves; i++){
    if(i > 0){
      //stroke(0, 0, 255, 200);
      //strokeWeight(2);
      //line(pos[i].x, pos[i].y, pos[i-1].x, pos[i-1].y);
      fill(0, 0, 255, 100);
      noStroke();
      Rect(new PVector(pos[i].x, pos[i].y),
           new PVector(pos[i-1].x, pos[i-1].y),
           new PVector(pos[i].x, height),
           new PVector(pos[i-1].x, height));
    }
  }
}

void Rect(PVector a, PVector b, PVector c, PVector d){
  beginShape(TRIANGLES);
  vertex(a.x, a.y); vertex(b.x, b.y); vertex(c.x, c.y);
  vertex(b.x, b.y); vertex(c.x, c.y); vertex(d.x, d.y);
  endShape();
}

PVector Hookeslaw(PVector pos, PVector velocity, PVector target, float mass, float stiffness, float friction){
  PVector SpringForce = new PVector(0, 0);
  PVector Acceleration = new PVector(0, 0);
  SpringForce.x = (target.x - pos.x)/5 * stiffness;
  SpringForce.y = (target.y - pos.y)/5 * stiffness;
  Acceleration.x = SpringForce.x / mass;
  Acceleration.y = SpringForce.y / mass;
  velocity.x = friction * (velocity.x + Acceleration.x);
  velocity.y = friction * (velocity.y + Acceleration.y);
  
  return velocity;
}
