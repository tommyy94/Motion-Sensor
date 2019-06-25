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
  .equ SIM_SCGC5_PORTA_MASK,  0x0200u                     /* System Clock Gating Control 5 PORTA Mask */
  .equ SIM_SCGC5_PORTB_MASK,  0x0400u                     /* System Clock Gating Control 5 PORTB Mask */

/* Peripheral PORTA base address */
  .equ PORTA,                 0x40049000u
  .equ PORTB,                 0x4004A000u

/* Peripheral PCR bit fields */
  .equ PORTA_PCR,             PORTA + 0x00u               /* PORTA Pin Control Register Register */
  .equ PORTB_PCR,             PORTB + 0x00u               /* PORTB Pin Control Register Register */
  .equ PORT_PCR_MUX_MASK,     0x100u

/* Peripheral GPIOA base address */
  .equ GPIOA,                 0x400FF000u                 /* GPIOA Base Address */
  .equ GPIOB,                 0x400FF040u                 /* GPIOB Base Address */

  .equ GPIOA_PDOR,            GPIOA + 0x00u               /* Port Data Output Register */
  .equ GPIOA_PSOR,            GPIOA + 0x04u               /* Port Set Output Register */
  .equ GPIOA_PCOR,            GPIOA + 0x08u               /* Port Clear Output Register */
  .equ GPIOA_PTOR,            GPIOA + 0x0Cu               /* Port Toggle Output Register */
  .equ GPIOA_PDIR,            GPIOA + 0x10u               /* Port Data Input Register */
  .equ GPIOA_PDDR,            GPIOA + 0x14u               /* Port Data Direction Register */
  
  .equ GPIOB_PDOR,            GPIOB + 0x00u               /* Port Data Output Register */
  .equ GPIOB_PSOR,            GPIOB + 0x04u               /* Port Set Output Register */
  .equ GPIOB_PCOR,            GPIOB + 0x08u               /* Port Clear Output Register */
  .equ GPIOB_PTOR,            GPIOB + 0x0Cu               /* Port Toggle Output Register */
  .equ GPIOB_PDIR,            GPIOB + 0x10u               /* Port Data Input Register */
  .equ GPIOB_PDDR,            GPIOB + 0x14u               /* Port Data Direction Register */
