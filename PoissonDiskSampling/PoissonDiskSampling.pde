//PoissonDisk2D algorithm;
PoissonDisk3D algorithm;
int lastFrameCount;
boolean saveFrames = true;

void setup(){
  size(600, 600, P3D);
  frameRate(10);
  
  //algorithm = new PoissonDisk2D();
  algorithm = new PoissonDisk3D(); //<>//
  
  lastFrameCount = 8;
}

void draw(){
  background(255);
  algorithm.draw(); //<>//
  
  int size = algorithm.update(); //<>//
  println(size);
  if(size > 0 || lastFrameCount > 0){
    if(saveFrames){
      saveFrame("frames/#####.png");
    }
    if(size == 0){
      lastFrameCount--;
    }
  }else{
    noLoop();
  }
  
}