int curr_flower = 0; // use as a counter to draw the next layer of flower petals
float min_petal = 15; // minimum width for an individual petal
float max_petal = 35; // maximum width

void flower() {
  if (curr_flower == 0) { // clean slate 
    background(255);
  }

  // center of the flower
  int x = screen_width/2; 
  int y = screen_height/2;

  int min_diameter = 60; // diameter of smallest ring of petals
  int max_diameter = screen_width-20 - min_diameter; // diameter of largest

  float petal_height = 10;

  noFill();

  if (curr_flower < moments.size() && frameCount%3 == 0) { // if there are still flowers to draw and it's been 3 frames
    float percentage = (curr_flower+1.0)/moments.size(); // how far into the list of data values we are
    float diameter = min_diameter + max_diameter * percentage;
    float radius = diameter/2;
    float circumference = PI * diameter;

    Moment curr_moment = moments.get(curr_flower); // data for layer we're drawing

    color curr_color = get_color(curr_moment.gsr); // color based on GSR
    stroke(curr_color);

    float petal_size = map_to(curr_moment.bpm, "bpm", min_petal, max_petal); // map BPM to size of petals
    int num_petals = Math.round(circumference/petal_size);
    
    float angle_offset = TWO_PI * percentage; // slight offset to make petals look better 
    
    for (int i = 0; i < num_petals; i++) {
      float thickness = map_to(curr_moment.rpm, "rpm", min_thickness, max_thickness); // map RPM to stroke thicknessn
      strokeWeight(thickness);

      float angle = (i/(num_petals/2.0)) * PI + angle_offset;
      float x1 = x + (radius * cos(angle)); // x-coord of one end of bezier curve
      float y1 = y + (radius * sin(angle)); // y-coord of one end of bezier curve

      float next_angle = ((i+1)/ (num_petals/2.0)) * PI + angle_offset;
      float x2 = x + (radius * cos(next_angle)); // x-coord of other end of bezier curve
      float y2 = y + (radius * sin(next_angle)); // y-coord of other end of bezier curve

      float control1X = x + cos(angle) * (radius+petal_height); // curve control point 1
      float control1Y = y + sin(angle) * (radius+petal_height);
      float control2X = x + cos(next_angle) * (radius+petal_height); // curve control point 2
      float control2Y = y + sin(next_angle) * (radius+petal_height); 

      beginShape();
      bezier(x1, y1, control1X, control1Y, control2X, control2Y, x2, y2);
      endShape();
    }

    curr_flower++;
  }
}
