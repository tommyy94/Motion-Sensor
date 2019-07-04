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
 * Todo:      Configure MCG peripheral
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type TPM_Init, %function
  .global TPM_Init
TPM_Init:
  /* Enable TPM clock gating */
  ldr   r4, =SIM_SCGC6
  ldr   r5, =SIM_SCGC6_TPM_MASK
  ldr   r6, [r4]
  orrs  r6, r5
  str   r6, [r4]
  
  /* Enable PORTA clock gating */
  ldr   r4, =SIM_SCGC5
  ldr   r5, =SIM_SCGC5_PORTA_MASK
  ldr   r6, [r4]
  orrs  r6, r5
  str   r6, [r4]

  /* Select pin multiplexer */
  ldr   r4, =PORTA_PCR              /* Load address */
  ldr   r5, =PORT_PCR_MUX(2)        /* Select TPM */ 
  str   r5, [r4, #(0x04 * 6)]       /* Write to PTA6: 0x06 * 0x04 = 0x18 offset */

  /* Set clock source for TPM */
  ldr   r4, =SIM_SOPT2              /* Load address */
  ldr   r5, =SIM_SOPT2_TPMSRC(1)    /* MCGFLLCLK as clock source */
  str   r5,  [r4]                   /* Write */

  /* Load counter */
  ldr   r4, =TPM_MOD
  ldr   r5, =4800 -1                /* Load immediate value */
  str   r5, [r4]

  /* Set SC register */
  ldr   r4, =TPM_SC
  ldr   r5, =(TPM_SC_CPWMS_MASK     /* Up-down counting mode */   \
            | TPM_SC_PS(1))         /* Prescale divide by 2 */
  str   r5, [r4]

  /* Configure PWM */
  ldr   r4, =TPM_C0SC             
  ldr   r5, =(TPM_CnSC_MSB_MASK     /* Edge-aligned PWM: */        \
            | TPM_CnSC_ELSA_MASK)   /* Clear output on match, set output on reload */
  str   r5, [r4]

  /* Set TPM value */
  ldr   r4, =TPM_C0V
  ldr   r5, =4800
  str   r5, [r4]

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


  /* Start PWM */
  ldr   r4, =TPM_SC
  ldr   r5, =TPM_SC_CMOD(1)         /* Select clock mode enabling TPM */
  str   r5, [r4]

  bx    lr


  .end
