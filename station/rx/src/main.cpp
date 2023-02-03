#include <Arduino.h>
#include <WiFi.h>
#include "LoRa_E32.h"
#include "PubSubClient.h"
#include <ArduinoJson.h>

#define ARDUINOJSON_POSITIVE_EXPONENTIATION_THRESHOLD 1e11

#define PIN_M0 18 // D4 on the board (possibly pin 24)
#define PIN_M1 5  // D2 on the board (possibly called pin 22)
#define PIN_AX 19

#define WIFI_SSID "ssdi"
#define WIFI_PASSWORD "senha"
#define MQTT_HOST "storni.ddns.net"
#define MQTT_PORT 8883

WiFiClient espClient;
PubSubClient mqtt(espClient);

String mqttName = "argos";
String dataTopic = "ARGOS";

String getJSON(int packetId, int packetLegth, double arrivedTime, double sendedTime, float delay, byte fuel);

LoRa_E32 lora(&Serial2, PIN_AX, PIN_M0, PIN_M1);
void printParameters(struct Configuration configuration);

void setup()
{
	Serial.begin(9600);
	WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

	while (WiFi.status() != WL_CONNECTED)
	{
		delay(1000);
		Serial.println("Connecting to WiFi....");
	}

	delay(2000);
	Serial.printf("\nsetup() em core: %d", xPortGetCoreID());
	Serial.println("Connected to the WiFi network\nI address: " + String(WiFi.localIP()));
	mqtt.setServer(MQTT_HOST, MQTT_PORT);

	while (!mqtt.connected())
	{
		Serial.println("Connecting to MQTT...");
		if (mqtt.connect(mqttName.c_str()))
			Serial.println("Connected");
		else
		{
			Serial.print("Failed with state ");
			Serial.println(mqtt.state());
		}
		delay(1000);
	}
	delay(1000);

	lora.begin();
	ResponseStructContainer c;
	c = lora.getConfiguration();
	Configuration configuration = *(Configuration *)c.data;
	configuration.ADDL = 0x01;
	configuration.ADDH = 0x00;
	configuration.CHAN = 0x04;
	configuration.OPTION.fixedTransmission = FT_FIXED_TRANSMISSION;
	lora.setConfiguration(configuration, WRITE_CFG_PWR_DWN_SAVE);
	printParameters(configuration);
	c.close();
}
struct Message
{
	byte combustivel = random(50);
} message;

void loop()
{
	if (!mqtt.connected())
		mqtt.connect(mqttName.c_str());

	if (lora.available() > 1)
	{
		struct timeval t = rtc.getTimeStruct();
		ResponseStructContainer rsc = lora.receiveMessage(sizeof(Message));
		struct Message message = *(Message *)rsc.data;
		rsc.close();
		String out = getJSON(message.idPacote, sizeof(Message), arrivedTime, sendedTime, delay, message.combustivel);
		Serial.println(out);
		mqtt.publish(dataTopic.c_str(), out.c_str(), false);
	}
	delay(1);
}

String getJSON(int packetId, int packetLegth, double arrivedTime, double sendedTime, float delay, byte fuel)
{
	StaticJsonDocument<164> doc;
	doc["packetId"] = packetId;
	doc["entradaCombustivel"] = random(50);
	doc["saidaCombustivel"] = fuel;
	return doc.as<String>();
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
