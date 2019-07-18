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
  ldr   r4, =SIM_COPC             /* Load address to register */
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
  ldr   r4, =SCB_SCR                    /* Load  address */
  ldr   r5, =(SCB_SCR_SLEEPDEEP_Msk     /* Enable deep sleep */ \
            | SCB_SCR_SLEEPONEXIT_Msk)  /* Enable interrupt driven system */
  ldr   r6, [r4]                        /* Load SCB_SCR value */
  ldr   r7, =OSC0_CR                    /* Load address */
  orrs  r5, r6, r5                      /* SCB_SCR |= SCB_SCR_SLEEPDEEP_Msk */
  ldr   r0, =OSC_CR_EREFSTEN_MASK       /* Load mask */
  str   r5, [r4]                        /* Write SCB_SCR */
  ldrb  r6, [r7]                        /* Load OSC0 value */
  orrs  r6, r6, r0                      /* OSC0 |= OSC0_CR */
  strb  r6, [r7]                        /* Write OSC0 */

  bx    lr



  .end
