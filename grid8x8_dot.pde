LightGrid lightGrid;
DrumColorOrchestrator drumColorOrchestrator;
DoublePedalKicks kicks;
Snare snare;
MIDI midi;

void setup() {
  frameRate(65);
  size(1280, 640);
  lightGrid = new LightGrid();
  midi = new MIDI();

  kicks = new DoublePedalKicks();
  midi.registerSingleNoteHandler(0, 36, kicks);
  
  snare = new Snare();
  midi.registerSingleNoteHandler(0, 37, snare);
  
  drumColorOrchestrator = new DrumColorOrchestrator(kicks, snare);
  midi.registerMultiNoteHandler(drumColorOrchestrator);
}


int frame = 0;
void draw() {
  //frame++;
  //if(frame % 60 == 0) {
  //  println(frameRate);
  //}
  
  background(0);
  //filter(INVERT);
  pushMatrix();
  translate(0, 110);
  snare.draw();
  popMatrix();
  
  kicks.draw();
  lightGrid.sendScreenToLightGrid();
}
