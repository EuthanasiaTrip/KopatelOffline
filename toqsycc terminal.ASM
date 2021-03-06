include "macros.inc"

MEOS_APP_START


CODE

redraw:
   call         draw_window

wait_event:
   mcall        10
   dec          eax
   jz           redraw
   dec          eax
   jz           key
   mcall        -1

key:
   mcall        2
   jmp          wait_event

draw_window:
   ; ������ ��������� ����:                              SysFn12
   mcall        12, 1
   ; ����������� ����:                                   SysFn00
   mcall        0, <0, 1023>, <0, 767>, wstyle, wheader, wframe
   ; ��������� ��������� ����                            SysFn71
   mcall        71, 2, header, 1
   ; ��������� ������:                                   SysFn04
   mcall        4, <30, 10>, tstyle, string
   ; ����� ���������:                                    SysFn12
   mcall        12, 2
   ; ����� �� ���������
   ret

DATA
   ; ���������� ���������� ����������
   header            db   'toqsycc labs : drone terminal mk.1 rev.0', 0
   string            db   'Sample string', 0
   aboutCOM          db   'RC on COM ', 0
   aboutDrone        db   'Connected: ', 0

   ; ����� ������� ������������� ������������
   droneStatus       db   'Online', 0
   droneMovement     db   'Movement', 0
   droneIdle         db   'Idling', 0
   droneBattery      db   'Battery', 0
   droneAutomove     db   'Automovement', 0
   droneAutoasm      db   'Autoassembling', 0
   droneLights       db   'Light', 0
   droneManipulator  db   'Manipulator', 0
   droneWarning      db   'Warning', 0
   droneDamaged      db   'Damaged', 0

   ; ��������� ����� ���������� ����������
   wstyle            =     0x30000000
    wheader          =     0x01000000
    wframe           =     0x000000FF
   tstyle            =     0x80000000
    ts_active        =     0x80FFFF32
    ts_idle          =     0x80323232
    ts_error         =     0x80FF0000
    ts_danger        =     0x80FF1600

   ; ��������� ���������� ����������
   droneDigger       =    'Digger Offline', 0

UDATA

MEOS_APP_END