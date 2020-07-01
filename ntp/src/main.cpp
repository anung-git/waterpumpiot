#include <Arduino.h>
//FirebaseESP8266.h must be included before ESP8266WiFi.h
#include "FirebaseESP8266.h"
#include <ESP8266WiFi.h>

#include <NTPClient.h>
#include <WiFiUdp.h>

const char *ssid     = "ardinista";
const char *password = "ardiasta";

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "asia.pool.ntp.org", 3600*7);


#define FIREBASE_HOST "skripsi-9726b.firebaseio.com" //Without http:// or https:// schemes
#define FIREBASE_AUTH "b5LLW3w6JPyKzecPzKwUqz3oX5sTdW2wGUOpTM4A"
#define WIFI_SSID "ardinista"
#define WIFI_PASSWORD "ardiasta"


//Define FirebaseESP8266 data object
FirebaseData firebaseData;
FirebaseJson json;

void setup()
{
  timeClient.setTimeOffset(3600*7);
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  timeClient.begin();
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseData.setBSSLBufferSize(1024, 1024);
  firebaseData.setResponseSize(1024);
  Firebase.setReadTimeout(firebaseData, 1000 * 60);
  Firebase.setwriteSizeLimit(firebaseData, "tiny");
  // test();
}

String getDay(){
    //Get a time structure
  String months[12]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
  timeClient.update();
  unsigned long epochTime = timeClient.getEpochTime();
  struct tm *ptm = gmtime ((time_t *)&epochTime); 
  int monthDay = ptm->tm_mday;
  int currentMonth = ptm->tm_mon+1;
  String currentMonthName = months[currentMonth-1];
  int currentYear = ptm->tm_year+1900;
  return String(currentYear) + "/" + String(currentMonth) + "/" + String(monthDay);
  // String currentDate = String(currentYear) + "-" + String(currentMonth) + "-" + String(monthDay)+"/";
  // return currentDate;
}

String getEtag(){
    //Get a time structure
  timeClient.update();
  unsigned long epochTime = timeClient.getEpochTime();
  struct tm *ptm = gmtime ((time_t *)&epochTime); 
  int monthDay = ptm->tm_mday;
  int currentMonth = ptm->tm_mon+1;
  int currentYear = ptm->tm_year+1900;
  unsigned long rawTime = timeClient.getEpochTime();
  unsigned long hours = (rawTime % 86400L) / 3600;
  String hoursStr = hours < 10 ? "0" + String(hours) : String(hours);
  unsigned long minutes = (rawTime % 3600) / 60;
  String minuteStr = minutes < 10 ? "0" + String(minutes) : String(minutes);
  unsigned long seconds = rawTime % 60;
  String secondStr = seconds < 10 ? "0" + String(seconds) : String(seconds);
  return String(currentYear) +  String(currentMonth) + String(monthDay)+hoursStr + minuteStr + secondStr;;
}


double tinggi;
void loop() {

 String path = "/Test";
 
  Serial.println("------------------------------------");
  Serial.println("Set double test...");

    //Also can use Firebase.set instead of Firebase.setDouble
    // if (Firebase.setString(firebaseData, path + "/Double/Data" + (i + 1), ((i + 1) * 10) + 0.123456789))
    // {

    // }



  tinggi += random(10);
  if (tinggi >400)
  {
    tinggi=random(200);
  }
  
  timeClient.update();

  Serial.println(timeClient.getFormattedTime());

  delay(3000);

   path = "/Level/Tank/"+ getEtag();

  if (Firebase.setString(firebaseData, path  + "/Tanggal", getDay()))
  {
  
  }
  if (Firebase.setString(firebaseData, path  + "/Jam", timeClient.getFormattedTime()))
  {
  
  }  if (Firebase.setInt(firebaseData, path  + "/Tinggi", tinggi))
  {
  
  }

  // json.clear().add("Tanggal", getDay());
  // json.add("Jam",timeClient.getFormattedTime());
  // json.add("Tinggi",tinggi);
  // //Also can use Firebase.push instead of Firebase.pushJSON
  // //Json string is not support in v 2.6.0 and later, only FirebaseJson object is supported.
  // if (Firebase.pushJSON(firebaseData, path , json))
  // {
  //   Serial.println("PASSED");
  //   Serial.println("PATH: " + firebaseData.dataPath());
  //   Serial.print("PUSH NAME: ");
  //   Serial.println(firebaseData.pushName());
  //   Serial.println("ETag: " + firebaseData.ETag());
  //   Serial.println("------------------------------------");
  //   Serial.println();
  // }
  // else
  // {
  //   Serial.println("FAILED");
  //   Serial.println("REASON: " + firebaseData.errorReason());
  //   Serial.println("------------------------------------");
  //   Serial.println();
  // }
  

}