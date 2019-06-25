/* Core interrupts */
  .equ NonMaskableInt_IRQn,   -14             /* Non Maskable Interrupt */
  .equ HardFault_IRQn,        -13             /* Cortex-M0 SV Hard Fault Interrupt */
  .equ SVCall_IRQn,           -5              /* Cortex-M0 SV Call Interrupt */
  .equ PendSV_IRQn,           -2              /* Cortex-M0 Pend SV Interrupt */
  .equ SysTick_IRQn,          -1              /* Cortex-M0 System Tick Interrupt */

/* Device specific interrupts */
  .equ Reserved16_IRQn,       0               /* Reserved interrupt 16 */
  .equ Reserved17_IRQn,       1               /* Reserved interrupt 17 */
  .equ Reserved18_IRQn,       2               /* Reserved interrupt 18 */
  .equ Reserved19_IRQn,       3               /* Reserved interrupt 19 */
  .equ Reserved20_IRQn,       4               /* Reserved interrupt 20 */
  .equ FTFA_IRQn,             5               /* FTFA command complete/read collision interrupt */
  .equ LVD_LVW_IRQn,          6               /* Low Voltage Detect, Low Voltage Warning */
  .equ Reserved23_IRQn,       7               /* Reserved interrupt 23 */
  .equ I2C0_IRQn,             8               /* I2C0 interrupt */
  .equ I2C1_IRQn,             9               /* I2C1 interrupt */
  .equ SPI0_IRQn,             10              /* SPI0 interrupt */
  .equ Reserved27_IRQn,       11              /* Reserved interrupt 27 */
  .equ UART0_IRQn,            12              /* UART0 status/error interrupt */
  .equ Reserved29_IRQn,       13              /* Reserved interrupt 29 */
  .equ Reserved30_IRQn,       14              /* Reserved interrupt 30 */
  .equ ADC0_IRQn,             15              /* ADC0 interrupt */
  .equ CMP0_IRQn,             16              /* CMP0 interrupt */
  .equ TPM0_IRQn,             17              /* TPM0 fault, overflow and channels interrupt */
  .equ TPM1_IRQn,             18              /* TPM1 fault, overflow and channels interrupt */
  .equ Reserved35_IRQn,       19              /* Reserved interrupt 35 */
  .equ Reserved36_IRQn,       20              /* Reserved interrupt 36 */
  .equ Reserved37_IRQn,       21              /* Reserved interrupt 37 */
  .equ Reserved38_IRQn,       22              /* Reserved interrupt 38 */
  .equ Reserved39_IRQn,       23              /* Reserved interrupt 39 */
  .equ Reserved40_IRQn,       24              /* Reserved interrupt 40 */
  .equ Reserved41_IRQn,       25              /* Reserved interrupt 41 */
  .equ Reserved42_IRQn,       26              /* Reserved interrupt 42 */
  .equ MCG_IRQn,              27              /* MCG interrupt */
  .equ LPTimer_IRQn,          28              /* LPTimer interrupt */
  .equ Reserved45_IRQn,       29              /* Reserved interrupt 45 */
  .equ PORTA_IRQn,            30              /* Port A interrupt */
  .equ PORTB_IRQn,            31              /* Port B interrupt */

/* Cortex M0+ has 2 priority bits => 2^2 = 4 priority levels */
  .equ NVIC_IPRn_LEVEL0,      0x00
  .equ NVIC_IPRn_LEVEL1,      0x40
  .equ NVIC_IPRn_LEVEL2,      0x80
  .equ NVIC_IPRn_LEVEL3,      0xC0

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
