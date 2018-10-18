#include <Servo.h>
Servo servoLeft;
Servo servoRight;
void setup() {
  tone(4, 3000, 1000);
  delay(1000);
  servoLeft.attach(13); // Attach left signal to pin 13 
  servoRight.attach(12); // Attach left signal to pin 12 
  servoLeft.writeMicroseconds(1532); // 1.5 ms stay still sig, pin 13
  servoRight.writeMicroseconds(1479);// 1.5 ms stay still sig, pin 12
}

void loop() {
  // put your main code here, to run repeatedly:

}
void disableServos()
{
  servoLeft.detach();
  servoRight.detach();
}
