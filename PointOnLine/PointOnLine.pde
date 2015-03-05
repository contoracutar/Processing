
int count = 0;
void setup(){
  
  size(800, 600);
}
  
void draw(){
  
  count++;
  background(0);
  strokeWeight(2);
  stroke(255);
  line(width / 2, 0, width / 2, height);
  line(0, height / 2, width, height / 2);
  strokeWeight(0.25f);
  
  for(int i = 0; i < width; i += 20){
    line(i, 0, i, height);
    line(0, i, width, i);
  }
  
  translate(width / 2, height / 2);

  strokeWeight(1);
  float startX = 100, startY = -height / 2;
  float endX   = -200, endY   =  height / 2;
  stroke(255, 255, 0);
  line(startX, startY, endX, endY);
  
  float x = mouseX -  width / 2;
  float y = mouseY - height / 2;  
  
  float abX = endX - startX, abY = endY - startY;
  float apX = x - startX,    apY = y - startY;
  float l = sqrt(abX * abX + abY * abY);
  float unitABX = Normalize(l, abX);
  float unitABY = Normalize(l, abY);
  float dot = unitABX * apX + unitABY * apY;
  float pointOnLineX = startX + (unitABX * dot);
  float pointOnLineY = startY + (unitABY * dot);
  
  stroke(255, 0, 0);
  strokeWeight(1.5f);
  line(x, y, pointOnLineX, pointOnLineY);

  fill(255, 0, 0);
  text("(" + int(x / 20) + "," + int(-y / 20) + ")", x - 30, y - 20);
  text("(" + int(pointOnLineX / 20) + "," + int(-pointOnLineY / 20) + ")", pointOnLineX - 30, pointOnLineY - 20);
}

float Normalize(float leng, float value){
  
  float num = 1 / leng;
  value *= num;
  return value;
}
