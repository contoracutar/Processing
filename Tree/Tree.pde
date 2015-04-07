float theta;
void setup()
{
  size(320, 510);
}
void draw()
{
  rect(0,0,width,height);
  theta = radians((mouseX / (float) width) * 75.0f);
  translate(width/2,height);
  line(0,0,0,-120);
  translate(0,-120);
  branch(120);

}
void branch(float h)
{
  h *= 0.66;
  if (h > 1.5f)
  {
    pushMatrix();
    rotate(theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
