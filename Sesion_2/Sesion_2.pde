#include <string.h>

char command[32];

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

void help()
{
  USB.println("==============================================================================");
  USB.println("Available commands: ");
  USB.println("==============================================================================");
  USB.println("red on/off --> turns on/off red LED");
  USB.println("green on/off --> turns on/off green LED");
  USB.println("==============================================================================");
}

void setup()
{
  USB.ON();
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
  }
}
