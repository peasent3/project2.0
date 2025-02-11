#include <WiFi.h>
#include <HTTPClient.h>
 
const char* ssid = "history"; // Replace with your WiFi SSID
const char* password = "electrotech"; // Replace with your WiFi Password
const char* serverUrl = "http://192.168.1.122:3000"; // Replace with your server's IP
 
#define LED_PIN 2 // Change to your LED pin
 
void setup() {
    Serial.begin(115200);
    pinMode(LED_PIN, OUTPUT);
    
    // Connect to WiFi
    WiFi.begin(ssid, password);
    Serial.print("Connecting to WiFi...");
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.print(".");
    }
    Serial.println("\nConnected to WiFi!");
    Serial.print(WiFi.localIP());
}
 
void loop() {
    if (WiFi.status() == WL_CONNECTED) {
        HTTPClient http;
        http.begin(String(serverUrl) + "/status"); 
        int httpResponseCode = http.GET();
 
        if (httpResponseCode > 0) {
            String response = http.getString();
            Serial.println("Server response: " + response);
 
            if (response == "on") {
                digitalWrite(LED_PIN, HIGH);
            } else if (response == "off") {
                digitalWrite(LED_PIN, LOW);
            }
        } else {
            Serial.println("Error in HTTP request");
        }
 
        http.end();
    }
 
    delay(5000); // Check status every 5 seconds
}
 