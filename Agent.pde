class Agent
{
 PVector Position;
 PVector Velocity;
 PVector Acceleration;
 float Mass;
 
 Agent()
 {
   Position = new PVector(random(0, width), random(0, height));
   Velocity = PVector.random2D();
   Acceleration = new PVector(0.0, 0.0);
   Mass = 1.0f;
 }
 
 Agent(PVector pos, PVector vel)
 {
   Position = pos;
   Velocity = vel;
   Acceleration = new PVector(0.0, 0.0);
   Mass = 1.0f;
 }
 
 void Update()
 {
  UpdatePhysics(); 
 }
 
 void UpdatePhysics()
 {
  Velocity.add(Acceleration);
  Position.add(Velocity);
  Acceleration.mult(0);
 }
 
 void Draw()
 {
  fill(255, 0, 0);
  circle(Position.x, Position.y, 10.0); 
 }
}
