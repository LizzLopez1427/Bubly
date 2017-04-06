class Blob 
{
  ArrayList<Body> skeleton;
  float bodyRadius; 
  float radius;    
  float totalPoints; 
  int x;
  int y;
  
  Blob() 
  {
    skeleton = new ArrayList<Body>();
    ConstantVolumeJointDef cvjd = new ConstantVolumeJointDef();
    Vec2 center = new Vec2(width/2, height/2);
    radius = 100;
    totalPoints = 20;
    bodyRadius = 12;
    
    for (int i = 0; i < totalPoints; i++) 
    {
      float theta = PApplet.map(i, 0, totalPoints, 0, TWO_PI);
      float x = center.x + radius * sin(theta);
      float y = center.y + radius * cos(theta);
      BodyDef bd = new BodyDef();
      bd.type = BodyType.DYNAMIC;

      bd.fixedRotation = true; 
      bd.position.set(box2d.coordPixelsToWorld(x, y));
      Body body = box2d.createBody(bd);

      CircleShape cs = new CircleShape();
      cs.m_radius = box2d.scalarPixelsToWorld(bodyRadius);

      FixtureDef fd = new FixtureDef();
      fd.shape = cs;
      
      fd.density = 1;

      body.createFixture(fd);
      cvjd.addBody(body);
      skeleton.add(body);
    }
    cvjd.frequencyHz = 10.0f;
    cvjd.dampingRatio = 1.0f;
    box2d.world.createJoint(cvjd);
  }

  void display() 
  {
    beginShape();
    noFill();
    stroke(200);
    strokeWeight(0);
    for (Body b: skeleton) 
    {
      Vec2 pos = box2d.getBodyPixelCoord(b);
      noStroke();
      fill(100,100,100);
      vertex(pos.x/2, pos.y/2);
      vertex(pos.x*2, pos.y*2.3);
    }
    endShape(CLOSE);
 
    for (Body b: skeleton) 
    {
      Vec2 pos = box2d.getBodyPixelCoord(b);
      float x = b.getAngle();
      pushMatrix();
      translate(pos.x/2, pos.y/2);
      rotate(x);
      fill(200,100,200);
      stroke(0);
      strokeWeight(3);
      ellipse(0,0, bodyRadius*2.5, bodyRadius*2.5);
      popMatrix();
    }
    for (Body b: skeleton) 
    {
      Vec2 pos = box2d.getBodyPixelCoord(b);
      float x = b.getAngle();
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(x);
      fill(200,100,200);
      stroke(0);
      strokeWeight(3);
      ellipse(0,0, bodyRadius*2.5, bodyRadius*2.5);
      popMatrix();
    }
  }
}