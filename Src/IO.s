#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb


  .text


/**
 * Enable PORTD clock and interrupts.
 *
 * PTD2 as input, PTD3 as external interrupt.
 *
 * Registers modified: r0, r1, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type PORTD_Init, %function
  .global PORTD_Init
PORTD_Init:
  push  {LR}                      /* Save return address */

  /* Enable clock gating & PTD2 MUX */
  ldr   r4, =SIM + SIM_SCGC5      /* Load address */
  ldr   r5, =SIM_SCGC5_PORTD_MASK /* Load value */
  ldr   r6, [r4]                  /* Load SIM_SCGC5 value */
  ldr   r7, =PORTD                /* Load address */
  orrs  r6, r5                    /* SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK */
  ldr   r0, =(PORT_PCR_MUX(1)     /* Select GPIO */               \
            | PORT_PCR_IRQC(9))   /* Interrupt on rising edge, default pulldown */
  str   r6, [r4]                  /* Write SIM_SCGC5 */
  ldr   r5, =PORT_PCR_MUX(1)      /* Select GPIO */
  str   r0, [r7, #PORT_PCR        /* Write to PTD PCR */          \
                + (2 * 0x04)]     /* Write to PTD2: 2 * 0x04 = 0x08 offset */

  /* Initialize FPTD3 input & reset PORTD_ISFR */
  ldr   r4, =FPTD                 /* Load base address */
  ldr   r0, =PORTD + PORT_ISFR    /* Load address */
  ldr   r1, =0xFFFFFFFF           /* Reset peripheral interrupt flags */
  str   r5, [r7, #PORT_PCR        /* Write to PTD3: */            \
               + (3 * 0x04)]      /* 3 * 0x04 = 0x0C offset */
  str   r1, [r0]                  /* PORTD_ISFR = 0xFFFFFFFF */
  movs  r6, #(1 << 3)             /* Load FPTD3 */
  ldr   r5, [r4, #FPT_PDDR]       /* Load value */
  movs  r0, #PORTD_IRQn           /* Load interrupt vector position */
  bics  r5, r5, r6                /* Clear FPTD3 bit */
  movs  r1, #NVIC_IPRn_LEVEL1     /* Load interrupt priority */
  str   r5, [r4]                  /* Write FPTD_PDDR */

  /**
   * Initialize PORTD NVIC
   *  r0: Interrupt vector position
   *  r1: interrupt priority
   */
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
  ldr   r4, =FPTD                 /* Load base address */
  movs  r5, #(1 << 3)             /* Pin number to poll */

PollButtonLoop:
  ldr   r6, [r4, #FPT_PDIR]       /* Read switch state */
  tst   r6, r5                    /* FPTD_PDIR & FPTD2 */
  beq   PollButtonLoop            /* Loop until switch is pressed */

  bx    LR


/**
 * PORTD Interrupt Request Handler. Set interrupt flag.
 *
 * Registers modified: None
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type PORTD_IRQHandler, %function
  .global PORTD_IRQHandler
PORTD_IRQHandler:
  push  {LR}

  /* Clear interrupt flag */
  ldr   r0, =PORTD + PORT_ISFR        /* Load address */
  ldr   r1, =PORT_ISFR_ISF(4)         /* Load mask */
  ldr   r2, [r0]                      /* Load PORTD_ISFR value */
  tst   r2, r1
  beq   PORTD_IRQHandler_End          /* If flag == zero => goto end */
  str   r1, [r0]                      /* Clear pending interrupts in peripheral */

  /* Stop timer to allow modifying register */
  ldr   r0, =LPTMR0                   /* Load Low Power Timer 0 base address */
  ldr   r1, [r0, #LPTMR0_CSR]         /* Read register */
  movs  r3, #(LPTMR_CSR_TEN_MASK \
            | LPTMR_CSR_TIE_MASK)
  bics  r1, r1, r3                    /* Disable LPTMR0 and interrupt */
  str   r1, [r0, #LPTMR0_CSR]         /* Write LPTMR0_CSR */

  /* Write new timer value and start LED timer */
  ldr   r2, =LPTMR_CMR_COMPARE(5000)  /* Compare match on 5s */
  ldr   r1, [r0, #LPTMR0_CSR]         /* Read register */
  str   r2, [r0, #LPTMR0_CMR]         /* Write LPTMR0_CMR */
  orrs  r1, r1, r3                    /* Enable timer & interrupt */
  str   r1, [r0, #LPTMR0_CSR]         /* Write LPTMR0_CSR */

  bl    DriveLed

PORTD_IRQHandler_End:
  pop   {PC}


  .end
