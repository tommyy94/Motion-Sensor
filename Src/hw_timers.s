#include "core.h"
#include "peripherals.h"


  .syntax unified
  .thumb
  .text



/**
 * Initialize MCG.
 *
 * Registers modified: r2, r3, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type MCG_Init, %function
  .global MCG_Init
MCG_Init:
  /* Reset system prescalers */
  movs  r4, #0
  ldr   r5, =SIM_CLKDIV1
  ldr   r6, =MCG_C1
  str   r4, [r5]                      /* Write reset here */

  /* Switch to FBI mode */
  ldr   r7, =(MCG_C1_CLKS(0x01)       /* Internal reference clock */          \
            | MCG_C1_FRDIV(0x00)      /* FLL External Reference Divider 0 */  \
            | MCG_C1_IREFS_MASK       /* Slow internal  reference clock */    \
            | MCG_C1_IRCLKEN_MASK)    /* MCGIRCLK active */

  ldr   r4, =MCG_C2                   /* Load MCG_C2 address */
  strb  r7, [r6]                      /* Write to SIM_CLKDIV1 */
  ldrb  r3, [r4]                      /* Load MCG_C2 value */

  /* Disable the following options: */
  ldr   r5, =~(MCG_C2_LOCRE0_MASK     /* Internal reference clock */                              \
            | MCG_C2_RANGE0(0x03)     /* Very high frequency range for the crystal oscillator */  \
            | MCG_C2_HGO0_MASK        /* High-gain oscillator mode */                             \
            | MCG_C2_EREFS0_MASK      /* Oscillator requested reference select */                 \
            | MCG_C2_LP_MASK)         /* FLL disabled in bypass modes */
  /* Enable option: */
  ldr   r2, =MCG_C2_IRCS_MASK         /* Fast internal reference clock */
  ands  r3, r3, r5
  ldr   r6, =MCG_C4
  orrs  r3, r3, r2

  /* Reset DCO settings */
  ldr   r7, =~(MCG_C4_DMX32_MASK \
            | MCG_C4_DRST_DRS(0x03))
  ldrb  r5, [r6]
  strb  r3, [r4]                      /* Write mask to MCG_C2 */
  ands  r5, r5, r7

  /* Configure Oscillator module */
  ldr   r3, =OSC0_CR                  /* Load OSC0 address */
  ldr   r7, =OSC_CR_ERCLKEN_MASK      /* Enable external reference clock */
  strb  r5, [r6]                      /* Write mask to MCG_C4 */
  strb  r7, [r3]                      /* Write OSC0 */

  bx    lr


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
