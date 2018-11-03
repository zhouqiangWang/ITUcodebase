#include <Servo.h>

const int leftTrigPin = 10;
const int leftEchoPin = 11;

const int rightTrigPin = 5;
const int rightEchoPin = 6;

const int frontTrigPin = 7;
const int frontEchoPin = 8;

Servo servoLeft;
Servo servoRight;
void setup() {
  // initialize serial communication:
//  tone(4, 3000, 1000);
  Serial.begin(9600);
  servoLeft.attach(13); // Attach left signal to pin 13 
  servoRight.attach(12); // Attach left signal to pin 12
  pinMode(leftTrigPin, OUTPUT);
  pinMode(rightTrigPin, OUTPUT);
  pinMode(frontTrigPin, OUTPUT);

  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  pinMode(leftEchoPin, INPUT);
  pinMode(rightEchoPin, INPUT);
  pinMode(frontEchoPin, INPUT);
//  servoLeft.writeMicroseconds(1500); // Left wheel counterclockwise
//  servoRight.writeMicroseconds(1500); // Right wheel clockwise
}

void loop()
{
  // establish variables for duration of the ping, 
  // and the distance result in inches and centimeters:
  long durationLeft, inches, cmLeft;
  long durationRight, cmRight, durationFront, cmFront;
//  servoLeft.writeMicroseconds(1700); // Left wheel counterclockwise
//  servoRight.writeMicroseconds(1300); // Right wheel clockwise

  // The sensor is triggered by a HIGH pulse of 10 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:

  digitalWrite(leftTrigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(leftTrigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(leftTrigPin, LOW);
  durationLeft = pulseIn(leftEchoPin, HIGH);

  delayMicroseconds(100);
  digitalWrite(rightTrigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(rightTrigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(rightTrigPin, LOW);
  durationRight = pulseIn(rightEchoPin, HIGH);

  delayMicroseconds(100);
  digitalWrite(frontTrigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(frontTrigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(frontTrigPin, LOW);
  durationFront = pulseIn(frontEchoPin, HIGH);

//  
//  Serial.print("durationRight: ");
//  Serial.print(durationRight);

  // convert the time into a distance
//  inches = microsecondsToInches(durationLeft);
  cmLeft = microsecondsToCentimeters(durationLeft);
  cmRight = microsecondsToCentimeters(durationRight);
  cmFront = microsecondsToCentimeters(durationFront);
  
//  Serial.print(inches);
  Serial.print("left(cm): ");
  Serial.print(cmLeft);
  Serial.print(", right(cm): ");
  Serial.print(cmRight);
  Serial.print(", front(cm): ");
  Serial.print(cmFront);
  Serial.println();
  if (cmFront < 15) {
    if (cmRight > 15) {
      turnRight(2900);
    } else if (cmLeft > 15) {
      turnLeft(2900);
    }
  } else {
    forward(1000);
  }
}

long microsecondsToInches(long microseconds)
{
  // According to Parallax's datasheet for the PING))), there are
  // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
  // second).  This gives the distance travelled by the ping, outbound
  // and return, so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}

void forward(int time) // Forward function
{
  servoLeft.writeMicroseconds(1700); // Left wheel counterclockwise
  servoRight.writeMicroseconds(1300); // Right wheel clockwise
  delay(time); // Maneuver for time ms
}
void turnLeft(int time) // Left turn function
{
  Serial.println("turn left");
  servoLeft.writeMicroseconds(1300); // Left wheel clockwise
  servoRight.writeMicroseconds(1300); // Right wheel clockwise
  delay(time); // Maneuver for time ms
}
void turnRight(int time) // Right turn function
{
  Serial.println("turn Right");
  servoLeft.writeMicroseconds(1700); // Left wheel counterclockwise
  servoRight.writeMicroseconds(1700); // Right wheel counterclockwise
  delay(time); // Maneuver for time ms
}
void backward(int time) // Backward function
{
  servoLeft.writeMicroseconds(1300); // Left wheel clockwise
  servoRight.writeMicroseconds(1700); // Right wheel counterclockwise
  delay(time); // Maneuver for time ms
}
void disableServos() // Halt servo signals
{
  servoLeft.detach(); // Stop sending servo signals
  servoRight.detach();
}
