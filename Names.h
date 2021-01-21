#pragma once
#define BYTE_KEY		0x69 // ����
#define MSG_BYTES		5 // ������ ��������� ��������� � ������
#define CMD_BYTES		4 // ������ ������� � ������
//=============================��������� �������=============================
//=============================������� ����������=============================
// ��������:
#define AUTOMOVE			0x41
// ����:
#define LIGHTS				0x42
// ������:
#define FWHEEL_R			0x43 // �������� ������
#define FWHEEL_L			0x44 // �������� �����
#define RWHEEL_R			0x45 // ������ ������
#define RWHEEL_L			0x46 // ������ �����
// �����������:
#define ARM_BASE_MOVE		0x47 // �������� ����
#define ARM_PIVOT_MOVE		0x48 // �������� ������
#define ARM_HAND_MOVE		0x49 // ��������� ������
#define ARM_MANUAL			0x4A // ������ ���������� �������������
#define ARM_MOVEBACK		0x4B // ��������������� ������������
// �����:
#define LASER				0x4C
// ���������:
#define ENGINE_MANUAL		0x4D
// ����� ������� � �������:
#define COM_AUTO			0x4E // �������������� ������ �������
#define COM_MANUAL			0x4F // ������ ���������� ������� �������
#define CLEARANCE_MANUAL	0x50 // ������ ���������� ���������