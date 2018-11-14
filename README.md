## Gender-specific Evolutionary Stones

This adds evolution methods where an evolutionary stone will only trigger when the Pokémon is a particular gender, like the Dawn Stone for Kirlia -> Gallade and Snorunt -> Froslass.

![](example.png)

### How do I build this?

Open `dawn-stone.asm` in your text editor of choice.

`rom` should be your ROM's filename.

`free_space` is where you want the code to be inserted. You'll need `88` bytes, starting from a word-aligned offset (read: an offset ending in `0`, `4`, `8`, or `C`). 

If you've expanded your evolution table to support more than `5` evolutions per Pokémon, adjust the definition of `EVOLUTIONS_PER_POKEMON`.

By default, the evolution method ids are `17` for `Male + Stone` and `18` for `Female + Stone`. If that doesn't work for you, change `MALE_STONE` and `FEMALE_STONE`.

You'll need to have [armips](https://github.com/Kingcom/armips).

Once you're ready, assemble with `armips dawn-stone.asm`. It'll insert the code directly into your ROM.