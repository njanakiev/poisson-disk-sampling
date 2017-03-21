class PoissonDisk3D{
  float r, R;
  int tries;
  PVector[][][] grid;
  ArrayList<PVector> activeList;
  int rows, cols, layers;
  float w;
  float size;
  
  
  PoissonDisk3D(){
    r = 22;
    tries = 30;
    size = 0.5*max(width, height);
    w = r/sqrt(3);
    rows = floor(size/w);
    cols = floor(size/w);
    layers = floor(size/w);
    activeList = new ArrayList<PVector>();
    
    // Initialize grid
    grid = new PVector[cols][rows][layers];
    for(int i=0; i<rows; i++){ for(int j=0; j<cols; j++){ for(int k=0; k<layers; k++){
      grid[i][j][k] = null;
    }}}
    
    // Add first point
    float x = size/2, y = size/2, z = size/2;
    PVector pos = new PVector(x, y, z);
    activeList.add(pos);
    grid[floor(x / w)][floor(y / w)][floor(z / w)] = pos;
    
    R = size/2;
  }
  
  
  int update(){
    for(int total=0; total<25; total++){
      if(activeList.size() > 0){
        int randIdx = floor(random(activeList.size()));
        PVector pos = activeList.get(randIdx); boolean found = false;
        for(int n=0; n<tries; n++){
          PVector sample = PVector.random3D();
          sample.setMag(random(r, 2*r));
          sample.add(pos);
          int col   = floor(sample.x / w);
          int row   = floor(sample.y / w);
          int layer = floor(sample.z / w);
          
          boolean insideSphere = (size/2 - sample.x)*(size/2 - sample.x) + 
                                 (size/2 - sample.y)*(size/2 - sample.y) + 
                                 (size/2 - sample.z)*(size/2 - sample.z) < R*R;
          
          // Check all neighboring cells
          boolean insideGrid = 0 <= row && row < rows && 
                               0 <= col && col < cols && 
                               0 <= layer && layer < layers;
          if(insideSphere && insideGrid && grid[row][col][layer] == null){
            boolean ok = true;
            for(int i=-1; i<=1; i++){ for(int j=-1; j<=1; j++){ for(int k=-1; k<=1; k++){
              if(0 <= row + i && row + i < rows && 
                 0 <= col + j && col + j < cols &&
                 0 <= layer + k && layer + k < layers){
                PVector neighbor = grid[row + i][col + j][layer + k];
                if(neighbor != null){
                  float d = PVector.dist(sample, neighbor);
                  if(d < r){ ok = false; }
                }
              }
            }}}
            if(ok){
              found = true;
              grid[row][col][layer] = sample;
              activeList.add(sample);
              break;
            }
          }
        }
        if(!found){ activeList.remove(randIdx); }
      }
    }
    return activeList.size();
  }
  
  
  void draw(){
    directionalLight(300, 300, 220, -1, -1, 0.5);
    directionalLight(200, 200, 180, 0.5, 0.5, -1);
    ambientLight(60, 60, 60);
    noStroke();
    for(PVector point : activeList){
      pushMatrix();
      float offset = size/2;
      translate(offset + point.x, offset + point.y, point.z);
      sphere(r/2);
      popMatrix();
    }
  }
}