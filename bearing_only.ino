

/* 
  Autor.....: (C) 2014 Erik Bartmann <Erik.Bartmann@yahoo.de>
  URL.......: 
  Version...: 0.0.1
  Date......: 2014
  modified..: 02.02.2016
  Autor.....: Steffen Reißenweber
*/

#include <Wire.h>        // Use I2C library
#include <avr/wdt.h>     // watchdog Timer
#define CMPS10Addr  0x60 // Addresse des CMPS10



void setup() {
  Serial.begin(9600);
  Wire.begin(); // Connect to I2C  
  
  
}

void loop() {
  byte byteHigh, byteLow; // byteHigh / byteLow für Bearing
  int bearing;            // Bearing
  wdt_enable(WDTO_500MS);   //watchdog 500 ms

  Wire.beginTransmission(CMPS10Addr); // Kommunikation mit CMPS10
  Wire.write(2);                      // Start Register (2)
  Wire.endTransmission();
  Wire.requestFrom(CMPS10Addr , 2); // Abfrage von 2 Bytes vom CMPS10
  while (Wire.available() < 2); // Warten, bis 2 Bytes verfügbar
  byteHigh = Wire.read();       // High-Byte für Bearing speichern
  byteLow = Wire.read();        // Low-Byte für Bearing speichern
  
  bearing = ((byteHigh << 8) + byteLow)  ; // Bearing berechnen
  
  sendData(bearing);             // Daten versenden
  wdt_reset();
}

// Receive serial-data
void sendData(float bearing) {
  String data = String((bearing) /10) + ";";
  Serial.println(data);
 
}



 

