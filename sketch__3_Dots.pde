int curr_dot_layer = 0; // use as counter to draw the next layer

int max_num_dots = 3000;
int min_num_dots = 300;

float min_dot_size = 1.0;
float max_dot_size = 4.0;

void dots() {
  if (curr_dot_layer == 0) { // clean slate 
    background(255);
  }

  float max_layer = screen_height*1.0/moments.size(); // maximum thickness of each layer

  if (curr_dot_layer < moments.size() && frameCount%3 == 0) { // if there are still layers to draw and it's been 3 frames
    Moment curr_moment = moments.get(curr_dot_layer); // data for layer we're drawing
    float percentage = (curr_dot_layer+1.0)/moments.size(); // how far into the list of data values we are

    float curr_bottom_y = screen_height - (max_layer*curr_dot_layer); // lower y of rectangular bounds of lowest possible layer - height based on curr layer
    float curr_top_y = curr_bottom_y - max_layer;
    //rect(0, curr_top_y, screen_width, max_layer); // this is the bounding box within which the wave must be contained

    color curr_color = get_color(curr_moment.gsr); // color based on GSR

    int num_dots = Math.round(map_to(curr_moment.bpm, "bpm", min_num_dots, max_num_dots)); // map BPM to number of dots we want in this layer

    float dot_size = map_to(curr_moment.rpm, "rpm", min_dot_size, max_dot_size); // map RPM to size of the dots in the layer

    for (int i = 0; i < num_dots; i++) {
      float dot_x = random(0, screen_width);
      float dot_y = random(curr_top_y, curr_bottom_y);
      fill(curr_color);
      noStroke();
      ellipse(dot_x, dot_y, dot_size, dot_size);
    }


    curr_dot_layer++;
  }
}
