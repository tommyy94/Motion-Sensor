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
  dsb                         /* Wait until all outstanding memory accesses completed */
  cpsid i                     /* Set PRIMASK */

  bl    SystemInit
  bl    PORTD_Init
  bl    TPM_Init
  bl    LPTMR_Init

  bl    PollButton            /* To prevent lockout */

  cpsie i                     /* Clear PRIMASK */

loop:
  dsb                         /* Wait until all outstanding memory accesses completed */
  wfi                         /* Set sleep mode */
  b     loop


  .end
