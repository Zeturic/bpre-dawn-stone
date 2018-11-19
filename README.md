## Specialized Evolutionary Stones

This adds evolution methods where an evolutionary stone will only trigger when the Pokémon is a particular gender, like the Dawn Stone for Kirlia -> Gallade and Snorunt -> Froslass.

Additionally included is an evolution method where an evolutionary stone will only trigger when the Pokémon is holding a particular item; the held item will be removed during the evolution. This could be used alongside a `Link Cable` evolutionary "stone" to handle Pokémon that evolve by trading while holding an item.

![](example.png)

### How do I build this?

Open `evolutionary-stone.asm` in your text editor of choice.

`rom` should be your ROM's filename.

`free_space` is where you want the code to be inserted. You'll need `148` bytes, starting from a word-aligned offset (read: an offset ending in `0`, `4`, `8`, or `C`). 

If you've expanded your evolution table to support more than `5` evolutions per Pokémon, adjust the definition of `EVOLUTIONS_PER_POKEMON`.

By default, the evolution method ids are `16` for `Held Item + Stone`, `17` for `Male + Stone`, and `18` for `Female + Stone`. If that doesn't work for you, change `HELD_STONE`, `MALE_STONE`, and `FEMALE_STONE`. Additionally, if you don't want one of them, you can set them to `0` and their code will not get inserted and the space used will be less (`148` bytes is if everything is enabled).

You'll need to have [armips](https://github.com/Kingcom/armips).

Once you're ready, assemble with `armips evolutionary-stone.asm`. It'll insert the code directly into your ROM.