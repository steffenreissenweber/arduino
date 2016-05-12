class Instrument {
  // fields
  int xPos, yPos;
  int[][] craft;
  String dType;
  final int radius = 220;
  final int strokeWeightPanel    = 2;
  final int strokeWeightAircraft = 3;
  
  // ctor
  Instrument(int x, int y, int[][] shape, String type) {
    xPos = x; yPos = y;
    dType = type; 
    craft = shape; 
  }
  
  // update
  void update(float angle) {
    // Circle
    strokeWeight(strokeWeightPanel);
    stroke(255, 255, 0);
    fill(255, 255, 0, 40);
    ellipse(xPos, yPos, radius, radius);
    rect(xPos, yPos + 150, 150, 40);
    // Aircraft
    strokeWeight(strokeWeightAircraft);
    pushMatrix();
    translate(xPos, yPos);
    rotate(angle);
    stroke(255, 0, 0);
    fill(255, 0, 0, 80);
    beginShape();
    for(int i=0; i<craft.length; i++) 
      vertex(craft[i][0],craft[i][1]);  
    endShape();
    popMatrix();
    // Ticks
    stroke(0, 100, 255);
    for (int i=0; i<360; i+=30) {
      pushMatrix();
      translate(xPos, yPos);
      rotate(radians(i));
      line(100, 0, 120, 0);  
      popMatrix();
    }
    // Text    
    textSize(32);   
    fill(0, 255, 0);
    textAlign(CENTER);
    text((angle*180/PI) , xPos + 0, yPos + 163);
    fill(200);  
  }
}