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
#define PORT_PCR_MUX(x)       ((((x)<<PORT_PCR_MUX_SHIFT))&PORT_PCR_MUX_MASK)
#define PORT_PCR_IRQC_MASK    (0xF0000u)
#define PORT_PCR_IRQC_SHIFT   (16)
#define PORT_PCR_IRQC(x)      ((((x)<<PORT_PCR_IRQC_SHIFT))&PORT_PCR_IRQC_MASK)
#define PORT_PCR_ISF_MASK     (0x1000000u)
#define PORT_PCR_ISF_SHIFT    (24)

/* Peripheral ISFR bit fields */
#define PORTA_ISFR            (PORTA + 0xA0)
#define PORTB_ISFR            (PORTB + 0xA0)
#define PORT_ISFR_ISF_MASK    (0xFFFFFFFFu)
#define PORT_ISFR_ISF_SHIFT   (0)
#define PORT_ISFR_ISF(x)      ((((x)<<PORT_ISFR_ISF_SHIFT))&PORT_ISFR_ISF_MASK)

/* Peripheral FPTA base address */
#define FPTA                  (0xF80FF000u)                  /* FPTA Base Address */
#define FTPB                  (0xF80FF040u)                  /* FPTB Base Address */

#define FPTA_PDOR             (FPTA + 0x00u)                 /* Port Data Output Register */
#define FPTA_PSOR             (FPTA + 0x04u)                 /* Port Set Output Register */
#define FPTA_PCOR             (FPTA + 0x08u)                 /* Port Clear Output Register */
#define FPTA_PTOR             (FPTA + 0x0Cu)                 /* Port Toggle Output Register */
#define FPTA_PDIR             (FPTA + 0x10u)                 /* Port Data Input Register */
#define FPTA_PDDR             (FPTA + 0x14u)                 /* Port Data Direction Register */
  
#define FPTB_PDOR             (FPTB + 0x00u)                 /* Port Data Output Register */
#define FPTB_PSOR             (FPTB + 0x04u)                 /* Port Set Output Register */
#define FPTB_PCOR             (FPTB + 0x08u)                 /* Port Clear Output Register */
#define FPTB_PTOR             (FPTB + 0x0Cu)                 /* Port Toggle Output Register */
#define FPTB_PDIR             (FPTB + 0x10u)                 /* Port Data Input Register */
#define FPTB_PDDR             (FPTB + 0x14u)                 /* Port Data Direction Register */
