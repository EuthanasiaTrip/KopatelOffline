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

   ; Отрисовка рамки экрана
   mov ebp, 0x00323232
   mov edi, 1017
   mov esi, 5
fra:
   mcall 1, edi, esi, ebp
   dec edi
   cmp edi, esi
   jne fra

   mov edi, 1017
   mov esi, 45
frb:
   mcall 1, edi, esi, ebp
   dec edi
   cmp edi, 5
   jne frb

   mov edi, 5
   mov esi, 5
frc:
   mcall 1, edi, esi, ebp
   inc esi
   cmp esi, 46
   jne frc

   mov edi, 1017
   dec esi
frd:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 5
   jne frd

   ; Отрисовка плейсхолдера картинки с камеры, разрешение 644х480
   mov ebp, 0x000000FF
   mov edi, picWidth
   mov esi, picHeight
a:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne a
   dec edi
   mov esi, picHeight
   cmp edi, 672
   jne a

   mov ebp, 0x00FF0000
   mov edi, picWidth
   sub edi, 92
   mov esi, picHeight
b:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne b
   dec edi
   mov esi, picHeight
   cmp edi, 580
   jne b

   mov ebp, 0x00FF00FF
   mov edi, picWidth
   sub edi, 184
   mov esi, picHeight
c:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne c
   dec edi
   mov esi, picHeight
   cmp edi, 488
   jne c

   mov ebp, 0x0000FF00
   mov edi, picWidth
   sub edi, 276
   mov esi, picHeight
d:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne d
   dec edi
   mov esi, picHeight
   cmp edi, 396
   jne d

   mov ebp, 0x0000FFFF
   mov edi, picWidth
   sub edi, 368
   mov esi, picHeight
e:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne e
   dec edi
   mov esi, picHeight
   cmp edi, 304
   jne e

   mov ebp, 0x00FFFF00
   mov edi, picWidth
   sub edi, 460
   mov esi, picHeight
f:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne f
   dec edi
   mov esi, picHeight
   cmp edi, 212
   jne f

   mov ebp, 0x00FFFFFF
   mov edi, picWidth
   sub edi, 552
   mov esi, picHeight
g:
   mcall 1, edi, esi, ebp
   dec esi
   cmp esi, 50
   jne g
   dec edi
   mov esi, picHeight
   cmp edi, 120
   jne g

   mov edi, 0x00000000
   mcall 4, <370, 275>, 0xC2FFFFFF, signal

   ; Отрисовка флагов состояния дрона
   ; Надо будет их упорядочить и изменить окраски...
   mcall 4, <10, 50>, ts_category, flagshd
   mcall 4, <15, 60>, ts_error, droneStatus
   mcall 4, <15, 70>, ts_error, droneBattery
   mcall 4, <15, 80>, ts_error, droneMovement
   mcall 4, <15, 90>, ts_error, droneAutomove
   mcall 4, <15, 100>, ts_error, droneManipulator
   mcall 4, <15, 110>, ts_error, droneAutoasm
   mcall 4, <15, 120>, ts_error, droneWarning
   mcall 4, <15, 130>, ts_error, droneDamaged

   mcall 4, <10, 150>, ts_category, flagshd2
   mcall 4, <15, 160>, ts_active, droneIdle
   mcall 4, <15, 170>, ts_idle, droneThumper
   mcall 4, <15, 180>, ts_idle, droneElon
   mcall 4, <15, 190>, ts_danger, droneLights
   mcall 4, <15, 200>, ts_danger, droneLaser

   mcall 4, <10, 220>, ts_category, flagshd3
   mcall 4, <15, 230>, ts_idle, aboutCOM
   mcall 4, <15, 240>, ts_idle, control
   mcall 4, <15, 250>, ts_idle, speedConf

   ; Пробую вызвать COM порт, результат отрицательный
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
   picWidth          =   784
   picHeight         =   530

   ; Переменные интерфейса приложения
   header            db   'toqsycc labs : drone terminal mk.1 rev.0', 0
   string            db   'Sample string', 0
   signal            db   'NO SIGNAL!', 0
   aboutCOM          db   'RC on COM ', 0
   aboutDrone        db   'Connected: ', 0
   speedConf         db   'Speeds group: ', 0
   control           db   'Controller: ', 0
   flagshd           db   'IMP FLAGS :', 0
   flagshd2          db   'ADD FLAGS :', 0
   flagshd3          db   'COM FLAGS :', 0


   ; Флаги статуса подключенного беспилотника
   droneStatus       db   'Online', 0
   droneLaser        db   'Laser', 0
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
    wframe           =     0x00323232
   tstyle            =     0x80000000
    ts_active        =     0x8000FF16
    ts_idle          =     0x80646464
    ts_error         =     0x80FF0000
    ts_danger        =     0x80FF9600
    ts_category      =     0x80FFFFFF

   ; Константы интерфейса приложения
   droneDigger       db    'Digger Offline', 0

UDATA

MEOS_APP_END