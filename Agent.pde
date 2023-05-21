abstract class VariableHandler
{
  abstract String Name();
  abstract String Value();
  void DecreaseValue() {}
  void IncreaseValue() {}
  void IncreaseChangeMultiplier() {}
  void DecreaseChangeMultiplier() {}
  String ChangeMultiplier() { return ""; }
  String AsString() { return Name() + " " + ChangeMultiplier() + " : " + Value(); }
}

class VariableHandlerT_delta extends VariableHandler
{
  float ChangeDelta = 0.0001f;
  float Min = 0.0f;
  int DeltaMultiplier = 1;
  
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };

  String Name()
  {
    return "T_delta";
  }

  String Value()
  {
    return T_delta.toString();
  }

  void DecreaseValue()
  {
    float new_val = T_delta - (ChangeDelta * DeltaMultiplier);
    if (new_val >= Min)
    {
      T_delta = new_val;
    }
  }
  void IncreaseValue()
  {
    T_delta += (DeltaMultiplier * ChangeDelta);
  }
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
}

class VariableHandler_T extends VariableHandler
{
  float ChangeDelta = 0.000f;

  String Name()
  {
    return "T";
  }

  String Value()
  {
    return T.toString();
  }

  void DecreaseValue()
  {
    T -= ChangeDelta;
  }
  void IncreaseValue()
  {
    T += ChangeDelta;
  }
}

class VariableHandler_R extends VariableHandler
{
  float ChangeDelta = 0.1f;
  
  int DeltaMultiplier = 1;
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };

  String Name(){ return "R"; }

  String Value()
  {
    return R.toString();
  }

  void DecreaseValue()
  {
    R -= ChangeDelta * DeltaMultiplier;
  }
  void IncreaseValue()
  {
    R += ChangeDelta * DeltaMultiplier;
  }
}

class VariableHandler_INNER_R1 extends VariableHandler
{
  float ChangeDelta = 0.1f;
  int DeltaMultiplier = 1;
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };
  String Name() { return "INNER_R1"; }
  String Value() { return INNER_R1.toString(); }
  void DecreaseValue() { INNER_R1 -= ChangeDelta * DeltaMultiplier; }
  void IncreaseValue() { INNER_R1 += ChangeDelta * DeltaMultiplier; }
}

class VariableHandler_INNER_R2 extends VariableHandler
{
  float ChangeDelta = 0.1f;
  int DeltaMultiplier = 1;
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };
  String Name() { return "INNER_R2"; }
  String Value() { return INNER_R2.toString(); }
  void DecreaseValue() { INNER_R2 -= ChangeDelta * DeltaMultiplier; }
  void IncreaseValue() { INNER_R2 += ChangeDelta * DeltaMultiplier; }
}

class VariableHandler_INNER_R3 extends VariableHandler
{
  float ChangeDelta = 0.1f;
  int DeltaMultiplier = 1;
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };
  String Name() { return "INNER_R3"; }
  String Value() { return INNER_R3.toString(); }
  void DecreaseValue() { INNER_R3 -= ChangeDelta * DeltaMultiplier; }
  void IncreaseValue() { INNER_R3 += ChangeDelta * DeltaMultiplier; }
}
class VariableHandler_INNER_R4 extends VariableHandler
{
  float ChangeDelta = 0.1f;
  int DeltaMultiplier = 1;
  void IncreaseChangeMultiplier() { DeltaMultiplier++;}
  void DecreaseChangeMultiplier() {DeltaMultiplier--;}
  String ChangeMultiplier() { return Integer.toString(DeltaMultiplier); };
  String Name() { return "INNER_R4"; }
  String Value() { return INNER_R4.toString(); }
  void DecreaseValue() { INNER_R4 -= ChangeDelta * DeltaMultiplier; }
  void IncreaseValue() { INNER_R4 += ChangeDelta * DeltaMultiplier; }
}

class DevPanel
{
  ArrayList<VariableHandler> Handlers;
  int CurrentHandler = 0;
  boolean Draw = true;
  boolean LockMode = false; //only handles unlock mode input

  DevPanel()
  {
    Handlers = new ArrayList<VariableHandler>();
    Handlers.add(new VariableHandlerT_delta());
    Handlers.add(new VariableHandler_T());
    Handlers.add(new VariableHandler_R());
    Handlers.add(new VariableHandler_INNER_R1());
    Handlers.add(new VariableHandler_INNER_R2());
    Handlers.add(new VariableHandler_INNER_R3());
    Handlers.add(new VariableHandler_INNER_R4());
  }

  void Update()
  {
    if (Draw)
    {
      colorMode(RGB, 255);
      if (LockMode)
      {
       fill(255, 0, 0); 
      }
      else
      {
       fill(255, 255, 255); 
      }
      
      float TEXT_SIZE = 15.0;
      textSize(TEXT_SIZE);
      float Y_POS = 20.0;
      float X_POS = 20.0;
      VariableHandler var_hndlr = Handlers.get(CurrentHandler);
      text(var_hndlr.AsString(), X_POS, Y_POS);
    }

    if (g_RECORDING)
    {
      saveFrame("frames/####.tif");
    }
  }

  void HandleKeyPress()
  {
    boolean lock_mode_change_needed = key == 'l' || key == 'L';
    if (lock_mode_change_needed)
      LockMode = !LockMode; //<>//
    
    if (LockMode == true)
      return;
    
    if (key == CODED)
    {
      if (keyCode == RIGHT)
      {
        Handlers.get(CurrentHandler).IncreaseValue();
      } else if (keyCode == LEFT)
      {
        Handlers.get(CurrentHandler).DecreaseValue();
      } else if (keyCode == UP)
      {
        CurrentHandler = (CurrentHandler+1)%Handlers.size();
      } else if (keyCode == DOWN)
      {
        CurrentHandler = CurrentHandler-1;
        if (CurrentHandler < 0)
        {
         CurrentHandler = Handlers.size() - 1; 
        }
      }

      return;
    }

    switch (key)
    {
    case 'r':
    case 'R':
      g_RECORDING = !g_RECORDING;
      break;
    case '+':
      Handlers.get(CurrentHandler).IncreaseChangeMultiplier();
      break;
    case '-':
      Handlers.get(CurrentHandler).DecreaseChangeMultiplier();
      break;
    }
  }
}
