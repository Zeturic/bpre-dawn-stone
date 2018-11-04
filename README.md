## Gender-specific Evolutionary Stones

This adds evolution methods where an evolutionary stone will only trigger when the Pokemon is a particular gender, like the Dawn Stone for Kirlia -> Gallade and Snorunt -> Froslass.

![](example.png)

### How do I build this?

If you've expanded your evolution table to support more than `5` evolutions per Pokemon, adjust the definition of `EVOLUTIONS_PER_POKEMON` in `constants.s`.

By default, the evolution method ids are `17` for `Male + Stone` and `18` for `Female + Stone`. If that doesn't work for you, change `MALE_STONE` and `FEMALE_STONE`, also in `constants.s`.

You will need to set an `ARMIPS` environment variable pointing to your `armips.exe`. You also need a `DEVKITARM` environment pointing to devkitARM v45's installation directory (likely `C:\devkitPro\devkitARM`).

Python 3.6 or later is required.

Place your ROM in the project root directory and name it `rom.gba`. Run `python scripts/makinoa`. Your output is `test.gba`; `rom.gba` will be left unmodified.
