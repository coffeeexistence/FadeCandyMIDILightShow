public class LightGrid {
  OPC opc;
  
  
  public LightGrid() {
    opc = new OPC("127.0.0.1", 7890);
    float leftAngle = PI;
    float rightAngle = -HALF_PI;
    float centerY = height/2.0;
    float ledSpacing = height / 11.0;
    float stripSpacing = ledSpacing;
    float relativeDistance = 0.32;
    opc.ledGrid8x8(0, width*relativeDistance, centerY, ledSpacing, stripSpacing, leftAngle, false);
    opc.ledGrid8x8(64, width-(width*relativeDistance)+1, centerY, ledSpacing, stripSpacing, rightAngle, false);
  }
  
  public void sendScreenToLightGrid() {
    opc.draw();
  }
}
