// Blink LED Program for mc8051 IP Core Demo Design 
// Author: Jonas Berger
// Date: 29.11.2022

#include "8052.h"
#include "stdio.h"

void main(void)
{
  volatile unsigned int i1, i2, movimgmask = 0x01, ledmask = 0x01;

  // blink fast, for ModelSim simulation
  for (i1=0; i1<10; i1++)
  {
    P2 = 0xFF; // set all eight P2 port pins to logic 1  
    P2 = 0x00; // set all eight P2 port pins to logic 0
  }

  P2 = ledmask; // for leds
  P1 = movimgmask; // for movable image
  // soft delay
  for(i1=0; i1<500; i1++)
    for(i2=0; i2<1000; i2++);

  while(1)
  {
    ledmask = ledmask << 0x01;
    P2 = ledmask;
    
    movimgmask = movimgmask << 0x01;
    P1 = movimgmask;
    
    // soft delay
    for(i1=0; i1<500; i1++)
      for(i2=0; i2<1000; i2++);
    
    if(ledmask == 0x80) // after all 8 leds on go back to first
    {
      ledmask = 0x01;
      P2 = ledmask;
      // soft delay
      for(i1=0; i1<500; i1++)
        for(i2=0; i2<1000; i2++);
    }
    
    if(movimgmask == 0x08) // after 4 stages get back to first stage
    {
      movimgmask = 0x01;
      P1 = movimgmask;
      // soft delay
      for(i1=0; i1<500; i1++)
        for(i2=0; i2<1000; i2++);
    }
  }
}


