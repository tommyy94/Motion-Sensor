  .include "Inc/peripherals.inc"
  .include "Inc/core.inc"

  .syntax unified
  .thumb
  .text


/**
 * Enable PORTB clock and interrupts.
 *
 * Registers modified: r0, r1, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .text
  .thumb_func
  .type PORTB_Init, %function
  .global PORTB_Init
PORTB_Init:
  push  {LR}

  /* Enable clock gating */
  ldr   r4, =SIM_SCGC5
  ldr   r5, =SIM_SCGC5_PORTB_MASK
  ldr   r6, [r4]
  orrs  r6, r5
  str   r6, [r4]

  /* Select multiplexer */
  ldr   r4, =PORTB_PCR            /* Load address */
  ldr   r5, =PORT_PCR_MUX_MASK    /* Load multiplexer mask */
  str   r5, [r4, #0x00]           /* Set PTB0 as GPIO */

  /* Set data direction */
  ldr   r4, =GPIOB_PDDR           /* Load GPIOB base addess */
  movs  r5, #(1 << 0)             /* Load PTB0 */
  str   r5, [r4]                  /* Write output pin */

  /* Initialize PORTA NVIC */
  movs  r0, #PORTB_IRQn           /* Load interrupt vector position */
  ldr   r1, =NVIC_IPRn_LEVEL1     /* Load interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ
  cpsie i                         /* Clear PRIMASK */

  pop   {PC}


  .end
