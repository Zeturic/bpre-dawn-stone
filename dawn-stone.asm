// change these constants as needed

rom equ "firered.gba"
.definelabel free_space, 0x08800000

EVOLUTIONS_PER_POKEMON equ 5

MALE_STONE equ 17
FEMALE_STONE equ 18

// -----------------------------------------------------------------------------
.definelabel hook, 0x08043182
.definelabel noevo_return, 0x080431A2
.definelabel doevo_return, 0x0804317C

.definelabel pokemon_getattr, 0x0803FBE8 
.definelabel pokemon_species_get_gender_info, 0x0803F78C 

STONE equ 7

// -----------------------------------------------------------------------------
.gba
.thumb

.open rom, 0x08000000

// -----------------------------------------------------------------------------
.org free_space

.area 104
    .align 2
    
    stonecheck:

    @@main:                             // [r3], r5, r7, [r8], r9 := evolution_table, trigger, species, pokemon, chosen_stone
        mov r4, r7
        mov r0, EVOLUTIONS_PER_POKEMON
        lsl r0, r0, #3
        mul r4, r0
        add r4, r3                      // r4 := [evolution_table[species]]
        add r6, r4, r0                  // r6 := [evolution_table[species + 1]]

    @@loop:
        ldrh r0, [r4, 2]                // r0 := condition
        cmp r0, r9
        bne @@next

        ldrh r0, [r4, #0]                // r0 := type
        cmp r0, STONE
        beq @@doevo
        cmp r0, MALE_STONE
        beq @@checkmale
        cmp r0, FEMALE_STONE
        beq @@checkfemale

    @@next:
        add r4, #8
        cmp r6, r4
        bne @@loop

        ldr r0, =noevo_return |1
        bx r0

    @@doevo:
        mov r1, r4
        ldr r0, =doevo_return |1
        bx r0

    @@checkmale:
        mov r5, #0
        b @@checkgender

    @@checkfemale:
        mov r5, #254

    @@checkgender:
        bl @@get_personality
        lsl r1, r0, #24
        lsr r1, r1, #24
        bl @@get_gender

        cmp r0, r5
        beq @@doevo
        b @@next

    @@get_personality:
        mov r0, r8
        mov r1, #0
        mov r2, #0
        ldr r3, =pokemon_getattr |1
        bx r3

    @@get_gender:
        mov r0, r7
        ldr r3, =pokemon_species_get_gender_info |1
        bx r3

    .pool
.endarea

// -----------------------------------------------------------------------------
.org hook
ldr r0, =stonecheck |1
bx r0
.pool

.close