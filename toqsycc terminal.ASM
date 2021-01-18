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
   ; Начало отрисовки окна:                              SysFn12
   mcall        12, 1
   ; Определение окна:                                   SysFn00
   mcall        0, <0, 1023>, <0, 767>, wstyle, wheader, wframe
   ; Отрисовка заголовка окна                            SysFn71
   mcall        71, 2, header, 1
   ; Отрисовка текста:                                   SysFn04
   mcall        4, <30, 10>, tstyle, string
   ; Попытка отрисовать изображение:
   mcall 1, 10, 10, 0x00FF0000
   mcall 1, 11, 10, 0x0000FF00
   mcall 1, 12, 10, 0x000000FF
   mcall 1, 10, 11, 0x00FF0000
   mcall 1, 11, 11, 0x0000FF00
   mcall 1, 12, 11, 0x000000FF
   mcall 1, 10, 12, 0x00FF0000
   mcall 1, 11, 12, 0x0000FF00
   mcall 1, 12, 12, 0x000000FF

   ; Пробую вызвать COM порт, результат отрицательный - ебать я
   ;jmp com_send
   ; Конец отрисовки:                                    SysFn12
   mcall        12, 2
   ; Выход из процедуры
   ret

com_debug:
   mcall 4, <30, 30>, tstyle, string

com_send:
   mov eax, 43
   mov bl, 0xFF
   mov ecx, 0x4
   mcall
   xor eax, 0
   js com_debug

DATA
   ; Переменные интерфейса приложения
   header            db   'toqsycc labs : drone terminal mk.1 rev.0', 0
   string            db   'Sample string', 0
   aboutCOM          db   'RC on COM ', 0
   aboutDrone        db   'Connected: ', 0

   ; Флаги статуса подключенного беспилотника
   droneStatus       db   'Online', 0
   droneThumper      db   'Thumper', 0
   droneElon         db   'Mecanum', 0
   droneMovement     db   'Movement', 0
   droneIdle         db   'Idling', 0
   droneBattery      db   'Battery', 0
   droneAutomove     db   'Automovement', 0
   droneAutoasm      db   'Autoassembling', 0
   droneLights       db   'Light', 0
   droneManipulator  db   'Manipulator', 0
   droneWarning      db   'Warning', 0
   droneDamaged      db   'Damaged', 0

   ; Константы стиля интерфейса приложения
   wstyle            =     0x30000000
    wheader          =     0x01000000
    wframe           =     0x000000FF
   tstyle            =     0x80000000
    ts_active        =     0x80FFFF32
    ts_idle          =     0x80323232
    ts_error         =     0x80FF0000
    ts_danger        =     0x80FF1600

   ; Константы интерфейса приложения
   droneDigger       db    'Digger Offline', 0

UDATA

MEOS_APP_END