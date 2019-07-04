#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb

  .data
  .align 4
  .global PORTB_IRQFlag
PORTB_IRQFlag:
  .word 0


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
  push  {LR}                      /* Save return address */

  /* Enable clock gating */
  ldr   r4, =SIM_SCGC5
  ldr   r5, =SIM_SCGC5_PORTB_MASK
  ldr   r6, [r4]
  orrs  r6, r5
  str   r6, [r4]

  /* Initialize PTB0 interrupt */
  ldr   r4, =PORTB_PCR            /* Load address */
  ldr   r5, =(PORT_PCR_MUX(1)     /* Select GPIO */               \
            | PORT_PCR_IRQC(9)    /* Interrupt on rising edge */  \
            | PORT_PCR_PE_MASK    /* Enable pullup/pulldown */    \
            | PORT_PCR_PS_MASK)   /* Select pulldown */
  str   r5, [r4, #0x00]           /* Write to PTB0: 0 * 0x04 = 0x00 offset */

  /* Initialize PORTB NVIC */
  movs  r0, #PORTB_IRQn           /* Load interrupt vector position */
  ldr   r1, =NVIC_IPRn_LEVEL1     /* Load interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ
  cpsie i                         /* Clear PRIMASK */

  pop   {PC}                      /* Load return address */


/**
 * PORTB Interrupt Request Handler. Set interrupt flag.
 *
 * Registers modified: None
 *
 * Argument:  None
 * Return:    None
 * Todo:      Figure out why startup triggers this
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .text
  .thumb_func
  .type PORTB_IRQHandler, %function
  .global PORTB_IRQHandler
PORTB_IRQHandler:
  movs  r2, #1                    /* Set flag value */
  ldr   r0, =PORTB_ISFR           /* Load address */
  ldr   r1, =PORT_ISFR_ISF(1)     /* Load mask */
  ldr   r3, =PORTB_IRQFlag        /* Load flag address */
  str   r1, [r0]                  /* Clear pending interrupts in peripheral */
  str   r2, [r3]                  /* Set flag */

  bx    LR


  .end
