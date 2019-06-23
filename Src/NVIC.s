  .include "Inc/peripherals.inc"
  .include "Inc/core.inc"

  .syntax unified
  .thumb


  .text


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
  ldr   r4, =NVIC_ISER            /* Load Interrupt Set Enable Register*/
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
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
  ldr   r4, =NVIC_ICER            /* Load Interrupt Clear Enable Register */
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
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
  ldr   r4, =NVIC_ICPR            /* Load Load Interrupt Clear Pending Register */
  movs  r5, #1                    /* NVIC_IRQn needs to be shifted */
  lsls  r5, r5, r0                /* 1 << NVIC_IRQn */
  str   r5, [r4]                  /* Write to disable interrupt */
  pop   {r4-r5, PC}               /* Epilogue and return */


/**
 * Set interrupt priority in NVIC. Lower equals higher priority.
 *
 * Registers modified: r1, r4, r5, r6, r7
 *
 * Argument:  r0 - Interrupt vector
 * Argument:  r1 - Interrupt priority
 * Return:    None
 *
 * TODO: Figure out the magic offset
 */
  .eabi_attribute Tag_ABI_align_preserved, 1
  .thumb_func
  .type NVIC_SetPriority, %function
  .global NVIC_SetPriority
NVIC_SetPriority:
  push  {r4-r7, LR}               /* Prologue */


  /* Store NVIC_IPRn register in r4 */
  ldr   r4, =NVIC_IP              /* Load NVIC Interrupt Priority to register */
  adds  r4, r4, r0                /* Add IRQn offset */
  subs  r4, r4, #2                /* Subtract magic offset */

  /* Store NVIC_IPRn byte position in r5 */
  ldr   r5, =NVIC_LookupTable     /* Load lookup table address */
  ldrb  r5, [r5, r0]              /* Read byte indexed by IRQn from lookup table */

  /* NVIC_IPRn |= new priority */   
  ldr   r6, [r4]                  /* Load NVIC Interrupt Priority to register */
  movs  r7, #0xFF                 /* Byte mask */
  lsls  r7, r7, r5                /* Shift mask to interrupts position */
  bics  r6, r6, r7                /* Clear previous value */
  lsls  r1, r1, r5                /* Shift new value to interrupts position */
  orrs  r6, r6, r1                /* New priority level */
  str   r6, [r4]                  /* Write back new value */

  pop   {r4-r7, PC}               /* Epilogue and return */


  .end
