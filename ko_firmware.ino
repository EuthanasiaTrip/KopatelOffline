/*
 Name:    ko_firmware.ino
 Created: 18.01.2021 17:45:29
 Author:  EuthanasiaTrip aka Matvey aka The best pilot RTK has ever seen
*/
#include "Names.h"
byte bufferInc[MSG_BYTES];      // входящий буфер
byte bufferFbk[CMD_BYTES];      // буфер отклика
byte bufTranslated[CMD_BYTES];    // буфер команд

void setup() {
  Serial.begin(9600);

}

void loop() {
  msgRead();

}

void msgRead() {
  if (Serial.available()) {
    for (int i = 0; i < MSG_BYTES; i++) { 
      bufferInc[i] = Serial.read(); // записываем входящий буфер
    }
  }
  if ((bufferInc[0] & 0xF0) == (BYTE_KEY & 0xF0) && (bufferInc[MSG_BYTES - 1] & 0x0F) == (BYTE_KEY & 0x0F)) { // сравниваем первые и последние 4 байта с ключом
    for (int i = 0; i < (CMD_BYTES); i++) {
      bufTranslated[i] = ((0x0F & bufferInc[i]) << 4) | ((0xF0 & bufferInc[i+1]) >> 4); // записываем оставшиеся 32 байта в буфер для комманд                               
    }
  }
  for (int i = 0; i < MSG_BYTES; i++) {
    bufferInc[i] = 0; // очищаем входной буфер
  }
}
