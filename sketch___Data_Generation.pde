ArrayList<Moment> moments;

// Setting (pretty arbitrary) ranges for BPM, RPM, and GSR
int min_bpm = 60;
int max_bpm = 140;
int min_rpm = 20;
int max_rpm = 80;
int min_gsr = 100;
int max_gsr = 1000;

// Save the smallest and largest generated values for BPM, RPM, and GSR
int smallest_bpm;
int largest_bpm;
int smallest_rpm;
int largest_rpm;
int smallest_gsr;
int largest_gsr;

// Generate more "believably human" random data values for RPM, BPM, and GSR
void generate_data(int num) {
  randomSeed(seed); // random seed to ensure we get the same numbers every time

  // Save the smallest and largest generated values for BPM, RPM, and GSR
  smallest_bpm = max_bpm + 1;
  largest_bpm = min_bpm - 1;
  smallest_rpm = max_rpm + 1;
  largest_rpm = min_bpm - 1;
  smallest_gsr = max_gsr + 1;
  largest_gsr = min_gsr - 1;

  // Positive or negative sign for each value
  int bpm_sign = 1;
  int rpm_sign = 1;
  int gsr_sign = 1;

  moments = new ArrayList<Moment>();

  for (int i = 0; i < num; i++) {
    int bpm = 0;
    int rpm = 0;
    int gsr = 0;

    if (i == 0) { // if this is the first iteration, create completely random values
      bpm = Math.round(random(min_bpm, max_bpm)); 
      rpm = Math.round(random(min_rpm, max_rpm));
      gsr = Math.round(random(min_gsr, max_gsr));
    } else { // Calculate a random BPM, RPM, and GSR, but take into consideration the previous value
      // the previous value
      int last_bpm = moments.get(i-1).bpm;
      int last_rpm = moments.get(i-1).rpm;
      int last_gsr = moments.get(i-1).gsr;

      // by how much each value will change
      int bpm_change = Math.round(random(0, 20));
      int rpm_change = Math.round(random(0, 20));
      int gsr_change = Math.round(random(0, 20));

      // 20% chance that the sign (pos or neg) of each difference will flip
      if (random(0, 1) < 0.2) {
        bpm_sign *= -1;
      }
      if (random(0, 1) < 0.2) {
        rpm_sign *= -1;
      }
      if (random(0, 1) < 0.2) {
        gsr_sign *= -1;
      }

      bpm = last_bpm + (bpm_sign * bpm_change);
      rpm = last_rpm + (rpm_sign * rpm_change);
      gsr = last_gsr + (gsr_sign * gsr_change);

      bpm = Math.min(max_bpm, Math.max(min_bpm, bpm));
      rpm = Math.min(max_rpm, Math.max(min_rpm, rpm));
      gsr = Math.min(max_gsr, Math.max(min_gsr, gsr));
    }

    Moment new_moment = new Moment(bpm, rpm, gsr); // create the new Moment in time
    moments.add(new_moment);

    smallest_bpm = Math.min(smallest_bpm, bpm);
    largest_bpm = Math.max(largest_bpm, bpm);
    smallest_rpm = Math.min(smallest_rpm, rpm);
    largest_rpm = Math.max(largest_rpm, rpm);
    smallest_gsr = Math.min(smallest_gsr, gsr);
    largest_gsr = Math.max(largest_gsr, gsr);
  }
  
  print_to_console();
}

void print_to_console() {
  for (int i = 0; i < moments.size(); i++) {
    int b = moments.get(i).bpm;
    int r = moments.get(i).rpm;
    int g = moments.get(i).gsr;

    // Turn each value (%) into a left-justified (-) string of 7 characters 
    String bpm = "BPM: " + String.format("%-8s", b);
    String rpm = "RPM: " + String.format("%-8s", r);
    String gsr = "GSR: " + String.format("%-8s", g);

    println(bpm + rpm + gsr);
  }
  println("\n===================================\n");
}
