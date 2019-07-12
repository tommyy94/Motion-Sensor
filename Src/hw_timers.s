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
  push  {LR}

  /* Reset system prescalers */
  movs  r4, #0
  ldr   r5, =SIM_CLKDIV1              /* Load address */
  ldr   r6, =MCG_C1                   /* Load address */
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

  bl    CheckFLL

  /*  Wait until internal reference clock is selected as MCG output */
  ldr   r6, =MCG_S_CLKST(2)           /* External reference clock selected */
  ldr   r3, =(MCG_S_OSCINIT0_MASK     /* Wait until crystal oscillator initialized */ \
            | MCG_S_IRCST_MASK)       /* Internal reference clock sourced by fast clock (4 MHz IRC) */
WaitMCGOutput:
  ldrb  r7, [r5]                      /* Refresh MCG_S value */
  ands  r7, r7, r6
  tst   r7, r3
  bne   WaitMCGOutput                 /* MCG_S & MCG_S_CLKST(2) != MCG_S_OSCINIT0_MASK | MCG_S_IRCST_MASK */

  /* Switch to BLPI mode */
  ldrb  r3, [r4]                      /* Load MCG_C2 value */
  /* Disable the following options: */
  ldr   r5, =~(MCG_C2_LOCRE0_MASK     /* Internal reference clock */                              \
            | MCG_C2_RANGE0(0x03)     /* Very high frequency range for the crystal oscillator */  \
            | MCG_C2_HGO0_MASK        /* High-gain oscillator mode */                             \
            | MCG_C2_EREFS0_MASK)     /* Oscillator requested reference select */
  /* Enable options: */
  ldr   r2, =(MCG_C2_IRCS_MASK        /* Fast internal reference clock */                         \
            | MCG_C2_LP_MASK)         /* FLL disabled in bypass modes */
  ands  r3, r3, r5
  orrs  r3, r3, r2
  strb  r3, [r4]                      /* Write MCG_C2 */
  
  bl    CheckFLL

  /* Check that the fast external reference clock is selected. */
  /* r5: MCG_S address */
  ldr   r6, =MCG_S_IREFST_MASK
CheckExtClk:
  ldrb  r7, [r5]
  tst   r7, r6
  beq   CheckExtClk

  pop   {PC}


/**
 * Check that FLL reference clock source is the internal reference clock.
 *
 * Registers modified: r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type CheckFLL, %function
CheckFLL:
  ldr   r5, =MCG_S
  ldr   r6, =MCG_S_IREFST_MASK

CheckFLL_Loop:
  ldrb  r7, [r5]
  tst   r7, r6
  beq   CheckFLL_Loop

  bx    LR


/**
 * Initialize Timer/PWM Module.
 *
 * Registers modified: r2, r3, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 * Todo.      Figure out TPM_MOD register */
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type TPM_Init, %function
  .global TPM_Init
TPM_Init:
  /* No need to save argument registers in init section */

  /* Enable PORTA clock gating */
  ldr   r4, =SIM_SCGC5              /* Load address */
  ldr   r5, =SIM_SCGC5_PORTA_MASK   /* Load mask value */
  ldr   r6, [r4]                    /* Read SIM_SCGC5 */
  movs  r7, #0                      /* Clear register */
  orrs  r6, r5                      /* SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK */
  adds  r7, r4, #0x04               /* SIM_SCGC6 = SIM_SCGC5 + offset 0x04, arithmetic is faster than memory access */
  str   r6, [r4]                    /* Write SIM_SCGC5 */

  /* Enable TPM clock gating */
  ldr   r5, =SIM_SCGC6_TPM_MASK     /* Load mask value */
  ldr   r6, [r7]                    /* r7: SIM_SCGC6 */
  ldr   r4, =PORTA_PCR              /* Load address */
  orrs  r6, r5                      /* SIM_SCGC6 |= SIM_SCGC6_TPM_MASK */

  /* Select pin multiplexer */
  ldr   r3, =PORT_PCR_MUX(2)        /* Select TPM */ 
  str   r6, [r7]                    /* Write SIM_SCGC6 */
  str   r3, [r4, #(0x04 * 6)]       /* Write to PTA6: 0x06 * 0x04 = 0x18 offset */

  /* Set clock source for TPM */
  ldr   r6, =TPM_MOD                /* Load counter address */
  ldr   r3, [r6]                    /* Read TPM_MOD value */
  ldr   r4, =SIM_SOPT2              /* Load address */
  ldr   r5, =SIM_SOPT2_TPMSRC(1)    /* MCGFLLCLK as clock source */
  ldr   r7, =4800 -1                /* Load immediate value */
  orrs  r3, r3, r7                  /* TPM_MOD |= 4800 - 1 */
  str   r5,  [r4]                   /* Write SIM_SOPT2 */

  /* Load counter */
  str   r3, [r6]                    /* Write TPM_MOD */

  /* Set SC register */
  ldr   r4, =TPM_SC                 /* Load address */
  ldr   r6, =TPM_C0SC               /* Load address */
  ldr   r5, =(TPM_SC_CPWMS_MASK     /* Up-down counting mode */   \
            | TPM_SC_PS(1))         /* Prescale divide by 2 */
  ldr   r7, =(TPM_CnSC_MSB_MASK     /* Edge-aligned PWM: */       \
            | TPM_CnSC_ELSA_MASK)   /* Clear output on match, set output on reload */
  str   r5, [r4]

  /* Configure PWM */     
  ldr   r2, =4800                   /* Set TPM0 Channel 0 value */   
  ldr   r3, =TPM_C0V                /* Load address */  
  str   r7, [r6]                    /* Write TPM_C0SC */

  /* Set TPM value */
  str   r2, [r3]                    /* Write TPM_C0V */

  bx    LR


/**
 * Drive LED with PWM.
 *
 * Registers modified: r4, r5, r6, r7
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
  ldr   r6, =TPM_SC                 /* Load TPM_SC address */
  ldr   r7, =TPM_SC_CMOD(1)         /* Load mask */
  ldr   r5, [r6]                    /* Load TPM_SC value */
  movs  r4, #0                      /* Reset flag value */
  orrs  r5, r5, r7                  /* Select clock mode enabling TPM */
  str   r4, [r0]                    /* Write flag value */
  str   r5, [r6]                    /* Start PWM */

  bx    LR


  .end
