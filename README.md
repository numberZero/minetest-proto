# Описание сетевого протокола Minetest
Данный репозиторий содержит машинно-читаемое описание протокола игры [Minetest](https://www.minetest.net), начиная с версии 5.0 (протокол 37 с исправлениями).

## Используемые типы
* Числа:
    * u8, u16, u32, u64: без знака (число — размер в битах);
    * s8, s16, s32, s64: со знаком;
    * f32: дробное IEEE 754, одинарной точночти;
    * b8: булево значение (передаётся как u8, 0↔false, 1↔true, другие значения недопустимы).
* Строки: сначала идёт длина (u16, в кодовых единицах), затем содержимое, без завершающего NUL;
    * utf8string: UTF-8;
    * utf16string: UTF-16BE;
    * rawstring: строка байт.
* Двоичные данные:
    * blob: длина (u32, в байтах) и данные;
    * raw: данные без префикса; допустим, если размер определяется извне.
* Стандартные типы:
    * v2f, v3f: векторы соответствующей размерности (из f32);
    * v2s16, v3s16, v2s32, v3s32: целочисленные векторы (из соответствующих типов);
    * color: цвет (из u8, в порядке ARGB).

## Каналы
Minetest использует 3 канала в каждом направлении.

Каналы «наверх» используются следующим образом:
* канал 2: ответы серверу (GotBlocks и т. п.);
* канал 1: подключение, аутентификация;
* канал 0: всё остальное.

Каналы «вниз» используются следующим образом:
* канал 2: объёмные данные;
* канал 1: данные HUD;
* канал 0: всё остальное.

Поскольку порядок пакетов поддерживается только в пределах канала, операции над одним объектом должны осуществляться в рамках одного канала.

## Изменения
* **2018-10-10 Протокол 37.** (0a5e771)
* 2018-12-04 добавление Down/NodeMetaChanged (3d66622)
* 2018-12-13, 2019-01-03 передача чисел в формате IEEE (839e935, bba4563)
* 2019-02-10 замена u8 на u16 в Up/Damage (ffb17f1)
* **2019-03-04 Minetest 5.0**
* 2019-03-07 игнорирование длины строки в Down/DetachedInventory/update (ac86d04)
* 2019-08-10 добавление Down/PlayerSpeed (cf64054)
* **2019-08-24 Протокол 38.** Отправка только изменённой части инвентаря. (0b4f424)
* 2019-09-19 добавление Down/Fov (47da640)
* **2019-10-12 Minetest 5.1**
* **2020-03-05 Протокол 39.** Новая обработка неба. Добавление Down/SetSun, Down/SetMoon, Down/SetStars. (946c03c, разработан 2019-08-21)
* **2020-04-05 Minetest 5.2**
* 2020-05-02 добавление Down/SetFov/transition_time (e0ea87f)
* 2020-05-11 добавление Down/HudAdd/text2 (6e1372b)
* 2020-06-13 добавление Down/MediaPush (2424dfe)
* 2020-06-13 добавление бита zoom в PlayerPos (e7e065f)
* **2020-07-09 Minetest 5.3**
