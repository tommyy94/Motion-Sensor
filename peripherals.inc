/* NVIC base address */
  .equ SCS,       0xE000E000u                 /* System Control Space Base Address */
  .equ SysTICK,   SCS + 0x0010u
  .equ NVIC,      SCS + 0x0100u
  .equ SCB,       SCS + 0XD000u

  .equ NVIC_ISER, 0x000u                      /* Interrupt Set Enable Register */
  .equ NVIC_ICER, 0x080u                      /* Interrupt Clear Enable Register */
  .equ NVIC_ISPR, 0x100u                      /* Interrupt Set Pending Register */
  .equ NVIC_ICPR, 0x180u                      /* Interrupt Clear Pending Register */
  .equ NVIC_IP,   0x300U                      /* Interrupt Priority Register */

/* Peripheral SIM base address */
  .equ SIM,       0x40047000u
  .equ SIM_COPC,  0x1100u
