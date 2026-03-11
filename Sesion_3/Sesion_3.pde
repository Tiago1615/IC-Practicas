#include <string.h>
#include <stdlib.h>

char command[64];

// ****************************************************************
// Reads a line from the input command line in the serial monitor
// ****************************************************************
int8_t read_USB_command(char *term, size_t msz)
{
  size_t sz = 0;
  unsigned long init = millis();

  while (sz < msz)
  {
    while ((USB.available() > 0) && (sz < msz))
    {
      term[sz++] = USB.read();
      init = millis();
    }

    if (sz && ((millis() - init) > 50UL)) break;
  }

  term[sz] = 0;
  return sz;
}

const char* dowToStr(int dayNum)
{
  switch(dayNum)
  {
    case 1: return "Monday";
    case 2: return "Tuesday";
    case 3: return "Wednesday";
    case 4: return "Thursday";
    case 5: return "Friday";
    case 6: return "Saturday";
    case 7: return "Sundat";
  }
}

void help()
{
  USB.println("==============================================================================");
  USB.println("Available commands: ");
  USB.println("==============================================================================");
  USB.println("red on --> turns on red LED");
  USB.println("green on --> turns on green LED");
  USB.println("red blink ms t --> turns on red LED for ms miliseconds and t times");
  USB.println("green blink ms times --> turns on green LED for ms miliseconds and t times");
  USB.println("set pin p state --> turns pin p to state (on/off)");
  USB.println("get pin p --> shows current state of pin p");
  USB.println("fmem --> shows current available RAM");
  USB.println("eeprom write a v --> writes value v in address a of EEPROM");
  USB.println("eeprom read a --> shows current value stored in address a");
  USB.println("get time --> shows current time");
  USB.println("set time t --> updates current time to t (yy:mm:dd:dow:hh:mm:ss)");
  USB.println("get dow d --> shows day of date d (yy, mm, dd)");
  USB.println("help --> shows this list of commands");
  USB.println("==============================================================================");
}

void setup()
{
  USB.ON();
  RTC.ON();
  help();
}

void loop()
{
  int8_t n = read_USB_command(command, sizeof(command));

  if (n > 0)
  {
    if (strstr(command, "red on"))
    {
      Utils.setLED(LED0, LED_ON);
    }
    else if (strstr(command, "red off"))
    {
      Utils.setLED(LED0, LED_OFF);
    }
    else if (strstr(command, "green on"))
    {
      Utils.setLED(LED1, LED_ON);
    }
    else if (strstr(command, "green off"))
    {
      Utils.setLED(LED1, LED_OFF);
    }
    else if(strstr(command, "red blink"))
    {
      int ms, times;
      sscanf(command, "red blink %d %d", &ms, &times);
      Utils.blinkRedLED(ms, times);
    }
    else if(strstr(command, "green blink"))
    {
      int ms, times;
      sscanf(command, "green blink %d %d", &ms, &times);
      Utils.blinkGreenLED(ms, times);
    }
    else if(strstr(command, "set pin"))
    {
      int pin;
      char pinState[10];
      sscanf(command, "set pin %d %s", &pin, &pinState);
      
      pinMode(pin, OUTPUT);

      if (strcmp(pinState, "on")==0)
      {
        digitalWrite(pin, HIGH);
      }
      else if (strcmp(pinState, "off")==0)
      {
        digitalWrite(pin, LOW);
      }
      else
      {
        USB.print("Invalid pin state!");
      }
    }
    else if(strstr(command, "get pin"))
    {
      int pin;
      sscanf(command, "get pin %d", &pin);
      
      pinMode(pin, INPUT);
      int value = digitalRead(pin);

      USB.print("Pin ");
      USB.print(pin);
      USB.print(": ");
      USB.println(value);
    }
    else if(strstr(command, "fmem"))
    {
      USB.print("Free memory available: ");
      USB.println(freeMemory());
    }
    else if(strstr(command, "eeprom write"))
    {
      int address, value;
      sscanf(command, "eeprom write %d %d", &address, &value);

      Utils.writeEEPROM(address, value);
      USB.println("EEPROM written");
    }
    else if(strstr(command, "eeprom read"))
    {
      int address, value;
      sscanf(command, "eeprom read %d", &address);

      value = Utils.readEEPROM(address);
      USB.print("Value stored in EEPROM[");
      USB.print(address);
      USB.print("]: ");
      USB.println(value);
    }
    else if(strstr(command, "get time"))
    {
      USB.println(RTC.getTime());
    }
    else if(strstr(command, "set time"))
    {
      char newTime[32];
      sscanf(command, "set time %s", &newTime);

      RTC.setTime(newTime);

      USB.println("Time updated");
    }
    else if (strstr(command, "get dow"))
    {
      int yy, mm, dd;
      const char* dayOfWeek;
      sscanf(command, "get dow %d %d %d", &yy, &mm, &dd);

      dayOfWeek = dowToStr(RTC.dow(yy, mm, dd));

      USB.print("The ");
      USB.print(dd);
      USB.print("/");
      USB.print(mm);
      USB.print("/");
      USB.print(yy);
      USB.print(" was a: ");
      USB.print(dayOfWeek);
    }
    else if (strstr(command, "help"))
    {
      help();
    }
    else
    {
      USB.println("Invalid command!");
    }
  }
}
