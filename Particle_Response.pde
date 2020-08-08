
import processing.sound.*; 
import oscP5.*;
import netP5.*;

SoundFile soundfile;
SoundFile[] soundFiles;
// randomly select a sound and play it
int selectSound = (int) random(3);

AudioIn in;
Reverb reverb;
Delay delay;

OscP5 oscP5;

PFont f;

ParticleSystem ps;
PImage sprite;  

String probability;
int prediction;
String classType;

void setup() {
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("texture.png");
  ps = new ParticleSystem(10000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
  
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  oscP5 = new OscP5(this, 1337);
  
   // create the input stream
  in = new AudioIn(this, 0);
  // create a reverb effect
  reverb = new Reverb(this);
  
  // create a delay effect
  delay = new Delay(this);
    
  // start the input stream
  in.play();

  // Patch the delay
  delay.process(in, 5);
  delay.time(0.5);
  
  playSound();
}      

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/neuralnet2")) {
    prediction = theOscMessage.get(0).intValue();
    println(prediction);
    probability = theOscMessage.get(1).toString();
    println(probability);
    classType = theOscMessage.get(2).toString();
    println(classType);  
  }
}

void draw () {
  background(0);
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
  
  fill(204, 102, 0);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
  
  textFont(f,16);                  // STEP 3 Specify font to be used
  fill(255);   // STEP 4 Specify font color 
  
  //text(probability,10,100);       // STEP 5 Display Text
  
  float playbackSpeed = map(mouseX, 0, width, 0.25, 4.0);
  soundFiles[prediction].rate(playbackSpeed);

  // Map mouseY from 0.2 to 1.0 for amplitude
  float amplitude = map(mouseY, 0, width, 0.2, 1.0);
  soundFiles[prediction].amp(amplitude);

  // Map mouseY from -1.0 to 1.0 for left to right panning
  float panning = map(mouseY, 0, height, -1.0, 1.0);
  soundFiles[prediction].pan(panning);
}

void playSound() {
  soundFiles = new SoundFile[3];  // 3 SoundFiles - 1 for each sound
  soundFiles[0] = new SoundFile(this, "hat1.wav");
  soundFiles[1] = new SoundFile(this, "kick1.wav");
  soundFiles[2] = new SoundFile(this, "snare1.wav");

  // create a delay effect
  delay = new Delay(this);
  // Patch the delay
  delay.process(in, 5);
  delay.time(0.5);
  print(selectSound);
  soundFiles[prediction].loop(); 
}
