#include <iostream>
#include <iomanip>
using namespace std;

int main()
{
	system("chcp 1251"); // Ставлю удобную для своего терминала кодировку
	system("cls");

	// Объявление и инициализация константы-ключа:
	const unsigned char key = 0x49;

	// Объявление и инициализация "входящего пакета":
	unsigned char incoming[5] = { 0x4C, 0xF2, 0x1F, 0xF4, 0x09 };

	// Объявление "исходящего пакета":
	unsigned char translated[4];

	// Проверяю ключи на совпадение:
	bool operandL = (0xF0 & incoming[0]) == (0xF0 & key);
	bool operandR = (0x0F & incoming[4]) == (0x0F & key);

	if (operandL && operandR)
	{
		cout << "Keys are equal, translating\n";
		// Транслирую с помощью битовых масок фрагменты команд и аргументов
		translated[0] = ((0x0F & incoming[0]) << 4) | ((0xF0 & incoming[1]) >> 4);
		translated[1] = ((0x0F & incoming[1]) << 4) | ((0xF0 & incoming[2]) >> 4);
		translated[2] = ((0x0F & incoming[2]) << 4) | ((0xF0 & incoming[3]) >> 4);
		translated[3] = ((0x0F & incoming[3]) << 4) | ((0xF0 & incoming[4]) >> 4);

		cout << "Translated commands: ";
		for (char i = 0; i < 4; i++) cout << setw(2) << setfill('0') << hex << static_cast<unsigned short>(translated[i]) << " ; ";
		cout << endl;
	}

	else cout << "Keys are not equal, operation aborted\n";

	system("pause>0");
	return 0;
}
