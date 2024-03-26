#include <Arduino.h>

#define PWM 11
#define InPin 13

void setup() {
  // put your setup code here, to run once:
  pinMode(PWM, OUTPUT);
  pinMode(InPin, INPUT);
}

void loop() {
  if(digitalRead(InPin)){
    analogWrite(PWM, 127);
  }
  else{
    analogWrite(PWM, 0);
  }

}
