class PoissonDisk2D{
  float r;
  int k;
  PVector[][] grid;
  ArrayList<PVector> activeList;
  int rows, cols;
  float w;
  
  
  PoissonDisk2D(){
    r = 15;
    k = 30;
    w = r/sqrt(2);
    cols = floor(width/w);
    rows = floor(height/w);
    activeList = new ArrayList<PVector>();
    
    // Initialize grid
    grid = new PVector[cols][rows];
    for(int i=0; i<rows; i++){ for(int j=0; j<cols; j++){
      grid[i][j] = null;
    }}
    
    // Add first point
    float x = width/2, y = height/2;
    PVector pos = new PVector(x, y);
    activeList.add(pos);
    grid[floor(y / w)][floor(x / w)] = pos;
  }
  
  
  int update(){
    for(int total=0; total<25; total++){
      if(activeList.size() > 0){
        int randIdx = floor(random(activeList.size()));
        PVector pos = activeList.get(randIdx); boolean found = false;
        for(int n=0; n<k; n++){
          PVector sample = PVector.random2D();
          sample.setMag(random(r, 2*r));
          sample.add(pos);
          int col = floor(sample.x / w);
          int row = floor(sample.y / w);
          
          if(0 <= col && col < cols && 0 <= row && row < rows && grid[row][col] == null){
            boolean ok = true;
            for(int i=-1; i<=1; i++){ for(int j=-1; j<=1; j++){
              if(0 <= col + i && col + i < cols && 0 <= row + j && row + j < rows){
                PVector neighbor = grid[row + j][col + i];
                if(neighbor != null){
                  float d = PVector.dist(sample, neighbor);
                  if(d < r){ ok = false; }
                }
              }
            }}
            if(ok){
              found = true;
              grid[row][col] = sample;
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
    strokeWeight(1.3);
    stroke(0);
    fill(0);
    for(int i=0; i<rows; i++){ for(int j=0; j<cols; j++){
      PVector point = grid[i][j];
      if(point != null){
        ellipse(point.x, point.y, r/2, r/2);
      }
    }}
    
    fill(255);
    for(PVector point : activeList){
      ellipse(point.x, point.y, r/2, r/2);
    }
  }
}