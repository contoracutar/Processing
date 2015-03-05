final int TotalWaves = 60;
final float mass = 4.5f;
final float stiffness = 0.95f;
final float friction = 0.975f;
int max = 30;
float rope = 5, ropeLength = 10;
PVector gravity = new PVector(0, 5);
PVector [] pos = new PVector[TotalWaves];
PVector [] pos2 = new PVector [max];
PVector [] ownerPos = new PVector [max];
PVector [] velocity = new PVector[TotalWaves];
PVector [] velocity2 = new PVector [max];

void setup(){
  size(700, 500);
  for (int i = 0; i < TotalWaves; i++){
    pos[i] = new PVector(map(i, 0, TotalWaves-1, -10, width+10), height/2);
    velocity[i] = new PVector(0, 0);
  }
  for(int i = 0; i < max; i++){
    pos2[i] = new PVector (0, 0);
    velocity2[i] = new PVector (0, 0);
  }
}

void draw(){
  background(120);
  stroke(255);
  strokeWeight(3);
  for(int i = 0; i < max; i++){
    pos2[i].add(velocity2[i]);
    ownerPos[i] = i > 0 ? pos2[i-1] : new PVector(width/2, height/2/2/2);
    velocity2[0] = PVector.mult(Normalize(new PVector(mouseX-ownerPos[0].x, mouseY-ownerPos[0].y)), 10);
    
    PVector vectorToPos = PVector.sub(pos2[i], ownerPos[i]);
    PVector unitVector = Normalize(vectorToPos);
    
    velocity2[i].add(Vertical(gravity, vectorToPos));
    velocity2[i] = Vertical(velocity2[i], vectorToPos);
    velocity2[i].mult(0.47f);
    
    rope = i > 0 ? ropeLength : ropeLength * 15;
    pos2[i] = PVector.add(ownerPos[i], PVector.mult(unitVector, rope));
    
    line(ownerPos[i].x, ownerPos[i].y, pos2[i].x, pos2[i].y);
    
    if(i == max-1){
      int c = (int)map(pos2[i].x, 0, width, 0, TotalWaves-1);
      if((pos2[i].y - pos[c].y) * (ownerPos[i].y - pos[c].y) <= 0){
        velocity[c].y += (ownerPos[i].y - pos2[i].y);
      }
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
    point(pos[i].x, pos[i].y);
    if(i > 0){
      stroke(0, 0, 255, 200);
      strokeWeight(0);
      line(pos[i].x, pos[i].y, pos[i-1].x, pos[i-1].y);
      fill(0, 0, 255, 100);
      stroke(0, 0, 0, 0);
      Rect(new PVector(pos[i].x, pos[i].y),
           new PVector(pos[i-1].x, pos[i-1].y),
           new PVector(pos[i].x, height),
           new PVector(pos[i-1].x, height));
    }
  }
}
PVector Normalize(PVector v){
  float l = sqrt(v.x * v.x + v.y * v.y);
  return new PVector(v.x / l, v.y / l);
}
float Dot(PVector a, PVector b){
  return a.x * b.x + a.y * b.y;
}
PVector Vertical(PVector origin, PVector v){
  PVector unitV = Normalize(v);
  float vLength = Dot(origin, unitV);
  unitV.mult(vLength);
  return new PVector(origin.x - unitV.x, origin.y - unitV.y);
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
void Rect(PVector a, PVector b, PVector c, PVector d){
  beginShape(TRIANGLES);
  vertex(a.x, a.y); vertex(b.x, b.y); vertex(c.x, c.y);
  vertex(b.x, b.y); vertex(c.x, c.y); vertex(d.x, d.y);
  endShape();
}
