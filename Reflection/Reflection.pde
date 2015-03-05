ArrayList<Circle> circle;
PVector oldMouse = new PVector(0, 0, 0);
void setup()
{
  size(450, 450);
  noStroke();
  circle = new ArrayList<Circle>();
  int n = 30;
  int m = 30;
  for(int i = 0; i < n; i++)
  {
    for(int j = 0; j < m; j++)
    {
      circle.add(new Circle(600/8+i*n/3, 600/8+j*m/3, 5));
    }
  }
}
void draw()
{
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  fill(255);
  if(!mousePressed)
  {
    background(0);
  }
  
  if(mousePressed)
  {
    //Circle c = new Circle(mouseX, mouseY, random(50, 50));
    //circle.add(c);
  }
  for(int i = circle.size() - 1; 0 <= i; i--)
  {
    Circle s = circle.get(i);
    for(int j = circle.size() - 1; 0 <= j; j--)
    {
      if(i != j)
      {
        Circle s2 = circle.get(j);
        if(Collision(s.pos, s2.pos, s.r + s2.r))
        {
          //s.velocity = 
          R(s, s2);
        }
      }
    }
    if(i == 0)
    {
      if(oldMouse.x != mouseX || oldMouse.y != mouseY)
      {
        s.velocity = new PVector(mouseX - oldMouse.x, mouseY - oldMouse.y);
        oldMouse = new PVector(mouseX, mouseY);
      } else { s.velocity = new PVector(0, 0, 0); }
      s.pos = new PVector(mouseX, mouseY);
      s.size = 50;
      s.c = color(255);
    }
    s.Update();
    s.Draw();
  }
}

class Circle
{
  public PVector pos, velocity;
  public float size, r;
  public color c;
  Circle(float x, float y, float s)
  {
    pos = new PVector(x, y);
    size = s;
    velocity = new PVector(random(-20, 20), random(-20, 20));
    velocity = new PVector(0, 0);
    c = color(random(255), random(255), random(255));
  }
  void Update()
  {
    r = size / 2;
    pos.add(velocity);
    //velocity.y += 0.005f;
    //velocity.mult(0.95f);
    if(pos.x < 0 + r || pos.x > width - r)
    {
      velocity.x *= -0.95f;
    }
    if(pos.y < 0 + r || pos.y > height - r)
    {
      velocity.y *= -0.95f;
    }
    pos = Constrain(r, pos, new PVector(0, 0), new PVector(width, height));
    
    if(mousePressed)
    {
      //velocity.y -= 1;
    }
  }
  void Draw()
  {
    fill(c);
    ellipse(pos.x, pos.y, size, size);
  }
  PVector Constrain(float s, PVector v, PVector mi, PVector ma)
  {
    v = new PVector(max(mi.x + s, min(v.x, ma.x - s)), max(mi.y + s, min(v.y, ma.y - s)));
    return v;
  }
}
PVector R(Circle c1, Circle c2)
{
  float s = c1.r + c2.r;
  PVector a = c1.pos, b = c2.pos;
  
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
  float dotA = Dot(nA, c1.velocity);
  nA.mult(dotA);
  PVector vA = new PVector(c1.velocity.x - nA.x, c1.velocity.y - nA.y);

  PVector nB = Normalize(new PVector(a.x - b.x, a.y - b.y));
  float dotB = Dot(nB, c2.velocity);
  nB.mult(dotB);
  PVector vB = new PVector(c2.velocity.x - nB.x, c2.velocity.y - nB.y);
  
  c1.velocity = new PVector(vA.x + nB.x, vA.y + nB.y);
  c2.velocity = new PVector(vB.x + nA.x, vB.y + nA.y);
  
  c1.velocity.mult(0.95f);
  c2.velocity.mult(0.95f);

  return a;
}
PVector Normalize(PVector v)
{
  float l = sqrt(v.x * v.x + v.y * v.y);
  return new PVector(v.x / l, v.y / l);
}
boolean Collision(PVector a, PVector b, float r)
{
  if((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y) < r * r)
  {
    return true;
  }
  return false;
}
float Dot(PVector a, PVector b)
{
  return a.x * b.x + a.y * b.y;
}
