## Specialized Evolutionary Stones

This adds evolution methods where an evolutionary stone will only trigger when the Pokémon is a particular gender, like the Dawn Stone for Kirlia -> Gallade and Snorunt -> Froslass.

Additionally included is an evolution method where an evolutionary stone will only trigger when the Pokémon is holding a particular item; the held item will be removed during the evolution. This could be used alongside a `Link Cable` evolutionary "stone" to handle Pokémon that evolve by trading while holding an item.

![](example.png)

### How do I build this?

Open `evolutionary-stone.asm` in your text editor of choice.

`rom` should be your ROM's filename.

`free_space` is where you want the code to be inserted. You'll need `148` bytes, starting from a word-aligned offset (read: an offset ending in `0`, `4`, `8`, or `C`). 

If you've expanded your evolution table to support more than `5` evolutions per Pokémon, adjust the definition of `EVOLUTIONS_PER_POKEMON`.

By default, the evolution method ids for the gender-specific evolutionary stones are `17` for `Male + Stone` and `18` for `Female + Stone`. `Held Item + Stone` defaults to `0`, which disables it and stops its code from being inserted and taking up space in your ROM.

You can change the ids as needed by modifying `MALE_STONE`, `FEMALE_STONE`, and `HELD_STONE`. Any of the three can be disabled by setting them to `0`. For example, you could disable both `Male + Stone` and `Female + Stone` by setting `MALE_STONE` and `FEMALE_STONE` to `0` while simultaneously giving `Held Item + Stone` evolution method id `23` by setting `HELD_STONE` to `23`.

The necessary `148` bytes mentioned above is specifically if every evolution method is enabled. It'll be less if one or more evolution methods are disabled.

You'll need to have [armips](https://github.com/Kingcom/armips).

Once you're ready, assemble with `armips evolutionary-stone.asm`. It'll insert the code directly into your ROM.

It should be noted that `Held Item + Stone` evolutions will require hex editing to set up. With a proper ini, you could set the evolution method and evolutionary stone with PGE, but the held item is stored in the [two padding bytes](https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_evolution_data_structure_in_Generation_III) which PGE does not support editing.