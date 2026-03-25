/*
   DeepSleep + WakeUp por RTC o Acelerómetro
*/

void setup()
{
  USB.ON();
  USB.println("\nUSB OK");
  
  // RTC
  RTC.ON();
  RTC.setTime("22:03:10:05:15:48:00");

  // Acelerómetro
  ACC.ON();

  // Limpiar interrupciones previas
  PWR.clearInterruptionPin();

  // Activar interrupción de movimiento
  ACC.setIWU();

  USB.OFF();
}

void loop()
{
  char timestr[31];
  static uint16_t cycle = 0;

  USB.ON();

  USB.print(F("Cycle: "));
  USB.println(cycle, DEC);

  strncpy(timestr, RTC.getTime(), sizeof(timestr));
  USB.print(F("Current time: "));
  USB.println(timestr);

  USB.print(F("\tBattery Level: "));
  USB.print(PWR.getBatteryLevel(), DEC);
  USB.println(" %");

  USB.print(F("\tTemperature: "));
  USB.print(RTC.getTemperature());
  USB.println(F(" C\n"));

  // 🔥 AQUÍ: identificar qué ha despertado el mote
  if (intFlag & ACC_INT)
  {
    USB.println("Wake up caused by ACCELEROMETER");

    // Limpiar flag
    intFlag &= ~(ACC_INT);
  }
  else
  {
    USB.println("Wake up caused by RTC");
  }

  cycle++;

  USB.println("Going to sleep...\n");
  delay(100);

  USB.OFF();

  // Dormir 20 segundos (o hasta interrupción del ACC)
  PWR.deepSleep("00:00:00:20", RTC_OFFSET, RTC_ALM1_MODE2, ALL_OFF);
}
