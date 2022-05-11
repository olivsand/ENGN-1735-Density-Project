const double freqmax = 10000.0;
const double freqmin = 45;
const int number = 89000;  //this was done based on trial and error, to get maximum possible sweep time
int photointerrData;

void freqSweepPin11(double minF, double maxF, int nbSteps)
{
  unsigned long halfONperiod, halfOFFperiod;
  double stepF = (maxF - minF) / (nbSteps - 1.0); //next frequency; calculated this way to allow for an end case
  double frequency = minF; //we start at the minimum frequency and go upwards

  for (int i = 1; i <= nbSteps; i++) {
    // here, I fine-tuned the half periods so that when it skips to the 'next' frequency it takes into account
    // anylost time spent in executing the function or looping the for loop (negligible but i saw another code do something similar)
    halfONperiod = (unsigned long) ((double) 500000.0 / frequency);
    halfOFFperiod = halfONperiod;

    // PORTB maps to Arduino digital pins 8 to 13
    // turn pin 11 ON
    PORTB |= B00001000; // much faster than digitalWrite(11, HIGH);
    delayMicroseconds(halfONperiod);

    // turn pin 11 OFF
    PORTB &= B11110111; // much faster than digitalWrite(11, LOW);
    delayMicroseconds(halfOFFperiod);

    // go to next frequency before ending loop to allow for 'iteration'
    // end case is at the maximum number of steps possible
    frequency = frequency + stepF;
  }
}


void setup() {
  pinMode(11, OUTPUT);
  Serial.begin(9600);
}

void interruptor(){
  photointerrData = analogRead(A0);
  Serial.println(photointerrData); //
  delay(5);
}

void loop() {
  freqSweepPin11(freqmin, freqmax, number);
  delay(50);  // time delay before starting next sweep, we want this as short as posible
}
