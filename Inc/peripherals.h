/* SCS base address */
#define SCS                           (0xE000E000u)                 /* System Control Space Base Address */
#define SysTICK                       (SCS + 0x0010u                /* SysTICK Timer */
#define NVIC                          (SCS + 0x0100u)               /* Nested Vectored Interrupt Controller */
#define SCB                           (SCS + 0XD000u)               /* System Control Block */

#define NVIC_ISER                     (NVIC + 0x000u)               /* Interrupt Set Enable Register */
#define NVIC_ICER                     (NVIC + 0x080u)               /* Interrupt Clear Enable Register */
#define NVIC_ISPR                     (NVIC + 0x100u)               /* Interrupt Set Pending Register */
#define NVIC_ICPR                     (NVIC + 0x180u)               /* Interrupt Clear Pending Register */
#define NVIC_IP                       (NVIC + 0x300U)               /* Interrupt Priority Register */

/* Peripheral SIM base address */
#define SIM                           (0x40047000u)                 /* System Integration Module Base Address */
#define SIM_COPC                      (SIM + 0x1100u)               /* Computer Operating Properly Register */
#define SIM_SOPT2                     (SIM + 0x1004u)               /* System Options 2 Register */
#define SIM_SCGC5                     (SIM + 0x1038u)               /* System Clock Gating Control 5 Register */
#define SIM_SCGC6                     (SIM + 0x103Cu)               /* System Clock Gating Control 6 Register */

/* Peripheral SIM Register Masks */
#define SIM_SCGC5_PORTA_MASK          (0x0200u)                     /* System Clock Gating Control 5 PORTA Mask */
#define SIM_SCGC5_PORTB_MASK          (0x0400u)                     /* System Clock Gating Control 5 PORTB Mask */
#define SIM_SCGC6_TPM_MASK            (0x1000000u)                  /* System Clock Gating Control 6 TPM Mask */

#define SIM_SOPT2_TPMSRC_MASK         (0x3000000u)
#define SIM_SOPT2_TPMSRC_SHIFT        (24)
#define SIM_SOPT2_TPMSRC(x)           ((((x)<<SIM_SOPT2_TPMSRC_SHIFT))&SIM_SOPT2_TPMSRC_MASK)
#define SIM_SOPT2_UART0SRC_MASK       (0xC000000u)
#define SIM_SOPT2_UART0SRC_SHIFT      (26)
#define SIM_SOPT2_UART0SRC(x)         ((((x)<<SIM_SOPT2_UART0SRC_SHIFT))&SIM_SOPT2_UART0SRC_MASK)

/* Peripheral PORTA base address */
#define PORTA                         (0x40049000u)
#define PORTB                         (0x4004A000u)

#define PORTA_PCR                     (PORTA + 0x00u)               /* PORTA Pin Control Register Register */
#define PORTB_PCR                     (PORTB + 0x00u)               /* PORTB Pin Control Register Register */

/* Peripheral PCR Register Masks */
#define PORT_PCR_PS_MASK              (0x1u)
#define PORT_PCR_PS_SHIFT             (0)
#define PORT_PCR_PE_MASK              (0x2u)
#define PORT_PCR_PE_SHIFT             (1)
#define PORT_PCR_SRE_MASK             (0x4u)
#define PORT_PCR_SRE_SHIFT            (2)
#define PORT_PCR_PFE_MASK             (0x10u)
#define PORT_PCR_PFE_SHIFT            (4)
#define PORT_PCR_DSE_MASK             (0x40u)
#define PORT_PCR_DSE_SHIFT            (6)
#define PORT_PCR_MUX_MASK             (0x700u)
#define PORT_PCR_MUX_SHIFT            (8)
#define PORT_PCR_MUX(x)               ((((x)<<PORT_PCR_MUX_SHIFT))&PORT_PCR_MUX_MASK)
#define PORT_PCR_IRQC_MASK            (0xF0000u)
#define PORT_PCR_IRQC_SHIFT           (16)
#define PORT_PCR_IRQC(x)              ((((x)<<PORT_PCR_IRQC_SHIFT))&PORT_PCR_IRQC_MASK)
#define PORT_PCR_ISF_MASK             (0x1000000u)
#define PORT_PCR_ISF_SHIFT            (24)

/* Peripheral ISFR Register Masks */
#define PORTA_ISFR                    (PORTA + 0xA0)
#define PORTB_ISFR                    (PORTB + 0xA0)
#define PORT_ISFR_ISF_MASK            (0xFFFFFFFFu)
#define PORT_ISFR_ISF_SHIFT           (0)
#define PORT_ISFR_ISF(x)              ((((x)<<PORT_ISFR_ISF_SHIFT))&PORT_ISFR_ISF_MASK)

/* Peripheral FPTA base address */
#define FPTA                          (0xF80FF000u)                 /* FPTA Base Address */
#define FTPB                          (0xF80FF040u)                 /* FPTB Base Address */

#define FPTA_PDOR                     (FPTA + 0x00u)                /* Port Data Output Register */
#define FPTA_PSOR                     (FPTA + 0x04u)                /* Port Set Output Register */
#define FPTA_PCOR                     (FPTA + 0x08u)                /* Port Clear Output Register */
#define FPTA_PTOR                     (FPTA + 0x0Cu)                /* Port Toggle Output Register */
#define FPTA_PDIR                     (FPTA + 0x10u)                /* Port Data Input Register */
#define FPTA_PDDR                     (FPTA + 0x14u)                /* Port Data Direction Register */
  
