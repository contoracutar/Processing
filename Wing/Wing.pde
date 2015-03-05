float rad = 90;
int count = 0;
int weight = 3;

void setup() {
  size(600, 500);
  stroke(200);
}
 
void draw() {
  count++;
  fill(255);
  strokeWeight(weight);
  background(0);
//  translate(width/2, height/2);
  
  for (int i = 20; i < rad; i+=1) {
    float t = mousePressed ? t = 0 : rad - i;
    float angle = cos(radians(t+count*3))*i;
    PVector v = new PVector(-cos(radians(-angle))*(i*3), sin(radians(-angle))*(i*3));
    line(-20+mouseX, mouseY, mouseX+v.x, mouseY+v.y);
    line(20+mouseX, mouseY, mouseX-v.x, mouseY+v.y);
  }
}
