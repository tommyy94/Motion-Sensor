#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb


  .text


/**
 * Enable CMP0, its clock and its interrupt.
 *
 * Registers modified: 
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type CMP0_Init, %function
  .global CMP0_Init
CMP0_Init:
  push  {LR}

  /* Enable clock gating */
  ldr   r4, =SIM + SIM_SCGC4        /* Load address */
  ldr   r5, =SIM_SCGC4_CMP_MASK     /* Load value */
  str   r5, [r4]                    /* Enable CMP0 */

  ldr   r5, =CMP0
  movs  r4, #CMP_CR0_HYSTCTR(1)     /* Hysteresis level 1 */
  strb  r4, [r5, #CMP0_CR0]
  
  movs  r6, #CMP_CR1_EN(1)          /* Enable comparator */
  strb  r6, [r5, #CMP0_CR1]

  movs  r4, #(CMP_MUXCR_PSEL(5)     /* Input channel 4 (PORTE30) */   \
            | CMP_MUXCR_MSEL(7))    /* DAC channel  7 (internally) */
  strb  r4, [r5, #CMP0_MUXCR]

  movs  r6, #(CMP_DACCR_DACEN(1)    /* Enable 6-bit DAC */            \
            | CMP_DACCR_VOSEL(6))   /* Set reference voltage at 0.3V => 64 * 0.3V / 3.3V = 6 */
  strb  r4, [r5, #CMP0_DACCR]

  movs  r4, #CMP_SCR_IEF(1)         /* Interrupt on falling edge */
  strb  r4, [r5, #CMP0_SCR]

  /**
   * Initialize CMP0 NVIC
   *  r0: Interrupt vector position
   *  r1: interrupt priority
   */
  movs  r0, #CMP0_IRQn              /* Load interrupt vector position */
  movs  r1, #NVIC_IPRn_LEVEL1       /* Load interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ

  pop    {PC}

  
/**
 * CMP0 Interrupt Request Handler.
 *
 * Registers modified: None
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type CMP0_IRQHandler, %function
  .global CMP0_IRQHandler
CMP0_IRQHandler:
  /* Clear interrupt flag */
  ldr   r0, =CMP0 + CMP0_SCR          /* Load address */
  ldrb  r1, [r0]                      /* Load CM0_SCR value */

CMP0_IRQHandler_CheckCFF:
  movs  r2, #CMP_SCR_CFF(1)           /* Detect on falling edge */
  tst   r1, r2
  beq   CMP0_IRQHandler_CheckCFR      /* If flag == zero => check CFR */
  movs  r2, #CMP_SCR_CFR(1)           /* Detect on rising edge */
  b     CMP0_IRQHandler_End           /* Else go to end */

CMP0_IRQHandler_CheckCFR:
  movs  r2, #CMP_SCR_CFR(1)           /* Detect on rising edge */
  tst   r1, r2
  beq   CMP0_IRQHandler_End
  movs  r2, #CMP_SCR_CFF(1)           /* Load mask */

CMP0_IRQHandler_End:
  strb  r2, [r0]                      /* Clear pending interrupts in peripheral */
  bx    LR

  .end
