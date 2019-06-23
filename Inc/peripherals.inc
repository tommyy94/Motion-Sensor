/* SCS base address */
  .equ SCS,                   0xE000E000u                 /* System Control Space Base Address */
  .equ SysTICK,               SCS + 0x0010u               /* SysTICK Timer */
  .equ NVIC,                  SCS + 0x0100u               /* Nested Vectored Interrupt Controller */
  .equ SCB,                   SCS + 0XD000u               /* System Control Block */

  .equ NVIC_ISER,             NVIC + 0x000u               /* Interrupt Set Enable Register */
  .equ NVIC_ICER,             NVIC + 0x080u               /* Interrupt Clear Enable Register */
  .equ NVIC_ISPR,             NVIC + 0x100u               /* Interrupt Set Pending Register */
  .equ NVIC_ICPR,             NVIC + 0x180u               /* Interrupt Clear Pending Register */
  .equ NVIC_IP,               NVIC + 0x300U               /* Interrupt Priority Register */

/* Peripheral SIM base address */
  .equ SIM,                   0x40047000u                 /* System Integration Module Base Address */
  .equ SIM_COPC,              SIM + 0x1100u               /* Computer Operating Properly Register */
  .equ SIM_SCGC5,             SIM + 0x1038u               /* System Clock Gating Control 5 Register */

  .equ SIM_SCGC5_PORTA_MASK,  0x0100u                     /* System Clock Gating Control 5 PORTA Mask */
