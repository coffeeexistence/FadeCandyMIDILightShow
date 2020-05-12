import themidibus.*;
import java.util.Map;
import java.util.LinkedList;
import java.util.Iterator;

public class MIDI {
  MidiBus midiBus;
  HashMap<String, Boolean> noteOnState = new HashMap<String, Boolean>();
  HashMap<String, SingleNoteHandling> singleNoteHandlers = new HashMap<String, SingleNoteHandling>();
  LinkedList<MultiNoteHandling> multiNoteHandlers = new LinkedList<MultiNoteHandling>();
  
  public MIDI() {
    midiBus = new MidiBus(this, 0, 1);
    MidiBus.list(); // List all our MIDI devices
    midiBus = new MidiBus(this, 0, 1); // Connect to one of the devices
  }
  
  public void registerSingleNoteHandler(int channel, int note, SingleNoteHandling handler) {
    singleNoteHandlers.put(getNoteId(channel, note), handler);
  }
  
  public void registerMultiNoteHandler(MultiNoteHandling handler) {
    multiNoteHandlers.add(handler);
  }
  
  private boolean getIsNoteOn(String noteId) {
    Boolean alreadyOn = noteOnState.get(noteId);
    if (alreadyOn == null) { return false; }
    return alreadyOn;
  }
  
  String getNoteId(int channel, int pitch) {
    return String.valueOf(channel) + "-" + String.valueOf(pitch);
  }
  
  // This function is called each time a knob, slider or button is pressed
  // in the MIDI controller. It's up to us to do something interesting
  // with the received values.
  void noteOn(int channel, int pitch, int velocity) {
    String noteId = getNoteId(channel, pitch);
    if (getIsNoteOn(noteId)) { return; }
    
    // Trigger multi note handlers
     Iterator<MultiNoteHandling> iterator = multiNoteHandlers.iterator();
     MultiNoteHandling multiNoteHandler;
     while(iterator.hasNext()){
       multiNoteHandler = iterator.next();
       if (multiNoteHandler.isInRange(channel, pitch)) {
         multiNoteHandler.noteOn(pitch, velocity);
       }
     }
    
    // Single note handler
    SingleNoteHandling handler = singleNoteHandlers.get(noteId);
    if (handler != null) { handler.noteOn(velocity); }
    
    // Register note as "on" to prevent duplicates
    noteOnState.put(noteId, true);
  }
  
  void noteOff(int channel, int pitch, int velocity) {
    String noteId = getNoteId(channel, pitch);
    if (!getIsNoteOn(noteId)) { return; }
    
    // Single note handler
    SingleNoteHandling handler = singleNoteHandlers.get(noteId);
    if (handler != null) { handler.noteOff(); }
    
    // Multi note handlers
    Iterator<MultiNoteHandling> iterator = multiNoteHandlers.iterator();
     MultiNoteHandling multiNoteHandler;
     while(iterator.hasNext()){
       multiNoteHandler = iterator.next();
       if (multiNoteHandler.isInRange(channel, pitch)) {
         multiNoteHandler.noteOff(pitch);
       }
     }
    
    // Deregister note from "on" state to allow it to be triggered again
    noteOnState.put(noteId, false);
  }
}
