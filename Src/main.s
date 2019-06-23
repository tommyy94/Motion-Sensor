  .include "Inc/peripherals.inc"
  .include "Inc/core.inc"

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
  bl    PORTA_Init

loop:
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


/**
 * Enable PORTA clock and interrupts.
 *
 * Registers modified: r0, r1, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 *
 * TODO: Figure out why program hands at return.
 * Look into using stack correctly and byte aligning.
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type PORTA_Init, %function
  .global PORTA_Init
PORTA_Init:
  /* Enable clock gating */

  /*
  ldr   r4, =SIM
  ldr   r5, =SIM_SCGC6
  ldr   r6, =SIM_SCGC6_MASK
  ldr   r7, [r4, r5]
  orrs  r7, r6
  str   r7, [r4, r5]
  */

  /* Initialize PORTA EXTI */
  movs  r0, #PORTA_IRQn           /* Load interrupt vector position */
  ldr   r1, =NVIC_IPRn_LEVEL1     /* Load interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ
  bx    lr


  .end
