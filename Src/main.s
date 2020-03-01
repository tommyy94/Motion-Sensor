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
  dsb   sy                    /* Use memory barrier */
  cpsid i                     /* Set PRIMASK */

  bl    SystemInit
  bl    PORTD_Init
  bl    TPM_Init
  bl    LPTMR_Init
  bl    CMP0_Init
  bl    Sleep_Init

  bl    PollButton            /* To prevent lockout */

  cpsie i                     /* Clear PRIMASK */

  dsb   sy                    /* Use memory barrier */
  wfi                         /* Set sleep mode */
 
  .end
