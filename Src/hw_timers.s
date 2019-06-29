#include "core.h"
#include "peripherals.h"


  .syntax unified
  .thumb
  .text


/**
 * Initialize Timer/PWM Module.
 *
 * Registers modified: r4, r5, r6
 *
 * Argument:  r0
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type TPM_Init, %function
  .global TPM_Init
TPM_Init:
  /* Enable clock gating */
  ldr   r4, =SIM_SCGC6
  ldr   r5, =SIM_SCGC6_TPM_MASK
  ldr   r6, [r4]
  orrs  r6, r5
  str   r6, [r4]

  /* Set clock source for TPM */
  ldr   r4, =SIM_SOPT2              /* Load base address */
  ldr   r5, =SIM_SOPT2_TPMSRC(1)    /* MCGFLLCLK as clock source */
  str   r5,  [r4]                   /* Write */

  /* Select pin multiplexer */
  ldr   r4, =PORTA_PCR              /* Load address */
  ldr   r5, =PORT_PCR_MUX(2)        /* Select TPM */ 
  str   r5, [r4, #(0x04 * 6)]       /* Write to PTA6: 0x06 * 0x04 = 0x18 offset */

  bx    lr


/**
 * Drive LED with PWM.
 *
 * Registers modified: r4
 *
 * Argument:  r0
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type DriveLed, %function
  .global DriveLed
DriveLed:
  /* Reset flag */
  movs  r4, #0
  str   r4, [r0]

  /* Do work here */

  bx    lr


  .end
