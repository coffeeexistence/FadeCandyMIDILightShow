public class DrumColorOrchestrator implements MultiNoteHandling {
 private int channel = 1;
 private int pitchRangeStart = 36; // C1
 private color[] colors = {
   color(255,0,0),      // C1  red
   color(200, 50, 200),  // C#1 purple
   color(0,0,0),         // D1  black
   color(0,0,0),         // D#1 black
   color(0,0,0),         // E1  black
   color(0,0,0)          // F1  black
 };
 
 private DoublePedalKicks kicks;
 private Snare snare;
 
 public DrumColorOrchestrator(DoublePedalKicks kicks, Snare snare) {
   this.kicks = kicks;
   this.snare = snare;
 }
  
 boolean isInRange(int channel, int pitch) {
   return channel == this.channel &&
     pitch >= pitchRangeStart &&
     pitch <= pitchRangeStart + colors.length - 1;
 }
 
 // Number from 
 private void setColorScheme(int colorNumber) {
   kicks.setColor(colors[colorNumber]);
 }
 
 void noteOn(int pitch, int velocity) {
   setColorScheme(pitch - pitchRangeStart);
   println(pitch);
 }
 
 void noteOff(int pitch) {}
}
