interface MultiNoteHandling {
  boolean isInRange(int channel, int pitch);
  void noteOn(int pitch, int velocity);
  void noteOff(int pitch);
}
