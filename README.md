
![](example.png)

### How do I build this?

You will need to set an `ARMIPS` environment variable pointing to your `armips.exe`. You also need a `DEVKITARM` environment pointing to devkitARM v45's installation directory (likely `C:\devkitPro\devkitARM`).

Python 3.6 or later is required.

Place your ROM in the project root directory and name it `rom.gba`. Run `python scripts/makinoa`. Your output is `test.gba`; `rom.gba` will be left unmodified.