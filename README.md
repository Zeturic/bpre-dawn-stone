## Specialized Evolutionary Stones

This adds evolution methods where an evolutionary stone will only trigger when the Pokémon is a particular gender, like the Dawn Stone for Kirlia -> Gallade and Snorunt -> Froslass.

Additionally included is an evolution method where an evolutionary stone will only trigger when the Pokémon is holding a particular item; said held item will be removed during the evolution. This could be used alongside a `Link Cable` evolutionary "stone" to handle Pokémon that evolve by trading while holding an item.

![](example.png)

### How do I insert this?

Open `config.s` in a text editor.

Decide where you want the code to be inserted, and update the defition of `free_space` to match.

If you have expanded the number of evolutions per Pokémon beyond `5`, make sure to update `EVOS_PER_MON` to match.

The rest of the configuration is assigning evolution method ids. For example, evolving by trade is id `0x06`, and evolving by happiness is id `0x01`. Naturally, they need to be unique. An unmodified FR has 15 evolution method ids, ranging from `0x01` to `0x0F`, so the first new evolution method added should be `0x10` and so on.

Pick an evolution method id for evolving male Pokémon with an evolutionary stone and update `EVO_ITEM_MALE` with it. Alternatively, set `EVO_ITEM_MALE` to `0x00` if you don't want that evolution method inserted.

Pick an evolution method id for evolving female Pokémon with an evolutionary stone and update `EVO_ITEM_FEMALE` with it. Alternatively, set `EVO_ITEM_FEMALE` to `0x00` if you don't want that evolution method inserted.

Pick an evolution method id for evolving Pokémon holding a held item with an evolutionary stone and update `EVO_ITEM_HELD_ITEM` with it. Alternatively, set `EVO_ITEM_HELD_ITEM` to `0x00` if you don't want that evolution method inserted.

Copy your ROM to this folder and rename it `rom.gba`.

You'll need [armips](https://github.com/Kingcom/armips) for the next part.

Open a terminal / command prompt and run `armips evolutionary-stone.asm`. This will create a modified copy of `rom.gba` in `test.gba`; `rom.gba` will not be modified.

### How do I modify PGE's ini to match?

The relevant keys in the ini are `NumberOfEvolutionTypes`, `EvolutionNameX` and `EvolutionXParam`.

For the sake of example, I will assume these were the first evolution methods you've added and they were added as 0x10, 0x11, and 0x12 (written in decimal, 16, 17, and 18). I would do:

```ini
NumberOfEvolutionTypes=18
EvolutionName16=Item w/ Held Item
Evolution16Param=item
EvolutionName17=Item w/ Male
Evolution17Param=item
EvolutionName18=Item w/ Female
Evolution18Param=item
```

That will allow you to assign these evolution methods to Pokémon and their associated evolutionary stones.

### What about the held item for that evolution method?

Setting the held item of a `Item w/ Held Item` evolution will require hex editing, because the held item is stored in the [two padding bytes](https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_evolution_data_structure_in_Generation_III) which PGE does not support editing.

If that's enough for you to understand how to set it up, you can stop reading here. If not, read on.

You'll need to calculate `gEvolutionTable + i * (8 * EVOS_PER_MON) + (8 * j) + 6`, or more succinctly `gEvolutionTable + 8 * (i * EVOS_PER_MON + j) + 6`, where `i` is the species id of the Pokémon in question and `j` is the "evolution slot id" where `0` would be that Pokémon's first evolution slot, and `1` would be the second evolution slot, and so on. Just pull up that address in a hex editor and put the held item there.

In an unmodified FR, `gEvolutionTable` is located at `0x08259754`, and of course `EVOS_PER_MON` is `5`.

For an example, we'll set up Seadra's evolution into Kingdra. `SPECIES_SEADRA` is `0x75`, and `ITEM_DRAGON_SCALE` is `0xC9`. We're going to put this evolution in the second slot, keeping the standard `Trade w/ Item` evolution into Kingdra in the first. We'll also assume that `gEvolutionTable` and `EVOS_PER_MON` are still vanilla.

Set up the evolution as much as possible in PGE, then put `C9 00` at `0x08259754 + 8 * (0x75 * 5 + 1) + 6 = 0x0825A9AA` in a hex editor.