#define FPTB_PDOR                     (FPTB + 0x00u)                /* Port Data Output Register */
#define FPTB_PSOR                     (FPTB + 0x04u)                /* Port Set Output Register */
#define FPTB_PCOR                     (FPTB + 0x08u)                /* Port Clear Output Register */
#define FPTB_PTOR                     (FPTB + 0x0Cu)                /* Port Toggle Output Register */
#define FPTB_PDIR                     (FPTB + 0x10u)                /* Port Data Input Register */
#define FPTB_PDDR                     (FPTB + 0x14u)                /* Port Data Direction Register */

/* Peripheral TPM base address */
#define TPM                           (0x40038000u)                 /* TPM Base Address */
#define TPM_SC                        (TPM + 0x00u)                 /* Status and Control */
#define TPM_CNT                       (TPM + 0x04u)                 /* Counter */
#define TPM_MOD                       (TPM + 0x08u)                 /* Modulo */
#define TPM_C0SC                      (TPM + 0x0Cu + 0x00u)         /* Channel 0 Status and Control */
#define TPM_C1SC                      (TPM + 0x0Cu + 0x08u)         /* Channel 1 Status and Control */
#define TPM_C0V                       (TPM + 0x10u + 0x00u)         /* Channel 0 Value */
#define TPM_C1V                       (TPM + 0x10u + 0x08u)         /* Channel 1 Value */

/* Peripheral TPM Register Masks */
#define TPM_SC_PS_MASK                (0x7u)
#define TPM_SC_PS_SHIFT               (0)
#define TPM_SC_PS(x)                  ((((x)<<TPM_SC_PS_SHIFT))&TPM_SC_PS_MASK)
#define TPM_SC_CMOD_MASK              (0x18u)
#define TPM_SC_CMOD_SHIFT             (3)
#define TPM_SC_CMOD(x)                ((((x)<<TPM_SC_CMOD_SHIFT))&TPM_SC_CMOD_MASK)
#define TPM_SC_CPWMS_MASK             (0x20u)
#define TPM_SC_CPWMS_SHIFT            (5)
#define TPM_SC_TOIE_MASK              (0x40u)
#define TPM_SC_TOIE_SHIFT             (6)
#define TPM_SC_TOF_MASK               (0x80u)
#define TPM_SC_TOF_SHIFT              (7)
#define TPM_SC_DMA_MASK               (0x100u)
#define TPM_SC_DMA_SHIFT              (8)
#define TPM_CNT_COUNT_MASK            (0xFFFFu)
#define TPM_CNT_COUNT_SHIFT           (0)
#define TPM_CNT_COUNT(x)              ((((x)<<TPM_CNT_COUNT_SHIFT))&TPM_CNT_COUNT_MASK)
#define TPM_MOD_MOD_MASK              (0xFFFFu)
#define TPM_MOD_MOD_SHIFT             (0)
#define TPM_MOD_MOD(x)                ((((x)<<TPM_MOD_MOD_SHIFT))&TPM_MOD_MOD_MASK)
#define TPM_CnSC_DMA_MASK             (0x1u)
#define TPM_CnSC_DMA_SHIFT            (0)
#define TPM_CnSC_ELSA_MASK            (0x4u)
#define TPM_CnSC_ELSA_SHIFT           (2)
#define TPM_CnSC_ELSB_MASK            (0x8u)
#define TPM_CnSC_ELSB_SHIFT           (3)
#define TPM_CnSC_MSA_MASK             (0x10u)
#define TPM_CnSC_MSA_SHIFT            (4)
#define TPM_CnSC_MSB_MASK             (0x20u)
#define TPM_CnSC_MSB_SHIFT            (5)
#define TPM_CnSC_CHIE_MASK            (0x40u)
#define TPM_CnSC_CHIE_SHIFT           (6)
#define TPM_CnSC_CHF_MASK             (0x80u)
#define TPM_CnSC_CHF_SHIFT            (7)
#define TPM_CnV_VAL_MASK              (0xFFFFu)
#define TPM_CnV_VAL_SHIFT             (0)
#define TPM_CnV_VAL(x)                ((((x)<<TPM_CnV_VAL_SHIFT))&TPM_CnV_VAL_MASK)
#define TPM_STATUS_CH0F_MASK          (0x1u)
#define TPM_STATUS_CH0F_SHIFT         (0)
#define TPM_STATUS_CH1F_MASK          (0x2u)
#define TPM_STATUS_CH1F_SHIFT         (1)
#define TPM_STATUS_TOF_MASK           (0x100u)
#define TPM_STATUS_TOF_SHIFT          (8)
#define TPM_CONF_DOZEEN_MASK          (0x20u)
#define TPM_CONF_DOZEEN_SHIFT         (5)
#define TPM_CONF_DBGMODE_MASK         (0xC0u)
#define TPM_CONF_DBGMODE_SHIFT        (6)
#define TPM_CONF_DBGMODE(x)           ((((x)<<TPM_CONF_DBGMODE_SHIFT))&TPM_CONF_DBGMODE_MASK)
#define TPM_CONF_GTBEEN_MASK          (0x200u)
#define TPM_CONF_GTBEEN_SHIFT         (9)
#define TPM_CONF_CSOT_MASK            (0x10000u)
#define TPM_CONF_CSOT_SHIFT           (16)
#define TPM_CONF_CSOO_MASK            (0x20000u)
#define TPM_CONF_CSOO_SHIFT           (17)
#define TPM_CONF_CROT_MASK            (0x40000u)
#define TPM_CONF_CROT_SHIFT           (18)
#define TPM_CONF_TRGSEL_MASK          (0xF000000u)
#define TPM_CONF_TRGSEL_SHIFT         (24)
#define TPM_CONF_TRGSEL(x)            ((((x)<<TPM_CONF_TRGSEL_SHIFT))&TPM_CONF_TRGSEL_MASK)
