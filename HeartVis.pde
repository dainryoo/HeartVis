int num_moments = 30; // number of data points we want to generate
int seed = 1; // use for randomSeed
boolean generate_flag = false; // generate new data if this is true

int state; // what variation of the visualization we want to view

int screen_height = 640; // height of screen
int screen_width = 640;// width of screen

void setup() {
  size(640, 640);
  state = 0;
  generate_data(num_moments);
}

void draw() {
  switch(state) {
  case 0:    
    flower();
    break;
  case 1:
    rings();
    break;
  case 2:
    waves();
    break;
  case 3:
    dots();
    break;
  default:
    background(0);
    break;
  }
}

void keyPressed() {
  switch(key) {
  case 'r':
    reset();
    break;
  case '0':
    reset();
    state = 0;
    break;
  case '1':
    reset();
    state = 1;
    break;
  case '2':
    reset();
    state = 2;
    break;
  case '3':
    reset();
    state = 3;
    break;
  case 'n':
    seed++;
    generate_data(num_moments);
    reset();
    break;
  default:
    break;
  }
}

void reset() {
  curr_flower = 0;
  curr_ring = 0;
  curr_wave_layer = 0;
  curr_dot_layer = 0;
}

// https://rosettacode.org/wiki/Map_range
float map_to(int value, String type, float min, float max) {
  float result = 0;
  switch(type) {
  case "bpm":
    result = min + Math.round((value*1.0-smallest_bpm)*(max-min)/(largest_bpm-smallest_bpm));
    break;
  case "rpm":
    result = min + Math.round((value*1.0-smallest_rpm)*(max-min)/(largest_rpm-smallest_rpm));
    break;
  case "gsr":
    result = min + Math.round((value*1.0-smallest_gsr)*(max-min)/(largest_gsr-smallest_gsr));
    break;
  default:
    break;
  }

  return result;
}
