# Terminal
Проект терминала управления на базе x86-совместимого процессора и KolibriOS.
***
## Назначение
Терминал предназначен для упрощения управления дронами, поскольку позволяет наблюдать одновременно изображения с камер, 
индикаторы состояния, и осуществлять управление дроном.
## Реализация
Я использую FASM, поскольку на него распространяется нативная поддержка KolibriOS. В процессе разработки всплыли некоторые моменты:
1. Необходимость разработать свой протокол обмена данными, который поддерживали бы все будущие проекты;
2. Несмотря на то, что KolibriOS является **очень** быстрой операционной системой, на данный момент она всё ещё сыровата, а
отсутствие нормальной документации по её API усложняет процесс разработки в разы;
3. Отсутствие обычного COM-порта заставляет прибегнуть к преобразователю USB-UART, но для этого придётся писать собственный драйвер, или
пытаться адаптировать уже имеющийся в системе. А задача получения картинки с USB-ресивера становится ещё сложнее ввиду отсутствия
и документации, и каких-либо полезных данных о принципе его работы.
***
## KolibriOS и FASM
Неприятным моментом в изучении этой системы стало в меньшей степени отсутствие документации и примеров, а то, что каждый разработчик
пишет по-своему одни и те же функции, и это усложняет процесс понимания того, как вести разработку. Например, следующий код
```asm
mov eax, 12
mov ebx, 1
mcall

mcall 12, 1
```
представляет из себя абсолютно одно и то же, однако, каждый разработчик пишет по-своему
