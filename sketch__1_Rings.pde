int curr_ring = 0; // use as a counter to draw the next layer
int min_dashes = 10; // minimum number of dashes we can use to draw the circle
int max_dashes = 40; // maximum dashes
float min_thickness = 1; // minium thickness of the circle
float max_thickness = 5; // maximum thickness

void rings() {
  if (curr_ring == 0) { // clean slate 
    background(255);
  }

  // center of the rings
  int x = screen_width/2; 
  int y = screen_height/2;

  int min_diameter = 60;
  int max_diameter = screen_width-20 - min_diameter; // radius of largest ring

  noFill();

  if (curr_ring < moments.size() && frameCount%3 == 0) { // if there are still flowers to draw and it's been 3 frames
    Moment curr_moment = moments.get(curr_ring); // data for layer we're drawing
    float percentage = (curr_ring+1.0)/moments.size(); // how far into the list of data values we are
    int diameter = min_diameter + Math.round(max_diameter * percentage);

    // color based on GSR
    color curr_color = get_color(curr_moment.gsr);
    stroke(curr_color);
    strokeCap(ROUND);

    int num_dashes = Math.round(map_to(curr_moment.bpm, "bpm", min_dashes, max_dashes)); // map BPM to number of dashes used to draw the ring

    float angleOffset = TWO_PI * percentage; // add a little offset to the beginning angle so that every layer doesn't start at the same place
    for (int i = 0; i < num_dashes; i++) {
      float angle = (i/(num_dashes/2.0)) * PI + angleOffset;
      float arc_length = TWO_PI/(num_dashes*2);

      // stroke thickness based on RPM
      float thickness = map_to(curr_moment.rpm, "rpm", min_thickness, max_thickness); // map RPM to stroke thickness
      strokeWeight(thickness);
      arc(x, y, diameter, diameter, angle, angle + arc_length);
    }

    curr_ring++;
  }
}
