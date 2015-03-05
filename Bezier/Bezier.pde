final float frame = 180.0f;
final float ePosX = 30, ePosY = 50;

ArrayList BallList;

void setup()
{
  size(500, 300);
  smooth();
  BallList = new ArrayList();
}
 
void draw()
{
  noStroke();
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);

  fill(255, 0, 255, 255);
  ellipse(ePosX, ePosY, 20, 20);

  if (mousePressed)
  {
    BallList.add(new CBall(mouseX, mouseY, random(-200, 200), random(-200, 200), random(-200, 200), random(-200, 200)));
  }
  for(int i = 0; i < BallList.size(); i++)
  {
    CBall ball = (CBall) BallList.get(i);
    ball.Update();
    ball.Draw();
    if (ball.GetisDelete())
    {
      BallList.remove(i);
    }
  }
}
  
class CBall
{
  CBall (float posX, float posY, float con1X, float con1Y, float con2X, float con2Y)
  {
    this.posX = posX;
    this.posY = posY;
    this.con1X = this.posX + con1X;
    this.con1Y = this.posY + con1Y;
    this.con2X = ePosX + con2X;
    this.con2Y = ePosY + con2Y;
    colorRGB = color(random(255), random(255), random(255), 255);
  }
  void Update()
  {
    counter++;
    Bezier(counter);
    if(counter > delete)
    {
      isDelete = true;
    }
  }
  void Draw()
  {
    fill(colorRGB);
    ellipse(x, y, 5, 5);
  }
  void Bezier(int count)
  {
    float t = (float)count / frame;
    x = (1 - t) * (1 - t) * (1 - t) * posX;
    y = (1 - t) * (1 - t) * (1 - t) * posY;
    x += 3 * (1 - t) * (1 - t) * t * con1X;
    y += 3 * (1 - t) * (1 - t) * t * con1Y;
    x += 3 * (1 - t) * t * t * con2X;
    y += 3 * (1 - t) * t * t * con2Y;
    x += t * t * t * ePosX;
    y += t * t * t * ePosY;
  }
  public boolean GetisDelete(){ return isDelete; }
  private boolean isDelete = false;
  private int counter = 0;
  private float posX, posY;
  private float velocityX, velocityY;
  private float x, y;
  private float con1X, con1Y, con2X, con2Y;
  private color colorRGB;
  private final int delete = (int)frame;
}
