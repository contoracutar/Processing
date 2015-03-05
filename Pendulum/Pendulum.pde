ArrayList<Circle> circle;
//Circle[] circle;
void setup()
{
  size(500, 400);
  circle = new ArrayList<Circle>();
  int m = 7;
  for(int i = 0; i < m; i++)
  {
    if(i == 0)
    {
      circle.add(new Circle(0, height/2, random(50, 50)));
    }
    else
      circle.add(new Circle(75 + i * 50, height/2, random(50, 50)));
  }
}
void draw()
{
  background(0);
  stroke(255);
  
  for(int i = circle.size() - 1; 0 <= i; i--)
  {
    Circle s1 = circle.get(i);
    for(int j = circle.size() - 1; 0 <= j; j--)
    {
      if(i != j)
      {
        Circle s2 = circle.get(j);
        if(Collision(s1.pos, s2.pos, s1.r + s2.r))
        {
          float s = s1.r + s2.r;
          PVector a = s1.pos, b = s2.pos;
          
          PVector v = new PVector(a.x - b.x, a.y - b.y);
          float l = sqrt(v.x * v.x + v.y * v.y);
          float distance = (s - l) / 2;
          if(l > 0)
          {
            l = 1 / l;
          }
          v.x *= l;
          v.y *= l;
          a.x += v.x * distance;
          a.y += v.y * distance;
          b.x -= v.x * distance;
          b.y -= v.y * distance;
          
          PVector nA = Normalize(new PVector(b.x - a.x, b.y - a.y));
          float dotA = Dot(nA, s1.velocity);
          nA.mult(dotA);
          PVector vA = new PVector(s1.velocity.x - nA.x, s1.velocity.y - nA.y);
        
          PVector nB = Normalize(new PVector(a.x - b.x, a.y - b.y));
          float dotB = Dot(nB, s2.velocity);
          nB.mult(dotB);
          PVector vB = new PVector(s2.velocity.x - nB.x, s2.velocity.y - nB.y);
          
          s1.velocity = new PVector(vA.x + nB.x, vA.y + nB.y);
          s2.velocity = new PVector(0, 0, 0);
          s2.velocity = new PVector(vB.x + nA.x, vB.y + nA.y);
          
          s1.velocity.mult(0.99f);
          s2.velocity.mult(0.99f);
        }
      }
    }
    PVector gravity = new PVector(0, 0.5f, 0);
    PVector line = new PVector(75 + i * 50, 50);
    line(line.x, line.y, s1.pos.x, s1.pos.y);
    PVector vector = new PVector(s1.pos.x - line.x, s1.pos.y - line.y);
    PVector unitVector = Normalize(vector);
    PVector verticalVector = Vertical(gravity, vector);
    s1.velocity.add(verticalVector);
    s1.velocity = Vertical(s1.velocity, vector);
    s1.pos = new PVector(line.x + unitVector.x * 250, line.y + unitVector.y * 250);
    
    s1.Update();
    s1.Draw();
  }
}

class Circle
{
  public PVector pos, velocity;
  public float size, r;
  Circle(float x, float y, float s)
  {
    pos = new PVector(x, y);
    size = s;
    r = size / 2;
    velocity = new PVector(0, 0);
    //velocity = new PVector(random(-20, 20), random(-20, 20));
  }
  void Update()
  {
    pos.add(velocity);
    //velocity.mult(0.95f);
    //if(pos.x < 0 + r || pos.x > width - r) { velocity.x *= -1; }
    //if(pos.y < 0 + r || pos.y > height - r) { velocity.y *= -1; }
    //pos = Constrain(r, pos, new PVector(0, 0), new PVector(width, height));
    
    //if(mousePressed) { velocity.y -= 1; }
    
    PVector mouse = new PVector(mouseX, mouseY);
    if(Length(new PVector(pos.x - mouse.x, pos.y - mouse.y)) < r)
    {
      if(mousePressed)
      {
        pos = mouse;
      }
    }
  }
  void Draw()
  {
    ellipse(pos.x, pos.y, size, size);
  }
  PVector Constrain(float s, PVector v, PVector mi, PVector ma)
  {
    v = new PVector(max(mi.x + s, min(v.x, ma.x - s)), max(mi.y + s, min(v.y, ma.y - s)));
    return v;
  }
}
float Dot(PVector a, PVector b)
{
  return a.x * b.x + a.y * b.y;
}
float Length(PVector v)
{
  return sqrt(v.x * v.x + v.y * v.y);
}
PVector Normalize(PVector v)
{
  float l = sqrt(v.x * v.x + v.y * v.y);
  return new PVector(v.x / l, v.y / l);
}
PVector Vertical(PVector origin, PVector v)
{
  PVector unitV = Normalize(v);
  float vLength = Dot(origin, unitV);
  unitV.mult(vLength);
  return new PVector(origin.x - unitV.x, origin.y - unitV.y);
  //PVector d = new PVector(Dot(from, to) * to.x, Dot(from, to) * to.y);
  //return new PVector(from.x - d.x, from.y - d.y);
}
boolean Collision(PVector a, PVector b, float r)
{
  if((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y) < r * r)
  {
    return true;
  }
  return false;
}
