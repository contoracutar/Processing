int n=5, r=100, state=0, reverse=1;
PVector v=new PVector(0,0,0);
float t=0;

void setup(){
  size(300, 300); noStroke();
}

void draw(){
  fill(0, 0, 0, 2); rect(0, 0, width, height);
  fill(255);// if(!mousePressed) { background(0); }
  
  PVector [] p = new PVector[n + 1];
  for (int i = 0; i <= n; i++){
    if(!mousePressed){
      p[i] = new PVector(width/2+r*sin(radians(i * 360 / n * (n/2))), height/2+r*-cos(radians(i * 360 / n * (n/2))));
    } else { p[i] = new PVector(width/2+r*sin(radians(i * 360 / n)), height/2+r*-cos(radians(i * 360 / n))); }
    //ellipse(p[i].x, p[i].y, 10, 10);
  }
  for(int i = 0; i <= n; i++){
    
    int next_i = i + 1, c = 0;
    if(next_i == n) { next_i = 0; }
    if(reverse < 0) { c = n; }
    if(t > 1) { state++; t = 0; }
    if(state == n) { state = 0; reverse *= -1; }
    if(t < 1 && state == i){
      //v = PVector.add(PVector.mult(p[reverse * i + c], 1 - t), PVector.mult(p[reverse * next_i + c], t));
      v = Leap(p[reverse * i + c], p[reverse * next_i + c], t);
      t += 0.02f;
    }
  }
  ellipse(v.x, v.y, 10, 10);
}

PVector Leap(PVector s, PVector e, float t){
  return PVector.add(PVector.add(PVector.mult(PVector.sub(e, s), -2*t*t*t), PVector.mult(PVector.sub(e, s), 3*t*t)), s);
}
