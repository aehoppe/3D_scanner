#include <Servo.h>
Servo tilt_servo;
Servo turn_servo;
boolean input_complete = true;
String input = "";
const byte delay_length = 15;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  tilt_servo.attach(5);
  turn_servo.attach(6);
}

void loop() {
  if (input_complete) {
    Serial.println("received input " + input);
    delay(100);
    input = "";
    scan();
    Serial.println("end");
  }
  input_complete = false;
  delay(delay_length);
}

void scan() {
  int turn = 0;
  turn_servo.write(0);
  delay(500);
  for (; turn < 180; turn+=5) {
    turn_servo.write(turn);
    delay(delay_length * 4);
    scan_line(turn);
  }
}

void scan_line(int turn) {
  int tilt = 30;
  for (; tilt >= -20; tilt--) {
    tilt_servo.write(90 + tilt);
    if (tilt == 30) delay(300);
    delay(delay_length);
    Serial.print(String(analogRead(0)) + ", ");
  }
  Serial.println();
}

void serialEvent() {
  while (Serial.available()) {
    char input_char = (char)Serial.read();
    input += input_char;
    if (input_char == '\n') {
      input_complete = true;
    }
  }
}
