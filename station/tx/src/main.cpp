#include <Arduino.h>
#include "LoRa_E32.h"
#include <math.h>

#define PIN_M0 18 // D4 on the board (possibly pin 24)
#define PIN_M1 5  // D2 on the board (possibly called pin 22)
#define PIN_AX 19

LoRa_E32 lora(&Serial2, PIN_AX, PIN_M0, PIN_M1); 
void printParameters(struct Configuration configuration);
double timestamp = 0;
int printTime = 0.5;

void setup()
{
	Serial.begin(9600);
	delay(1000);
	lora.begin();
	ResponseStructContainer c;
	c = lora.getConfiguration();
	Configuration configuration = *(Configuration *)c.data;
	configuration.ADDL = 0x02;
	configuration.ADDH = 0x01;
	configuration.CHAN = 0x04;
	configuration.OPTION.fixedTransmission = FT_FIXED_TRANSMISSION;
	lora.setConfiguration(configuration, WRITE_CFG_PWR_DWN_SAVE);
	printParameters(configuration);
	c.close();
}

void loop()
{
	double now = millis();

	if ((now - timestamp) > printTime)
	{
		timestamp = now;
		struct Message
		{
			byte combustivel = random(50);;
		} message;
		ResponseStatus rs = lora.sendFixedMessage(0xff, 0xff, 4, &message, sizeof(Message));
		Serial.println(rs.getResponseDescription());
		Serial.println(" ");
	}
	delay(1);
}


void printParameters(struct Configuration configuration)
{
	Serial.println("----------------------------------------");

	Serial.print(F("HEAD BIN: "));
	Serial.print(configuration.HEAD, BIN);
	Serial.print(" ");
	Serial.print(configuration.HEAD, DEC);
	Serial.print(" ");
	Serial.println(configuration.HEAD, HEX);
	Serial.println(F(" "));
	Serial.print(F("AddH BIN: "));
	Serial.println(configuration.ADDH, BIN);
	Serial.print(F("AddL BIN: "));
	Serial.println(configuration.ADDL, BIN);
	Serial.print(F("Chan BIN: "));
	Serial.print(configuration.CHAN, DEC);
	Serial.print(" -> ");
	Serial.println(configuration.getChannelDescription());
	Serial.println(F(" "));
	Serial.print(F("SpeedParityBit BIN    : "));
	Serial.print(configuration.SPED.uartParity, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.SPED.getUARTParityDescription());
	Serial.print(F("SpeedUARTDataRate BIN : "));
	Serial.print(configuration.SPED.uartBaudRate, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.SPED.getUARTBaudRate());
	Serial.print(F("SpeedAirDataRate BIN  : "));
	Serial.print(configuration.SPED.airDataRate, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.SPED.getAirDataRate());

	Serial.print(F("OptionTrans BIN       : "));
	Serial.print(configuration.OPTION.fixedTransmission, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.OPTION.getFixedTransmissionDescription());
	Serial.print(F("OptionPullup BIN      : "));
	Serial.print(configuration.OPTION.ioDriveMode, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.OPTION.getIODroveModeDescription());
	Serial.print(F("OptionWakeup BIN      : "));
	Serial.print(configuration.OPTION.wirelessWakeupTime, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.OPTION.getWirelessWakeUPTimeDescription());
	Serial.print(F("OptionFEC BIN         : "));
	Serial.print(configuration.OPTION.fec, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.OPTION.getFECDescription());
	Serial.print(F("OptionPower BIN       : "));
	Serial.print(configuration.OPTION.transmissionPower, BIN);
	Serial.print(" -> ");
	Serial.println(configuration.OPTION.getTransmissionPowerDescription());

	Serial.println("----------------------------------------");
}