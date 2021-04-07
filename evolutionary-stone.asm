.include "config.s"
.include "labels.s"
.include "constants.s"

// -----------------------------------------------------------------------------

.gba
.thumb

.open inrom, outrom, 0x08000000

// -----------------------------------------------------------------------------

.org free_space
.align 2

stonecheck:

@@main:                             // [r3], r5, r7, [r8], r9 := evolution_table, trigger, species, pokemon, chosen_stone
    mov r4, r7
    mov r0, EVOS_PER_MON * 8
    mul r4, r0
    add r4, r3                      // r4 := [evolution_table[species]]
    add r0, r4, r0                  // r0 := [evolution_table[species + 1]]
    sub sp, #4
    str r0, [sp]
    
@@loop:
    ldrh r0, [r4, #2]                // r0 := condition
    cmp r0, r9
    bne @@next

    ldrh r0, [r4, #0]                // r0 := type
    cmp r0, EVO_ITEM
    beq @@doevo

    .if EVO_ITEM_MALE
    cmp r0, EVO_ITEM_MALE
    beq @@checkmale
    .endif

    .if EVO_ITEM_FEMALE
    cmp r0, EVO_ITEM_FEMALE
    beq @@checkfemale
    .endif

    .if EVO_ITEM_HELD_ITEM
    cmp r0, EVO_ITEM_HELD_ITEM
    beq @@checkhelditem
    .endif

@@next:
    add r4, #8
    ldr r0, [sp]
    cmp r0, r4
    bne @@loop

    ldr r0, =GetEvolutionTargetSpecies_hook_return_failure |1
    add sp, #4
    bx r0

@@doevo:
    mov r1, r4
    ldr r0, =GetEvolutionTargetSpecies_hook_return_success |1
    add sp, #4
    bx r0

.if EVO_ITEM_MALE
@@checkmale:
    mov r6, #0
    b @@checkgender
.endif

.if EVO_ITEM_FEMALE
@@checkfemale:
    mov r6, #254
.endif

.if EVO_ITEM_MALE || EVO_ITEM_FEMALE
@@checkgender:
    mov r0, r7
    mov r1, r8
    ldr r1, [r1]
    ldr r3, =GetGenderFromSpeciesAndPersonality |1
    bl @@call

    cmp r0, r6
    beq @@doevo
    b @@next
.endif

.if EVO_ITEM_HELD_ITEM
@@checkhelditem:
    mov r0, r8
    mov r1, #MON_DATA_HELD_ITEM
    mov r2, #0
    ldr r3, =GetMonData |1
    bl @@call

    ldrh r1, [r4, #6]
    cmp r0, r1
    bne @@next

    // #3 signifies the evolution is really happening
    // not just being checked for (which is #2)
    cmp r5, #3
    bne @@doevo

    mov r0, r8
    mov r1, #MON_DATA_HELD_ITEM
    ldr r2, =@@zero
    ldr r3, =SetMonData |1
    bl @@call

    b @@doevo
.endif

@@call:
    bx r3

.if EVO_ITEM_HELD_ITEM
.align 2

@@zero:
    .halfword 0
.endif

.pool

// -----------------------------------------------------------------------------

.org GetEvolutionTargetSpecies_hook_addr
.area 0x20, 0xFE
    ldr r0, =stonecheck |1
    bx r0
    .pool
.endarea

.org 0x0811F4B0
mov r1, #2

.org 0x0804202E
mov r1, #3

.close
