#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb

  .text


/**
 * Disable Computer Operating Properly aka
 * Watchdog Timer to avoid reset loop.
 *
 * Registers modified: r4, r5
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .thumb_func
  .type COP_Disable, %function
  .global COP_Disable
COP_Disable:
  ldr   r4, =SIM + SIM_COPC       /* Load address to register */
  movs  r5, #0                    /* Clear register */
  str   r5, [r4]                  /* Write 0 SIM + COPC offset */
  bx    LR


/**
 * Initialize Low Power features.
 *
 * Registers modified: r0, r1, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type LP_Init, %function
  .global LP_Init
LP_Init:
  ldr   r4, =SCB                        /* Load SCB base address */
  ldr   r5, =(SCB_SCR_SLEEPDEEP_Msk     /* Enable deep sleep */ \
            | SCB_SCR_SLEEPONEXIT_Msk)  /* Enable interrupt driven system */
  ldr   r6, [r4, #SCB_SCR]              /* Load SCB_SCR value */
  ldr   r0, =SIM + SIM_CLKDIV1          /* Load base address and offset */
  orrs  r5, r6, r5                      /* SCB_SCR |= SCB_SCR_SLEEPDEEP_Msk */
  ldr   r6, =(SIM_CLKDIV1_OUTDIV1(3)    /* Clock 1 Output prescaler 4 */  \
            | SIM_CLKDIV1_OUTDIV4(3))   /* Clock 4 Output prescaler 4 */
  str   r5, [r4, #SCB_SCR]              /* Write SCB_SCR */
  str   r6, [r0]                        /* Write SIM_CLKDIV1 */

  ldr   r5, =SIM_FCFG1_FLASHDOZE_MASK   /* Disable flash on sleep */
  adds  r5, #0x08                       /* Increment address to SIM_FCFG1 */
  str   r5, [r0]                        /* Write SIM_FCFG1 */

  ldr   r4, =MCG
  ldrb  r5, [r4, #MCG_C2]
  ldr   r6, =MCG_C2_LP_MASK
  orrs  r5, r5, r6

  bx    lr


  .end
