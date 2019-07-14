#include "core.h"
#include "peripherals.h"

  .syntax unified
  .thumb


  .text


  .align 4
/* Lookup table for NVIC_IPRn offset, IRQn as indexed memory access */
NVIC_LookupTable:
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24
  .byte 0, 8, 16, 24


  .align 4
/* Lookup table for doubleword alignment */
DWAlignmentTable:
  .byte  0,  0,  0,  0
  .byte  4,  4,  4,  4
  .byte  8,  8,  8,  8
  .byte 12, 12, 12, 12
  .byte 16, 16, 16, 16
  .byte 20, 20, 20, 20
  .byte 24, 24, 24, 24
  .byte 28, 28, 28, 28


/**
 * Enable interrupt vector in NVIC.
 *
 * Registers modified: r4, r5
 *
 * Argument:  r0 - Interrupt vector
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1 /* Preserve 8 byte stack alignment */
  .thumb_func
  .type NVIC_EnableIRQ, %function
  .global NVIC_EnableIRQ
NVIC_EnableIRQ:
  push  {r4-r5, LR}               /* Prologue */
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
  ldr   r4, =NVIC_ISER            /* Load Interrupt Set Enable Register*/
  lsls  r5, r5, r0                /* 1 << NVIC_IRQn */
  str   r5, [r4]                  /* Write to enable interrupt */
  pop   {r4-r5, PC}               /* Epilogue and return */


/**
 * Disable interrupt vector in NVIC.
 *
 * Registers modified: r4, r5
 *
 * Argument:  r0 - Interrupt vector
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type NVIC_DisableIRQ, %function
  .global NVIC_DisableIRQ
NVIC_DisableIRQ:
  push  {r4-r5, LR}               /* Prologue */
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
  ldr   r4, =NVIC_ICER            /* Load Interrupt Clear Enable Register */
  lsls  r5, r5, r0                /* 1 << NVIC_IRQn */
  str   r5, [r4]                  /* Write to disable interrupt */
  pop   {r4-r5, PC}               /* Epilogue and return */


/**
 * Clear pending interrupt request in NVIC.
 *
 * Registers modified: r4, r5
 *
 * Argument:  r0 - Interrupt vector
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type NVIC_ClearPendingIRQ, %function
  .global NVIC_ClearPendingIRQ
NVIC_ClearPendingIRQ:
  push  {r4-r5, LR}               /* Prologue */
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
  ldr   r4, =NVIC_ICPR            /* Load Load Interrupt Clear Pending Register */
  lsls  r5, r5, r0                /* 1 << NVIC_IRQn */
  str   r5, [r4]                  /* Write to disable interrupt */
  pop   {r4-r5, PC}               /* Epilogue and return */


/**
 * Set interrupt priority in NVIC. Lower equals higher priority.
 *
 * Registers modified: r2, r3, r4, r5, r6, r7
 *
 * Argument:  r0 - Interrupt vector
 * Argument:  r1 - Interrupt priority
 * Return:    None
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type NVIC_SetPriority, %function
  .global NVIC_SetPriority
NVIC_SetPriority:
  push  {r2-r7, LR}               /* Prologue */

  /**
   * r4: NVIC_IPRn register
   * r5: NVIC_IPRn byte position
   */
  ldr   r2, =NVIC_LookupTable     /* Load offset lookup table address */
  ldr   r5, =DWAlignmentTable     /* Load alignment lookup table address */
  ldr   r4, =NVIC_IP              /* Load NVIC Interrupt Priority address */
  ldrb  r5, [r5, r0]              /* Load interrupt priority to register */
  movs  r7, #0xFF                 /* Load byte mask for later use */
  adds  r4, r5                    /* Add IRQn offset */

  ldrb  r2, [r2, r0]              /* Read byte indexed by IRQn from lookup table */
  ldr   r6, [r4]                  /* Load NVIC Interrupt Priority to register */

  lsls  r7, r7, r2                /* Shift mask to interrupts position */
  lsls  r1, r1, r2                /* Shift new value to interrupts position */
  bics  r6, r6, r7                /* Clear previous value */
  orrs  r6, r6, r1                /* New priority level */
  str   r6, [r4]                  /* Write back new value */

  pop   {r2-r7, PC}               /* Epilogue and return */


  .end
