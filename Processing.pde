/* 
  Autor.....: Erik Bartmann
  URL.......: www.erik-bartmann.de
  Version...: 1.0.1
  Date......: 10.08.2014
  Processing: http://www.oreilly.de/catalog/processingger/
  modified..: 28.04.2016, Steffen Reissenweber
*/

import processing.serial.*; // Import Serial-Library

Serial myPort;    // Generation of Port-Instance
Instrument yaw;   // Yaw-Object

float yData; // Yaw Data


void setup() {
  size(400, 400);        // Window-size
  println(Serial.list()); // List of available ports
  myPort = new Serial(this, Serial.list()[1], 9600); // put in your COM-Port-Index
  smooth();
  rectMode(CENTER);  
  // Create instances
  yaw   = new Instrument(200, 200, yawArr, "Winkel");  
}

void draw() {
  background(0);
  float a = radians(mouseX);
  textSize(24);   
  textAlign(LEFT);
  fill(128);  
  text("CMPS11 - Winkelmessung", 50, 30);
 
  yaw.update(yData);   // Yaw-Update
}

void serialEvent(Serial myPort) {
  try {
    if (myPort.available() > 0) {
      String data = myPort.readStringUntil(10);
      if(data != null) {
        String values[] = split(data, ";"); // Split data
        yData = radians(float(values[0]));  // Extract Yaw-data
        
      }  
    }
  } catch(Exception e) {
    println("Serial exception");
  }  
}