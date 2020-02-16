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
  .thumb_func
  .type MCG_Init, %function
  .global MCG_Init
MCG_Init:
  push  {LR}

  /* Reset system prescalers */
  movs  r4, #0                        /* Reset value */
  ldr   r5, =SIM + SIM_CLKDIV1        /* Load address */
  ldr   r0, =MCG                      /* Load MCG base address */
  str   r4, [r5]                      /* Write SIM_CLKDIV1 */

  /* Switch to FBI mode */
  ldr   r6, =(MCG_C1_CLKS(0x01)       /* Output of Internal Reference CLock */\
            | MCG_C1_FRDIV(0x00)      /* FLL External Reference Divider 0 */  \
            | MCG_C1_IREFS_MASK       /* Slow internal  reference clock */    \
            | MCG_C1_IRCLKEN_MASK)    /* MCGIRCLK active */

  ldrb  r7, [r0, #MCG_C2]             /* Load MCG_C2 value */
  strb  r6, [r0, #MCG_C1]             /* Write to MCG_C1 */

  /* Disable the following options: */
  ldr   r4, =~(MCG_C2_LOCRE0_MASK     /* Internal reference clock */                              \
            | MCG_C2_RANGE0(0x03)     /* Very high frequency range for the crystal oscillator */  \
            | MCG_C2_HGO0_MASK        /* High-gain oscillator mode */                             \
            | MCG_C2_EREFS0_MASK      /* Oscillator requested reference select */                 \
            | MCG_C2_LP_MASK)         /* FLL disabled in bypass modes */
  /* Enable option: */
  ldr   r5, =MCG_C2_IRCS_MASK         /* Fast internal reference clock */
  ands  r7, r7, r4
  orrs  r7, r7, r5

  /* Reset DCO settings */
  ldr   r4, =~(MCG_C4_DMX32_MASK \
            | MCG_C4_DRST_DRS(0x03))
  ldrb  r5, [r0, #MCG_C4]             /* Load MCG_C4 value */
  strb  r7, [r0, #MCG_C2]             /* Write mask to MCG_C2 */
  ands  r5, r5, r4

  /* Configure Oscillator module */
  ldr   r6, =OSC0                     /* Load OSC0 base address */
  movs  r4, #OSC_CR_ERCLKEN_MASK      /* Enable external reference clock */
  strb  r5, [r0, #MCG_C4]             /* Write mask to MCG_C4 */
  strb  r4, [r6, #OSC0_CR]            /* Write OSC0_CR */

  bl    CheckFLL

  /*  Wait until internal reference clock is selected as MCG output */
  movs  r4, #MCG_S_CLKST(2)           /* External reference clock selected */
  movs  r5, #(MCG_S_OSCINIT0_MASK     /* Wait until crystal oscillator initialized */ \
            | MCG_S_IRCST_MASK)       /* Internal reference clock sourced by fast clock (4 MHz IRC) */
WaitMCGOutput:
  ldrb  r6, [r0, #MCG_S]              /* Refresh MCG_S value */
  ands  r6, r6, r4
  tst   r6, r5
  bne   WaitMCGOutput                 /* MCG_S & MCG_S_CLKST(2) != MCG_S_OSCINIT0_MASK | MCG_S_IRCST_MASK */

  /* Switch to BLPI mode */
  ldrb  r4, [r0, #MCG_C2]             /* Load MCG_C2 value */
  /* Disable the following options: */
  ldr   r5, =~(MCG_C2_LOCRE0_MASK     /* Internal reference clock */                              \
            | MCG_C2_RANGE0(0x03)     /* Very high frequency range for the crystal oscillator */  \
            | MCG_C2_HGO0_MASK        /* High-gain oscillator mode */                             \
            | MCG_C2_EREFS0_MASK)     /* Oscillator requested reference select */
  /* Enable options: */
  movs  r6, #(MCG_C2_IRCS_MASK        /* Fast internal reference clock */                         \
            | MCG_C2_LP_MASK)         /* FLL disabled in bypass modes */
  ands  r4, r4, r5
  orrs  r4, r4, r6
  strb  r4, [r0, #MCG_C2]             /* Write MCG_C2 */
  
  bl    CheckFLL

  /* Check that the fast external reference clock is selected. */
  /* r5: MCG_S address */
  movs  r4, #MCG_S_IREFST_MASK
CheckExtClk:
  ldrb  r5, [r0, #MCG_S]              /* Load MCG_S value */
  tst   r5, r4
  beq   CheckExtClk

  pop   {PC}


/**
 * Check that FLL reference clock source is the internal reference clock.
 *
 * Registers modified: r6, r7
 *
 * Argument:  r0  - MCG base address
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .text
  .thumb_func
  .type CheckFLL, %function
CheckFLL:
  movs  r6, #MCG_S_IREFST_MASK

CheckFLL_Loop:
  ldrb  r7, [r0, #MCG_S]
  tst   r7, r6
  beq   CheckFLL_Loop

  bx    LR


/**
 * Initialize Low Power Timer module. It is used to
 * measure Motion Senser trigger pulse duration.
 * 100 ms pulse is recognized as movement.
 * Use LPO = 1 kHz => prescaler 2, freq. = 500 Hz.
 * Doesn't enable the timer.
 *
 * Registers modified: r2, r3, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .thumb_func
  .type LPTMR_Init, %function
  .global LPTMR_Init
LPTMR_Init:
  push  {LR}

  /* Enable LPTMR0 clock gating */
  ldr   r6, =SIM + SIM_SCGC5        /* Load SIM_SCGC5 base address */
  movs  r7, #SIM_SCGC5_LPTMR_MASK   /* Enable LPTMR0 */
  ldr   r0, [r6]                    /* Load SIM_SCGC5 value */
  orrs  r7, r0, r7                  /* SIM_SCGC5 |= SIM_SCGC5_LPTMR_MASK */
  str   r7, [r6]                    /* Write SIM_SCGC5 */

  /* Reset CSR */
  ldr   r4, =LPTMR0                 /* Load LPTMR0 base address */
  movs  r3, 0x00
  str   r3, [r4, #LPTMR0_CSR]       /* Clear LPTMR0_CSR */

  /* Set clock frequency */
  movs  r6, #(LPTMR_PSR_PRESCALE(0) /* Prescaler 2 */                     \
            | LPTMR_PSR_PBYP_MASK   /* Bypass prescaler/glitch filter */  \
            | LPTMR_PSR_PCS(1))     /* Clock source 1 kHz LPO */
  str   r6, [r4, #LPTMR0_PSR]       /* Write LPTMR0_PSR */
  movs  r5, #LPTMR_CMR_COMPARE(100) /* Compare match on 100 ms */
  str   r5, [r4, #LPTMR0_CMR]       /* Write LPTMR0_CMR */

  /**
   * Initialize PORTD NVIC
   *  r0: Interrupt vector position
   *  r1: interrupt priority
   */
  movs  r0, #LPTMR0_IRQn           /* Load interrupt vector position */
  movs  r1, #NVIC_IPRn_LEVEL1      /* Load interrupt priority */
  bl    NVIC_SetPriority
  bl    NVIC_ClearPendingIRQ
  bl    NVIC_EnableIRQ

  pop   {PC}


/**
 * LPTMR0 Interrupt Request Handler. Clear interrupt flag.
 *
 * Registers modified: None
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type LPTMR0_IRQHandler, %function
  .global LPTMR0_IRQHandler
LPTMR0_IRQHandler:
  push  {LR}

  /* Clear interrupt flag & stop timer */
  ldr   r0, =LPTMR0                 /* Load Low Power Timer 0 base address */
  movs  r1, #LPTMR_CSR_TCF_MASK     /* Clear interrupt flag */
  ldr   r2, [r0, #LPTMR0_CSR]       /* Read register */
  movs  r3, #LPTMR_CSR_TEN_MASK     /* Disable timer */
  orrs  r2, r2, r1
  bics  r2, r2, r3
  str   r2, [r0, #LPTMR0_CSR]       /* Write LPTMR0_CSR */

  bl    StopLed

End_LPTMR0_IRQHandler:
  pop   {PC}


/**
 * Drive LED with PWM.
 *
 * Registers modified: r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .thumb_func
  .type DriveLed, %function
  .global DriveLed
DriveLed:
  ldr   r6, =TPM                    /* Load TPM base address */
  movs  r7, #TPM_SC_CMOD(1)         /* Load mask */
  ldr   r5, [r6, #TPM_SC]           /* Load TPM_SC value */
  orrs  r5, r5, r7                  /* Select clock mode enabling TPM */
  str   r5, [r6, #TPM_SC]           /* Start PWM */

  bx    LR

  
/**
 * Stop driving LED with PWM.
 *
 * Registers modified: r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .thumb_func
  .type DriveLed, %function
  .global DriveLed
StopLed:
  ldr   r6, =TPM                    /* Load TPM base address */
  movs  r7, #TPM_SC_CMOD(1)         /* Load mask */
  ldr   r5, [r6, #TPM_SC]           /* Load TPM_SC value */
  bics  r5, r5, r7                  /* Disable TPM */
  str   r5, [r6, #TPM_SC]           /* Stop PWM */

  bx    LR


/**
 * Initialize Timer/PWM Module. TPM0 Channel 2 selected.
 * Duty cycle 50%, period ~1 ms.
 *
 * Registers modified: r2, r3, r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 * Todo       Figure out TPM_MOD register
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb
  .thumb_func
  .type TPM_Init, %function
  .global TPM_Init
TPM_Init:
  /* No need to save argument registers in init section */
  /* Enable PORTA clock gating */
  ldr   r4, =SIM + SIM_SCGC5        /* Load address */
  ldr   r5, =SIM_SCGC5_PORTE_MASK   /* Load mask value */
  ldr   r6, [r4]                    /* Read SIM_SCGC5 */
  movs  r7, #0                      /* Clear register */
  orrs  r6, r5                      /* SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK */
  adds  r7, r4, #0x04               /* SIM_SCGC6 = SIM_SCGC5 + offset 0x04, arithmetic is faster than memory access */
  str   r6, [r4]                    /* Write SIM_SCGC5 */

  /* Enable TPM clock gating */
  ldr   r5, =SIM_SCGC6_TPM_MASK     /* Load mask value */
  ldr   r6, [r7]                    /* r7: SIM_SCGC6 */
  ldr   r4, =PORTE                  /* Load PORTE base address */
  orrs  r6, r5                      /* SIM_SCGC6 |= SIM_SCGC6_TPM_MASK */

  /* Select pin multiplexer */
  ldr   r3, =PORT_PCR_MUX(3)        /* Select TPM0 CH2 */
  str   r6, [r7]                    /* Write SIM_SCGC6 */
  str   r3, [r4, #PORT_PCR          /* Write to PORTE PCR */ \
                + (0x04 * 29)]      /* Write to PTE29: 29 * 0x04 = 0x74 offset */

  /* Set clock source for TPM */
  ldr   r6, =TPM                    /* Load TPM base address */
  subs  r7, r7, #0x38               /* Decremement r7 to SIM_SOPT2 */
  ldr   r5, =SIM_SOPT2_TPMSRC(1) |  /* MCGFLLCLK as clock source */ \
            SIM_SOPT2_PLLFLLSEL_MASK/* MCGPLLCLK clock with fixed divide by tw */
  ldr   r4, =5000                   /* Load immediate value */
  str   r5,  [r7]                   /* Write SIM_SOPT2 */

  /* Load counter */
  ldr   r3, [r6]                    /* Read TPM_MOD value */
  orrs  r3, r3, r4                  /* TPM_MOD |= 5000 */
  str   r3, [r6, #TPM_MOD]          /* Write TPM_MOD */

  /* Set SC register */
  movs  r5, #(TPM_SC_CPWMS_MASK     /* Up-down counting mode */   \
            | TPM_SC_PS(1))         /* Prescale divide by 2 */
  str   r5, [r6, #TPM_SC]           /* Write TPM_SC */

  /* Set C2SC register */
  movs  r7, #(TPM_CnSC_MSB_MASK     /* Edge-aligned PWM: */       \
            | TPM_CnSC_ELSA_MASK)   /* Clear output on match, set output on reload */
  str   r7, [r6, #TPM_C2SC]         /* Write TPM_C2SC */

  /* Set TPM value */
  ldr   r2, =2500 - 1               /* Set initial duty cycle */ 
  str   r2, [r6, #TPM_C2V]          /* Write TPM_C0V */

  /* Continue in debug mode */
  movs  r3, #TPM_CONF_DBGMODE(3)
  adds  r6, r6, #TPM_CONF
  str   r3, [r6]                    /* Write TPM_CONF */

  bx    LR


  .end
