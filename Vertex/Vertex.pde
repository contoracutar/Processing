
final int Start    = 0;
final int Cube     = 1;
final int Cylinder = 2;
final int Pyramid  = 3;
final int Sphere   = 4;
final int Doughnut = 5;
final int End      = 6;
int type = Cube;
int num = 10, scale = 50, l = 50;
int count = 0;

void setup(){
  
  size(800, 600, P3D);
}
  
void draw(){
  
  background(50);
  stroke(1);
  lights();
  if(!mousePressed){
    
    noStroke();
  }
    
  count++;
  translate(width / 2, height / 2);  
  
  rotateX(count * 0.01f);
  rotateY(count * 0.01f);
  
  switch(type){
    
    case Start:    type = Doughnut;           break;
    case Cube:     Cube(scale);               break;
    case Cylinder: Cylinder(num, scale, l);   break;
    case Pyramid:  Pyramid(num, 0, scale, l); break;
    case Sphere:   Sphere(num, scale);        break;
    case Doughnut: Doughnut(num, l, scale);   break;
    case End:      type = Cube;               break;
  }
}

void keyPressed(){
  
  int add = 1;
  int temp = num;
  int temp2 = type;
  if(mousePressed){
    
    add = 3;
    temp = scale;
    temp2 = l;
  }
  
  if(key == CODED){

    switch(keyCode){
      
      case UP:    temp  += add; break;
      case DOWN:  temp  -= add; break;
      case LEFT:  temp2 -= add; break;
      case RIGHT: temp2 += add; break;
    }
  }
  if(mousePressed){
    
    scale = constrain(temp, 10, 150);
    l     = constrain(temp2, 10, 150);
  } else{
    
    num  = constrain(temp, 3, 360);
    type = temp2;
  }
}

void Cube(float size){
  
  float rad = 90;
  float _length = size;
  size *= sqrt(2);
  
  for(int i = 0; i < 360; i += rad){
    
    PVector p = new PVector(cos(radians(i)), 0, sin(radians(i)));
    PVector np = new PVector(cos(radians(i - rad)), 0, sin(radians(i - rad)));
    
    PVector a = new PVector(p.x * size,  -_length, p.z * size);
    PVector b = new PVector(p.x * size,   _length, p.z * size);
    PVector c = new PVector(np.x * size, -_length, np.z * size);
    PVector d = new PVector(np.x * size,  _length, np.z * size);
    
    Circle(a, c, -_length);
    Circle(b, d, _length);
    Rect(a, b, c, d);
  }
}

void Cylinder(int n, float radius, float _length){
  
  float rad = 360 / n;
  radius *= sqrt(2);
  
  for(int i = 0; i < 360; i += rad){
    
    PVector p = new PVector(cos(radians(i)), 0, sin(radians(i)));
    PVector np = new PVector(cos(radians(i - rad)), 0, sin(radians(i - rad)));
    
    PVector a = new PVector(p.x * radius,  -_length, p.z * radius);
    PVector b = new PVector(p.x * radius,   _length, p.z * radius);
    PVector c = new PVector(np.x * radius, -_length, np.z * radius);
    PVector d = new PVector(np.x * radius,  _length, np.z * radius);
    
    Circle(a, c, -_length);
    Circle(b, d, _length);
    Rect(a, b, c, d);
  }
}

void Pyramid(int n, float upRadius, float downRadius, float _length){

  float rad = 360 / n;
  for(int i = 0; i < 360; i += rad){
    
    PVector p = new PVector(cos(radians(i)), 0, sin(radians(i)));
    PVector np = new PVector(cos(radians(i - rad)), 0, sin(radians(i - rad)));
    
    PVector a = new PVector(p.x * upRadius,   -_length, p.z * upRadius);
    PVector b = new PVector(p.x * downRadius,  _length, p.z * downRadius);
    PVector c = new PVector(np.x * upRadius,  -_length, np.z * upRadius);
    PVector d = new PVector(np.x * downRadius, _length, np.z * downRadius);
    
    Circle(a, c, -_length);
    Circle(b, d, _length);
    Rect(a, b, c, d);
  }
}

void Sphere(int n, float radius){
  
  float rad = 360 / n;
  for(int i = 0; i <= 180; i += rad){
    
    PVector ip = new PVector(sin(radians(i)), cos(radians(i)), sin(radians(i)));
    PVector inp = new PVector(sin(radians(i + rad)), cos(radians(i + rad)), sin(radians(i + rad)));
    for(int j = 0; j < 360; j += rad){
      
      PVector jp = new PVector(cos(radians(j)), 0, sin(radians(j)));
      PVector jnp = new PVector(cos(radians(j + rad)), 0, sin(radians(j + rad)));
      
      PVector a = new PVector(ip.x * jp.x * radius,   ip.y * -radius,  ip.z * jp.z * radius);
      PVector b = new PVector(ip.x * jnp.x * radius,  ip.y * -radius,  ip.z * jnp.z * radius);
      PVector c = new PVector(inp.x * jp.x * radius,  inp.y * -radius, inp.z * jp.z * radius);
      PVector d = new PVector(inp.x * jnp.x * radius, inp.y * -radius, inp.z * jnp.z * radius);
  
      Rect(a, b, c, d);
    }
  }
}

void Doughnut(int n, float radius, float distance){
  
  float rad = radians(360 / n);
  for(float i = 0; i < PI * 2; i += rad){
    
    PVector ip = new PVector(sin(i), 0, cos(i));      
    PVector inp = new PVector(sin(i + rad), 0, cos(i + rad));      
    for(float j = 0; j < PI * 2; j += rad){
      
      PVector jp = new PVector(sin(j), cos(j), sin(j));
      PVector jnp = new PVector(sin(j + rad), cos(j + rad), sin(j + rad));
      
      PVector a = new PVector(distance * ip.x + radius * ip.x * jp.x,    distance * ip.y + radius * jp.y,   distance * ip.z + radius * ip.z * jp.z);
      PVector b = new PVector(distance * ip.x + radius * ip.x * jnp.x,   distance * ip.y + radius * jnp.y,  distance * ip.z + radius * ip.z * jnp.z);
      PVector c = new PVector(distance * inp.x + radius * inp.x * jp.x,  distance * inp.y + radius * jp.y,  distance * inp.z + radius * inp.z * jp.z);
      PVector d = new PVector(distance * inp.x + radius * inp.x * jnp.x, distance * inp.y + radius * jnp.y, distance * inp.z + radius * inp.z * jnp.z);
      
      Rect(a, b, c, d);
    }
  }
}

void Circle(PVector a, PVector b, float _length){
  
  beginShape(TRIANGLES);

  vertex(0, _length, 0);
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);

  endShape();
}

void Rect(PVector a, PVector b, PVector c, PVector d){
  
  beginShape(TRIANGLES);
  
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);
  vertex(c.x, c.y, c.z);
  
  vertex(b.x, b.y, b.z);
  vertex(c.x, c.y, c.z);
  vertex(d.x, d.y, d.z);
    
  endShape();
}
