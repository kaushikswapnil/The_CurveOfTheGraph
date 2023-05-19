PVector g_Center;
PVector g_Null = new PVector(0.0, 0.0);
float g_RunTime = 0.0f;

void setup()
{
  size(800, 800);
  background(80);
  g_Center = new PVector(width/2, height/2);
}

void draw()
{
  noStroke();
  
  colorMode(RGB, 255);
  fill(80, 60);
  rect(-5, -5, width+5, height+5);
  
  colorMode(HSB, 100);
  float T = g_RunTime * 0.00003f;
  
  {    
    float R = 250.0f;
    
    for (float phase = 0.0; phase < TWO_PI; phase += TWO_PI/10)
    {
      float R_MAX_DEV = 225.0;
      for (float r_dev = 0.0; r_dev < R_MAX_DEV; r_dev += R_MAX_DEV/4)
      {
        float r_dev_t = T * 7f;
        
        for (float r_dev_phase = 0.0; r_dev_phase < TWO_PI; r_dev_phase += TWO_PI/4)
        {
          float r = o(R, r_dev, r_dev_t, TWO_PI, r_dev_phase);
        
          float T_MAX_DEV = 0.5f;
          for (float t_dev = 0.0; t_dev < T_MAX_DEV; t_dev += T_MAX_DEV/3)
          {
            float t_dev_t = T * 3.f;
            float t = o(T, t_dev, t_dev_t, TWO_PI, 0.0);
            PVector p_center = f_r(t, TWO_PI, phase, r, g_Center);
            
            float BASE_DOT_R = 10.0;
            float dot_r_t = T * 5f;
            float dot_r = o(BASE_DOT_R, BASE_DOT_R, dot_r_t, TWO_PI, 0.0);
           
            float hue_phase = r * 0.0075f;
            float hue_t = T * 3.1f;
            float sat_t = T * 1.5f;
            float bright_t = T * 0.37f;
            float hue = o(50, 50, hue_t, TWO_PI, hue_phase); 
            float sat = o(50, 25, sat_t, TWO_PI, 0);
            float bright = o(50, 15, bright_t, TWO_PI, 0);
            fill(hue, sat, bright);
            circle(p_center.x, p_center.y, dot_r); 
          } 
        }
      }
    }
  }
  
  g_RunTime = millis();
}

float o(float val, float dev, float freq, float period, float phase)
{
  return val + (dev * sin(phase + (freq * period)));
}

PVector f_r(float freq, float period, float phase, float amp, PVector disp)
{
  return point_on_circle(phase + (freq * period), amp, disp);
}

PVector point_on_circle(float phi, float radius, PVector center)
{
 return new PVector((radius * cos(phi)) + center.x, (radius * sin(phi)) + center.y); 
}
