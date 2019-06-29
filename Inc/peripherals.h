/* SCS base address */
#define SCS                   (0xE000E000u)                 /* System Control Space Base Address */
#define SysTICK               (SCS + 0x0010u               /* SysTICK Timer */
#define NVIC                  (SCS + 0x0100u)               /* Nested Vectored Interrupt Controller */
#define SCB                   (SCS + 0XD000u)               /* System Control Block */

#define NVIC_ISER             (NVIC + 0x000u)               /* Interrupt Set Enable Register */
#define NVIC_ICER             (NVIC + 0x080u)               /* Interrupt Clear Enable Register */
#define NVIC_ISPR             (NVIC + 0x100u)               /* Interrupt Set Pending Register */
#define NVIC_ICPR             (NVIC + 0x180u)               /* Interrupt Clear Pending Register */
#define NVIC_IP               (NVIC + 0x300U)               /* Interrupt Priority Register */

/* Peripheral SIM base address */
#define SIM                   (0x40047000u)                 /* System Integration Module Base Address */
#define SIM_COPC              (SIM + 0x1100u)               /* Computer Operating Properly Register */
#define SIM_SCGC5             (SIM + 0x1038u)               /* System Clock Gating Control 5 Register */
#define SIM_SCGC5_PORTA_MASK  (0x0200u)                     /* System Clock Gating Control 5 PORTA Mask */
#define SIM_SCGC5_PORTB_MASK  (0x0400u)                     /* System Clock Gating Control 5 PORTB Mask */

/* Peripheral PORTA base address */
#define PORTA                 (0x40049000u)
#define PORTB                 (0x4004A000u)

/* Peripheral PCR bit fields */
#define PORTA_PCR             (PORTA + 0x00u)               /* PORTA Pin Control Register Register */
#define PORTB_PCR             (PORTB + 0x00u)               /* PORTB Pin Control Register Register */
#define PORT_PCR_PS_MASK      (0x1u)
#define PORT_PCR_PS_SHIFT     (0)
#define PORT_PCR_PE_MASK      (0x2u)
#define PORT_PCR_PE_SHIFT     (1)
#define PORT_PCR_SRE_MASK     (0x4u)
#define PORT_PCR_SRE_SHIFT    (2)
#define PORT_PCR_PFE_MASK     (0x10u)
#define PORT_PCR_PFE_SHIFT    (4)
#define PORT_PCR_DSE_MASK     (0x40u)
#define PORT_PCR_DSE_SHIFT    (6)
#define PORT_PCR_MUX_MASK     (0x700u)
#define PORT_PCR_MUX_SHIFT    (8)
#define PORT_PCR_MUX(x)       (((((x))<<PORT_PCR_MUX_SHIFT))&PORT_PCR_MUX_MASK)
#define PORT_PCR_IRQC_MASK    (0xF0000u)
#define PORT_PCR_IRQC_SHIFT   (16)
#define PORT_PCR_IRQC(x)      (((((x))<<PORT_PCR_IRQC_SHIFT))&PORT_PCR_IRQC_MASK)
#define PORT_PCR_ISF_MASK     (0x1000000u)
#define PORT_PCR_ISF_SHIFT    (24)

/* Peripheral ISFR bit fields */
#define PORTA_ISFR            (PORTA + 0xA0)
#define PORTB_ISFR            (PORTB + 0xA0)
#define PORT_ISFR_ISF_MASK    (0xFFFFFFFFu)
#define PORT_ISFR_ISF_SHIFT   (0)
#define PORT_ISFR_ISF(x)      (((((x))<<PORT_ISFR_ISF_SHIFT))&PORT_ISFR_ISF_MASK)

/* Peripheral GPIOA base address */
#define GPIOA                 (0x400FF000u)                 /* GPIOA Base Address */
#define GPIOB                 (0x400FF040u)                 /* GPIOB Base Address */

#define GPIOA_PDOR            (GPIOA + 0x00u)               /* Port Data Output Register */
#define GPIOA_PSOR            (GPIOA + 0x04u)               /* Port Set Output Register */
#define GPIOA_PCOR            (GPIOA + 0x08u)               /* Port Clear Output Register */
#define GPIOA_PTOR            (GPIOA + 0x0Cu)               /* Port Toggle Output Register */
#define GPIOA_PDIR            (GPIOA + 0x10u)               /* Port Data Input Register */
#define GPIOA_PDDR            (GPIOA + 0x14u)               /* Port Data Direction Register */
  
#define GPIOB_PDOR            (GPIOB + 0x00u)               /* Port Data Output Register */
#define GPIOB_PSOR            (GPIOB + 0x04u               /* Port Set Output Register */
#define GPIOB_PCOR            (GPIOB + 0x08u)               /* Port Clear Output Register */
#define GPIOB_PTOR            (GPIOB + 0x0Cu)               /* Port Toggle Output Register */
#define GPIOB_PDIR            (GPIOB + 0x10u)               /* Port Data Input Register */
#define GPIOB_PDDR            (GPIOB + 0x14u)               /* Port Data Direction Register */
