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
  .thumb_func
  .type PORTB_Init, %function
  .global PORTB_Init
PORTB_Init:
  push  {LR}                      /* Save return address */

  /* Enable clock gating & PTB0 MUX */
  ldr   r4, =SIM + SIM_SCGC5      /* Load address */
  ldr   r5, =SIM_SCGC5_PORTB_MASK /* Load value */
  ldr   r6, [r4]                  /* Load SIM_SCGC5 value */
  ldr   r7, =PORTB                /* Load address */
  orrs  r6, r5                    /* SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK */
  ldr   r0, =(PORT_PCR_MUX(1)     /* Select GPIO */               \
            | PORT_PCR_IRQC(9))   /* Interrupt on rising edge, default pulldown */
  str   r6, [r4]                  /* Write SIM_SCGC5 */
  ldr   r5, =PORT_PCR_MUX(1)      /* Select GPIO */
  str   r0, [r7, #PORTB_PCR       /* Write to PTB PCR */          \
                + 0x00]           /* Write to PTB0: 0 * 0x04 = 0x00 offset */

  /* Initialize FPTB1 input & reset PORTB_ISFR */
  ldr   r4, =FPTB                 /* Load base address */
  ldr   r0, =PORTB + PORTB_ISFR   /* Load address */
  ldr   r1, =0xFFFFFFFF           /* Reset peripheral interrupt flags */
  str   r5, [r7, #0x04]           /* Write to PTB0: 1 * 0x04 = 0x04 offset */
  str   r1, [r0]                  /* PORTB_ISFR = 0xFFFFFFFF */
  movs  r6, #0x02                 /* Load FPTB1 */
  ldr   r5, [r4, #FPTB_PDDR]      /* Load value */
  movs  r0, #PORTB_IRQn           /* Load interrupt vector position */
  bics  r5, r5, r6                /* Clear FPTB1 bit */
  movs  r1, #NVIC_IPRn_LEVEL1     /* Load interrupt priority */
  str   r5, [r4]                  /* Write FTPB_PDDR */

  /* Initialize PORTB NVIC */
  /* r0: Interrupt vector position, r1: interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ

  pop   {PC}                      /* Load return address */


/**
 * Poll button until it's set. Used to prevent
 * lockout when using low power features.
 *
 * Registers modified:r4, r5, r6
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type PollButton, %function
  .global PollButton
PollButton:
  ldr   r4, =FPTB                 /* Load base address */
  movs  r5, #0x02                 /* Pin number to poll */

PollButtonLoop:
  ldr   r6, [r4, #FPTB_PDIR]      /* Read switch state */
  tst   r6, r5                    /* FPTB_PDIR & FPTB1 */
  beq   PollButtonLoop            /* Loop until switch is pressed */

  bx    LR


/**
 * PORTB Interrupt Request Handler. Set interrupt flag.
 *
 * Registers modified: None
 *
 * Argument:  None
 * Return:    None
 * Todo:      Implement filter in front of sensor + disable IRQ for 45s.
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type PORTB_IRQHandler, %function
  .global PORTB_IRQHandler
PORTB_IRQHandler:
  push  {LR}
  ldr   r0, =PORTB + PORTB_ISFR   /* Load address */
  ldr   r1, =PORT_ISFR_ISF(1)     /* Load mask */
  ldr   r2, [r0]                  /* Load PORTB_ISFR value */
  tst   r2, r1
  beq   PORTB_IRQHandler_End      /* If flag == zero => goto end */
  str   r1, [r0]                  /* Clear pending interrupts in peripheral */
  bl    DriveLed

PORTB_IRQHandler_End:
  pop   {PC}


  .end
