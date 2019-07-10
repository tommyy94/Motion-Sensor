#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb
  .text


/**
 * Main entry point.
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type _start, %function
  .global _start
_start:
  bl    COP_Disable
  bl    MCG_Init
  bl    PORTB_Init
  bl    TPM_Init

loop:
  /* Read flag */
  ldr   r0, =PORTB_IRQFlag    /* Load flag address, used as argument aswell */
  ldr   r4, [r0]              /* Load flag value */
  cmp   r4, #1                /* If flag not set */
  bne   loop                  /* Repeat loop */
  bl    DriveLed              /* Else lights on */

  b     loop


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
  .text
  .thumb_func
  .type COP_Disable, %function
  .global COP_Disable
COP_Disable:
  ldr   r4, =SIM_COPC             /* Load address to register */
  movs  r5, #0                    /* Clear register */
  str   r5, [r4]                  /* Write 0 SIM + COPC offset */
  bx    lr


  .end
