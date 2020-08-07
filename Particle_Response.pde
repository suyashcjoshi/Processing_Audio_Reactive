
import processing.sound.*; 

SoundFile soundfile;
SoundFile[] soundFiles;
// randomly select a sound and play it
int selectSound = (int) random(3);

ParticleSystem ps;
PImage sprite;  

void setup() {
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("texture.png");
  ps = new ParticleSystem(10000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
  
  // Load a soundfile
  // load samples from the "Data" directory
  soundFiles = new SoundFile[3];  // 3 SoundFiles - 1 for each sound
  soundFiles[0] = new SoundFile(this, "hat1.wav");
  soundFiles[1] = new SoundFile(this, "kick1.wav");
  soundFiles[2] = new SoundFile(this, "snare1.wav");
  

  
} 

void draw () {
  background(0);
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
  
  delay(100);
  soundFiles[selectSound].play();
  
  fill(204, 102, 0);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
  

  
}
