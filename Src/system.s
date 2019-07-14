#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb

  .text


/**
 * Initialize Low Power features.
 *
 * Registers modified: 
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type LP_Init, %function
  .global LP_Init
LP_Init:
  

  bx    lr


  .end
