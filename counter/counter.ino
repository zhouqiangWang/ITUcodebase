const int ledSwitch = 13; 
const int ledN1 = 11; 
const int ledN2 = 9; 
const int btnReset = 6;
const int btnSwitch = 2;

bool isStart = false;
int stateReset = 0;
int counter = 0;

void setup ()
{
  pinMode (ledSwitch,OUTPUT);
  pinMode (ledN1,OUTPUT);
  pinMode (ledN2,OUTPUT);
  pinMode (btnReset,INPUT);
  pinMode (btnSwitch,INPUT);
  Serial.begin(9600);
  Serial.println("Counter setup");
}

int debounce(int pin) {
  int val;
  int old_val;
  val=digitalRead(pin);
  old_val=val;
  delay(10);
  val=digitalRead(pin);
  if (val == old_val)
  return val;
  else
  return old_val;
}

void loop() {
  int valSwitch = debounce(btnSwitch);
  
  if (valSwitch == HIGH) {
    // start&stop button
    isStart = !isStart;
    Serial.print("state = ");
    Serial.println(valSwitch);
    Serial.print("isStart = ");
    Serial.println(isStart);
  }
  if (isStart) {
    digitalWrite (ledSwitch, HIGH);

    // counter flow
    if (counter % 2 == 1) {
      digitalWrite (ledN1, HIGH);
    } else {
      digitalWrite (ledN1, LOW);
    }

    if (counter / 2 == 1) {
      digitalWrite (ledN2, HIGH);
    } else {
      digitalWrite (ledN2, LOW);
    }

    counter = (counter+1) % 4;
  } else {
    digitalWrite (ledSwitch, LOW);
  }

  // reset button
  int valReset = debounce(btnReset);
  if (valReset == HIGH) {
    digitalWrite (ledN1, LOW);
    digitalWrite (ledN2, LOW);
    counter = 0;
  }
  delay(950);
}
