import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
Blob blob;
Blob blob2;
int bandera;
int pantalla = 0;


void setup() 
{
  size(700,700);
  bandera=0;
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2,height-5,width,10));
  boundaries.add(new Boundary(width/2,5,width,10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  boundaries.add(new Boundary(5,height/2,10,height));
  blob = new Blob();   
}


void draw() 
{ 
   if(pantalla==0)
  {
    if(key==0)
    {
      background(50);
      textSize(90);
      fill(210, 70, 100);
      text("BUBLY", 200, 300);
      textSize(40); 
      fill(180, 70, 153);
      text("Presione Cualquier Boton", 100, 350);
      inicio();
    }
    else
     {
       key=0;
       pantalla=1;
      }
    }
    if(pantalla==1)
    {
      background(150,90,200);
      textSize(50); 
      fill(255);
      text("Presione q",50,100);
      {
        if(key=='q')
        {
          bandera=1;
        }
        if(bandera==1)
          box2d.step();
          blob.display();
          for (Boundary wall: boundaries)
          {
            wall.display();
          }
        }
      }
    }

void inicio()
{
  fill(random(250),195,200);
  noStroke();
  ellipse(random(800),random(600), random(20), random(20)); 
}