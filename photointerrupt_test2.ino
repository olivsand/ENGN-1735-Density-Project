int val;
const int minFreq = 50;
const int maxFreq = 1000;
const int speakerPin = 8;
void setup() {
Serial.begin(9600); //9600 baud rate, this determines resolution of the measurement bit/s
}
void loop() {
 //for (int i = minFreq; i <= maxFreq; i++) { //outer for loop: iterating frequency, change iteration amount too if needed
    //tone(speakerPin, i, 1000);
   // val = analogRead(A0);
  //Serial.println(val);
  //}
val = analogRead(A0);
Serial.println(val);

}
