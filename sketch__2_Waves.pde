int curr_wave_layer = 0; // use as counter to draw the next layer

int max_num_waves = 30; // maximum number of waves per layer
int min_num_waves = 4;

float wave_min_thickness = 1.0; // min thickness of lines
float wave_max_thickness = 6.0;

void waves() {
  if (curr_wave_layer == 0) { // clean slate 
    background(255);
  }

  float max_layer = screen_height*1.0/moments.size(); // maximum thickness of each layer

  if (curr_wave_layer < moments.size() && frameCount%3 == 0) { // if there are still layers to draw and it's been 3 frames
    Moment curr_moment = moments.get(curr_wave_layer); // data for layer we're drawing
    float percentage = (curr_wave_layer+1.0)/moments.size(); // how far into the list of data values we are

    float curr_bottom_y = screen_height - (max_layer*curr_wave_layer); // lower y of rectangular bounds of lowest possible layer - height based on curr layer
    float curr_top_y = curr_bottom_y - max_layer;
    //rect(0, curr_top_y, screen_width, max_layer); // this is the bounding box within which the wave must be contained

    color curr_color = get_color(curr_moment.gsr); // color based on GSR


    int num_waves = Math.round(map_to(curr_moment.bpm, "bpm", min_num_waves, max_num_waves)); // map BPM to number of waves in this layer

    float wave_width = screen_width*1.0/num_waves; // width of each individual wave

    float wave_max_height = max_layer/2.5; // maximum height of wave
    float wave_min_height = wave_max_height/6.0;
    float wave_height = map_to(curr_moment.rpm, "rpm", wave_min_height, wave_max_height); // map RPM to wave height

    float wave_start_x = 0; // the beginning x and y values for the leftmost starting point of the wave
    float wave_start_y = (curr_top_y+curr_bottom_y)/2.0;


    //float wave_thickness = map_to(curr_moment.rpm, "rpm", wave_min_thickness, wave_max_thickness); // map RPM to line thickness
    float wave_thickness = 2.0;

    strokeWeight(wave_thickness);
    stroke(curr_color);
    for (int i = 0; i < num_waves; i++) {
      float prev_x = wave_start_x; // save the previously calculated x and y values in order to draw a line to the new x and y
      float prev_y = wave_start_y + cos(0) * wave_height;
      int num_segments = 20; // number of segments drawn to create the smooth cosine

      for (int j = 0; j <= num_segments; j++) {
        float dot_x = wave_start_x + j * wave_width/num_segments;
        float dot_y = wave_start_y + cos(TWO_PI/num_segments * j) * wave_height;
        line(prev_x, prev_y, dot_x, dot_y);
        prev_x = dot_x;
        prev_y = dot_y;
      }
      wave_start_x += wave_width;
    }

    curr_wave_layer++;
  }
}
