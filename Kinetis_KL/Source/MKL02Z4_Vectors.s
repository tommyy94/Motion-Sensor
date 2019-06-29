/*****************************************************************************
 *                   SEGGER Microcontroller GmbH & Co. KG                    *
 *            Solutions for real time microcontroller applications           *
 *****************************************************************************
 *                                                                           *
 *               (c) 2017 SEGGER Microcontroller GmbH & Co. KG               *
 *                                                                           *
 *           Internet: www.segger.com   Support: support@segger.com          *
 *                                                                           *
 *****************************************************************************/

/*****************************************************************************
 *                         Preprocessor Definitions                          *
 *                         ------------------------                          *
 * VECTORS_IN_RAM                                                            *
 *                                                                           *
 *   If defined, an area of RAM will large enough to store the vector table  *
 *   will be reserved.                                                       *
 *                                                                           *
 *****************************************************************************/

  .syntax unified
  .code 16

  .section .init, "ax"
  .align 0

/*****************************************************************************
 * Default Exception Handlers                                                *
 *****************************************************************************/

  .thumb_func
  .weak NMI_Handler
NMI_Handler:
  b .

  .thumb_func
  .weak HardFault_Handler
HardFault_Handler:
  b .

  .thumb_func
  .weak SVC_Handler
SVC_Handler:
  b .

  .thumb_func
  .weak PendSV_Handler
PendSV_Handler:
  b .

  .thumb_func
  .weak SysTick_Handler
SysTick_Handler:
  b .

  .thumb_func
Dummy_Handler:
  b .

#if defined(__OPTIMIZATION_SMALL)

  .weak FTFA_IRQHandler
  .thumb_set FTFA_IRQHandler,Dummy_Handler

  .weak LVD_LVW_IRQHandler
  .thumb_set LVD_LVW_IRQHandler,Dummy_Handler

  .weak I2C0_IRQHandler
  .thumb_set I2C0_IRQHandler,Dummy_Handler

  .weak I2C1_IRQHandler
  .thumb_set I2C1_IRQHandler,Dummy_Handler

  .weak SPI0_IRQHandler
  .thumb_set SPI0_IRQHandler,Dummy_Handler

  .weak UART0_IRQHandler
  .thumb_set UART0_IRQHandler,Dummy_Handler

  .weak ADC0_IRQHandler
  .thumb_set ADC0_IRQHandler,Dummy_Handler

  .weak CMP0_IRQHandler
  .thumb_set CMP0_IRQHandler,Dummy_Handler

  .weak TPM0_IRQHandler
  .thumb_set TPM0_IRQHandler,Dummy_Handler

  .weak TPM1_IRQHandler
  .thumb_set TPM1_IRQHandler,Dummy_Handler

  .weak LPTimer_IRQHandler
  .thumb_set LPTimer_IRQHandler,Dummy_Handler

  .weak PORTA_IRQHandler
  .thumb_set PORTA_IRQHandler,Dummy_Handler

  .weak PORTB_IRQHandler
  .thumb_set PORTB_IRQHandler,Dummy_Handler

#else

  .thumb_func
  .weak FTFA_IRQHandler
FTFA_IRQHandler:
  b .

  .thumb_func
  .weak LVD_LVW_IRQHandler
LVD_LVW_IRQHandler:
  b .

  .thumb_func
  .weak I2C0_IRQHandler
I2C0_IRQHandler:
  b .

  .thumb_func
  .weak I2C1_IRQHandler
I2C1_IRQHandler:
  b .

  .thumb_func
  .weak SPI0_IRQHandler
SPI0_IRQHandler:
  b .

  .thumb_func
  .weak UART0_IRQHandler
UART0_IRQHandler:
  b .

  .thumb_func
  .weak ADC0_IRQHandler
ADC0_IRQHandler:
  b .

  .thumb_func
  .weak CMP0_IRQHandler
CMP0_IRQHandler:
  b .

  .thumb_func
  .weak TPM0_IRQHandler
TPM0_IRQHandler:
  b .

  .thumb_func
  .weak TPM1_IRQHandler
TPM1_IRQHandler:
  b .

  .thumb_func
  .weak LPTimer_IRQHandler
LPTimer_IRQHandler:
  b .

  .thumb_func
  .weak PORTA_IRQHandler
PORTA_IRQHandler:
  b .

  .thumb_func
  .weak PORTB_IRQHandler
PORTB_IRQHandler:
  b .

#endif

/*****************************************************************************
 * Vector Table                                                              *
 *****************************************************************************/

  .section .vectors, "ax"
  .align 0
  .global _vectors
  .extern __stack_end__
  .extern Reset_Handler

_vectors:
  .word __stack_end__
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word SVC_Handler
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word PendSV_Handler
  .word SysTick_Handler
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word FTFA_IRQHandler
  .word LVD_LVW_IRQHandler
  .word Dummy_Handler /* Reserved */
  .word I2C0_IRQHandler
  .word I2C1_IRQHandler
  .word SPI0_IRQHandler
  .word Dummy_Handler /* Reserved */
  .word UART0_IRQHandler
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word ADC0_IRQHandler
  .word CMP0_IRQHandler
  .word TPM0_IRQHandler
  .word TPM1_IRQHandler
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word Dummy_Handler /* Reserved */
  .word LPTimer_IRQHandler
  .word Dummy_Handler /* Reserved */
  .word PORTA_IRQHandler
  .word PORTB_IRQHandler
_vectors_end:

#if 1
  .section .vectors, "ax"
  // fill to 0x400 for the flash configuration field
  //.fill 0x400-(_vectors_end-_vectors), 1, 0xff
  .org 0x400, 0xFF
BackDoorKey:
  .byte 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
#if defined(E_SERIES)
RESERVED:
  .byte 0xff, 0xff, 0xff, 0xff
EEPROT:
  .byte 0xff
FPROT:
  .byte 0xff
FSEC:
  .byte 0xfe
FOPT:
  .byte 0xff
#else
FPROT:
  .byte 0xff, 0xff, 0xff, 0xff
FSEC:
  .byte 0xfe
FOPT:
#if defined(MKL03Z4) || defined(MKL17Z4) || defined(MKL17Z644) || defined(MKL27Z4)  || defined(MKL27Z644) || defined(MKL33Z4) || defined(MKL33Z644) || defined(MKL43Z4)
  .byte 0x3b
#else 
  .byte 0xff
#endif
FEPROT:
  .byte 0xff
FDPROT:
  .byte 0xff
#endif
#endif

#ifdef VECTORS_IN_RAM
  .section .vectors_ram, "ax"
  .align 0
  .global _vectors_ram

_vectors_ram:
  .space _vectors_end - _vectors, 0
#endif
