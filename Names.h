#pragma once
#define BYTE_KEY		0x69 // ключ
#define MSG_BYTES		5 // размер входящего сообщения в байтах
#define CMD_BYTES		4 // размер команды в байтах
//=============================Системные команды=============================
//=============================Команды управления=============================
// АВТОЕЗДА:
#define AUTOMOVE			0x41
// СВЕТ:
#define LIGHTS				0x42
// КОЛЕСА:
#define FWHEEL_R			0x43 // переднее правое
#define FWHEEL_L			0x44 // переднее левое
#define RWHEEL_R			0x45 // заднее правое
#define RWHEEL_L			0x46 // заднее левое
// МАНИПУЛЯТОР:
#define ARM_BASE_MOVE		0x47 // движение базы
#define ARM_PIVOT_MOVE		0x48 // движение колена
#define ARM_HAND_MOVE		0x49 // раскрытие клешни
#define ARM_MANUAL			0x4A // ручное управление манипулятором
#define ARM_MOVEBACK		0x4B // автоскладывание манипулятора
// ЛАЗЕР:
#define LASER				0x4C
// ДВИГАТЕЛЬ:
#define ENGINE_MANUAL		0x4D
// ЦЕНТР ТЯЖЕСТИ И КЛИРЕНС:
#define COM_AUTO			0x4E // автокалибровка центра тяжести
#define COM_MANUAL			0x4F // ручное управление центром тяжести
#define CLEARANCE_MANUAL	0x50 // ручное управление клиренсом