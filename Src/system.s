#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb

  .text


/**
 * Initialize Low Power features.
 *
 * Registers modified: r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type LP_Init, %function
  .global LP_Init
LP_Init:
  ldr   r4, =SCB                        /* Load SCB base address */
  ldr   r5, =(SCB_SCR_SLEEPDEEP_Msk     /* Enable deep sleep */ \
            | SCB_SCR_SLEEPONEXIT_Msk)  /* Enable interrupt driven system */
  ldr   r6, [r4, #SCB_SCR]              /* Load SCB_SCR value */
  ldr   r7, =SIM + SIM_CLKDIV1          /* Load base address and offset */
  orrs  r5, r6, r5                      /* SCB_SCR |= SCB_SCR_SLEEPDEEP_Msk */
  ldr   r6, =(SIM_CLKDIV1_OUTDIV1(3)    /* Clock 1 Output prescaler 4 */  \
            | SIM_CLKDIV1_OUTDIV4(3))   /* Clock 4 Output prescaler 4 */
  str   r5, [r4, #SCB_SCR]              /* Write SCB_SCR */
  str   r6, [r7]                        /* Write SIM_CLKDIV1 */

  ldr   r5, =SIM_FCFG1_FLASHDOZE_MASK   /* Disable flash on sleep */
  adds  r7, #0x08                       /* Increment address to SIM_FCFG1 */
  str   r5, [r7]                        /* Write SIM_FCFG1 */

  ldr   r4, =MCG                        /* Load MCG base address */
  ldrb  r5, [r4, #MCG_C2]               /* Read MCG_C2 value */
  movs  r6, #MCG_C2_LP_MASK             /* Select Low Power */
  ldr   r7, =~MCG_C2_HGO0_MASK          /* Configure crystal oscillator for lower power */
  orrs  r5, r5, r6                      /* MCG_C2 |= MCG_C2_LP_MASK */
  ands  r5, r5, r7                      /* MCG_C2 &= ~MCG_C2_HGO0_MASK */
  strb  r5, [r4, #MCG_C2]               /* Write MCG_C2 */

  ldrb  r5, [r4, #MCG_C1]               /* Read MCG_C1 value */
  ldr   r6, =~MCG_C1_IRCLKEN_MASK       /* Disable internal reference clock (using external crystal) */
  ands  r5, r5, r6                      /* MCG_C1 &= ~MCG_C1_IRCLKEN_MASK */
  strb  r5, [r4, #MCG_C1]               /* Write MCG_C1 */

  /* Configure PMC registers */
  ldr   r4, =SMC                        /* Load SMC base address */
  movs  r5, #SMC_PMPROT_AVLP_MASK       /* Enable Very Low Power Modes */
  ldrb  r6, [r4, #SMC_PMPROT]           /* Read SMC_PMPROT value */
  orrs  r6, r6, r5                      /* SMC_PMPROT |= SMC_PMPROT_AVLP_MASK */
  str   r6, [r4, #SMC_PMPROT]           /* Write SMC_PMPROT */

  movs  r5, #(SMC_PMCTRL_RUNM(2)        /* Enable VLPR */ \
            | SMC_PMCTRL_STOPM(2))      /* Enable VLPS */
  ldrb  r6, [r4, #SMC_PMCTRL]           /* Read SMC_PMCTRL value */
  orrs  r6, r6, r5                      /* SMC_PMCTRL |= SMC_PMCTRL_RUNM(2) | SMC_PMCTRL_STOPM(2) */
  strb  r6, [r4, #SMC_PMCTRL]           /* Write SMC_PMCTRL */

  /* Wait until VLPR is set */
  movs  r6, #0x7F                       /* PMSTAT is 7-bits wide */
  movs  r7, #SMC_PMSTAT_PMSTAT(4)       /* Current mode VLPR */           
WaitVLPR:
  ldrb  r5, [r4, #SMC_PMSTAT]           /* Read SMC_PMSTAT value */
  ands  r5, r5, r6                      /* Mask low 7-bits */
  tst   r5, r7                          /* Test VLPR bit */
  beq   WaitVLPR                        /* SMC_PMSTAT != VLPR */

  bx    lr

  
/**
 * Initialize sleep mode. Enable deep sleep
 * and use sleep-on-exit mode as the application
 * is interrupt driven.
 *
 * Registers modified: r4, r5, r6, r7
 *
 * Argument:  None
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type Sleep_Init, %function
  .global Sleep_Init
Sleep_Init:
  ldr   r3, =SCB
  movs  r4, #(SCB_SCR_SLEEPONEXIT_Msk \
            | SCB_SCR_SLEEPDEEP_Msk)
  str   r4, [r3, #SCB_SCR]

  ldr   r3, =SMC
  movs  r4, #SMC_PMCTRL_STOPM(3)        /* Enable Low-Leakage Stop Mode */
  strb  r4, [r3, #SMC_PMCTRL]

  ldr   r3, =SMC
  ldr   r3, [r3]

  ldr   r3, =LLWU
  movs  r4, #LLWU_ME_WUME5(1)           /* Wakeup source on module 5 */
  strb  r4, [r3, #LLWU_ME]

  bx    lr


  .end
