// The BPM, RPM, and GSR at a specific moment in time
class Moment {
  int bpm; // average heart rate
  int rpm; // respiration
  int gsr; // galvanic sweat response

  Moment(int bpm, int rpm, int gsr) {
    this.bpm = bpm;
    this.rpm = rpm;
    this.gsr = gsr;
  }
}
