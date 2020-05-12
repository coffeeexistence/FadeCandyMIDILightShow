
public class DoublePedalKicks implements SingleNoteHandling {
  PImage dot;
  PImage ring;
  int amplitude0 = 100; // 0 to 100
  int amplitude1 = 100; // 0 to 100
  int screenWidth;
  int screenHeight;
  Boolean doublePedalSwitch = true;
  float centerY = height/2;
  
  // default color
  color colorValue = color(255, 50, 0);
  
  public DoublePedalKicks() {
    this.dot = loadImage("ring.png");
    this.ring = loadImage("ring.png");
  }
  
  Integer decreaseAmplitude(int value) {
    if (value > 99) {
      return value - 1;
    } else if (value > 80) {
      return value - 5;
    } else if (value > 50) {
      return value - 6;
    } else if (value > 4) {
      return value - 4;
    } else if (value >= 1) {
      return value - 1;
    }
    return value;
  }
  
  public void setColor(color colorValue) {
    this.colorValue = colorValue;
  }
  
  
  color getInnerColorFromAmplitude(int amplitude) {
    return colorValue;
    //return color(0, 0, 0, 255);
  }
  
  color getOuterColorFromAmplitude(int amplitude) {
    int minAlpha = 200;
    return color(red(colorValue), green(colorValue), blue(colorValue), minAlpha + (amplitude * 2.55) - minAlpha);
    //return color(0, 0, 0, 255);
  }
  
  void draw() {
    amplitude0 = decreaseAmplitude(amplitude0);
    amplitude1 = decreaseAmplitude(amplitude1);
    ellipseMode(CENTER);
    
    if(amplitude0 > 3) {
      //tint(255,255,255, amplitude0 * 3);
      //float dotSize = (height*0.8) * (amplitude0 / 100.0);
      //float dotX = 0.33 * width - dotSize/2;
      //image(dot, dotX, centerY - dotSize/2, dotSize, dotSize);
      fill(getOuterColorFromAmplitude(amplitude0));
      float ringSize = (height*0.7) * (amplitude0 / 100.0);
      circle(0.33 * width, centerY, ringSize);
      fill(getInnerColorFromAmplitude(amplitude0));
      circle(0.33 * width, centerY, ringSize/3);
    }
    
    if(amplitude1 > 3) {
      //tint(255,255,255, amplitude1 * 3);
      
      //float ringSize = (height*0.8) * (amplitude1 / 100.0);
      //float ringX = 0.66 * width - ringSize/2;
      //image(ring, ringX, centerY - ringSize/2, ringSize, ringSize);
      fill(getOuterColorFromAmplitude(amplitude1));
      float ringSize = (height*0.7) * (amplitude1 / 100.0);
      circle(0.66 * width, centerY, ringSize);
      fill(getInnerColorFromAmplitude(amplitude1));
      circle(0.66 * width, centerY, ringSize/3);
    }
    
    noFill();
    noTint();
  }
  
  void noteOn(int velocity) {
    amplitude0 = doublePedalSwitch == true ? 100 : 0;
    amplitude1 = doublePedalSwitch == true ? 0 : 100;
    doublePedalSwitch = !doublePedalSwitch;
  }
  
  void noteOff(){}
}
