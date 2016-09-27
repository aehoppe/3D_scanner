#include <Servo.h>

Servo servo_1;
volatile float distance;
const float scale = 0.25;

void setup() {
  // put your setup code here, to run once:
  servo_1.attach(9);
  distance = 0;
  pinMode(8, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  distance = analogRead(0);
  servo_1.write(scale * distance);
  Serial.println(distance);
  if (distance >= 500) {
    digitalWrite(8, HIGH);
  } else {
    digitalWrite(8, LOW);
  }
  delay(15);
}
