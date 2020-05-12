class Point {
  int x;
  int y;
  
  public Point(int x, int y){
    this.x = x;
    this.y = y;
  }
}

public class Snare implements SingleNoteHandling {
  Point topLeftCorner = new Point(0, 0);
  Point topRightCorner = new Point(width, 0);
  Point bottomLeftCorner = new Point(0, 0);
  Point bottomRightCorner = new Point(width, 0);
  int quadHeight = 170;
  
  int amplitude = 100; // 0 to 100
  
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
  
  void draw() {
    noStroke();
    amplitude = decreaseAmplitude(amplitude);
    
    bottomLeftCorner.y = int(map(amplitude, 0, 100, 0, quadHeight));
    bottomRightCorner.y = int(map(amplitude, 0, 100, 0, quadHeight));
    
    // start Y
    fill(127 + amplitude, 255, 255-amplitude/2, map(amplitude, 0, 90, 0, 255));
    //fill(0,0,0);
    quad(
      topLeftCorner.x, topLeftCorner.y,
      topRightCorner.x, topRightCorner.y,
      bottomRightCorner.x, bottomRightCorner.y,
      bottomLeftCorner.x, bottomLeftCorner.y
    );
    
    noFill();
  }
  
  void noteOn(int velocity) {
    if (velocity > 100) { velocity = 100; }
    int newAmplitude = int(map(velocity, 0, 100, 0, 100));
    if (newAmplitude > amplitude){
      amplitude = newAmplitude;
    } else {
      amplitude += 5;
    }
    if (amplitude > 100) { amplitude = 100; }
  }
  
  void noteOff(){}
}
