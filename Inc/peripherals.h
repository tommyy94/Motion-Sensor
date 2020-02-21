/* SCS base address */
#define SCS                           (0xE000E000u)                 /* System Control Space Base Address */
#define SysTICK                       (SCS + 0x0010u)               /* SysTICK Timer */
#define NVIC                          (SCS + 0x0100u)               /* Nested Vectored Interrupt Controller */
#define SCB                           (SCS + 0x0D00u)               /* System Control Block */

/* NVIC Base Address */
#define NVIC_ISER                     (0x000u)                      /* Interrupt Set Enable Register */
#define NVIC_ICER                     (0x080u)                      /* Interrupt Clear Enable Register */
#define NVIC_ISPR                     (0x100u)                      /* Interrupt Set Pending Register */
#define NVIC_ICPR                     (0x180u)                      /* Interrupt Clear Pending Register */
#define NVIC_IP                       (0x300U)                      /* Interrupt Priority Register */

/* SCB Base Address */
#define SCB_CPUID                     (0x000u)                      /* CPUID Base Register */
#define SCB_ICSR                      (0x004u)                      /* Interrupt Control and State Register */
#define SCB_VTOR                      (0x008u)                      /* Vector Table Offset Register */
#define SCB_AIRCR                     (0x00Cu)                      /* Application Interrupt and Reset Control Register */
#define SCB_SCR                       (0x010u)                      /* System Control Register */
#define SCB_CCR                       (0x014u)                      /* Configuration Control Register */
#define SCB_SHP                       (0x01Cu)                      /* System Handlers Priority Register */
#define SCB_SHCSR                     (0x024u)                      /* System Handler Control and State Register */

/* SCB SCR Register Masks */
#define SCB_SCR_SEVONPEND_Pos         (4U)          
#define SCB_SCR_SEVONPEND_Msk         (1UL << SCB_SCR_SEVONPEND_Pos)
#define SCB_SCR_SLEEPDEEP_Pos         (2U)
#define SCB_SCR_SLEEPDEEP_Msk         (1UL << SCB_SCR_SLEEPDEEP_Pos)
#define SCB_SCR_SLEEPONEXIT_Pos       (1U)
#define SCB_SCR_SLEEPONEXIT_Msk       (1UL << SCB_SCR_SLEEPONEXIT_Pos)

/* Peripheral SIM base address */
#define SIM                           (0x40047000u)                 /* System Integration Module Base Address */
#define SIM_SOPT2                     (0x1004u)                     /* System Options 2 Register */
#define SIM_SOPT4                     (0x100Cu)                     /* System Options 4 Register */
#define SIM_SOPT5                     (0x1010u)                     /* System Options 5 Register */
#define SIM_SCGC4                     (0x1034u)                     /* System Clock Gating Control 4 Register */
#define SIM_SCGC5                     (0x1038u)                     /* System Clock Gating Control 5 Register */
#define SIM_SCGC6                     (0x103Cu)                     /* System Clock Gating Control 6 Register */
#define SIM_CLKDIV1                   (0x1044u)                     /* System Clock Divider Register 1 */
#define SIM_FCFG1                     (0x104Cu)                     /* Flash Configuration Register 1 */
#define SIM_FCFG2                     (0x1050u)                     /* Flash Configuration Register 2 */
#define SIM_UIDMH                     (0x1058u)                     /* Unique Identification Register Mid-High */
#define SIM_UIDML                     (0x105Cu)                     /* Unique Identification Register Mid-Low */
#define SIM_UIDL                      (0x1060u)                     /* Unique Identification Register Low */
#define SIM_COPC                      (0x1100u)                     /* Computer Operating Properly Register */
#define SIM_SRVCOP                    (0x1104u)                     /* Service COP Register */

/* Peripheral SIM Register Masks */
#define SIM_SCGC4_CMP_MASK            (0x80000u)
#define SIM_SCGC4_CMP_SHIFT           (19)
#define SIM_SCGC4_CMP_WIDTH           (1)
#define SIM_SCGC4_CMP(x)              ((((x)<<SIM_SCGC4_CMP_SHIFT))&SIM_SCGC4_CMP_MASK)
#define SIM_SCGC5_LPTMR_MASK          (0x1u)                        /* System Clock Gating Control 5 LPTMR0 Mask */
#define SIM_SCGC5_PORTA_MASK          (0x0200u)                     /* System Clock Gating Control 5 PORTA Mask */
#define SIM_SCGC5_PORTB_MASK          (0x0400u)                     /* System Clock Gating Control 5 PORTB Mask */
#define SIM_SCGC5_PORTC_MASK          (0x0800u)                     /* System Clock Gating Control 5 PORTC Mask */
#define SIM_SCGC5_PORTD_MASK          (0x1000u)                     /* System Clock Gating Control 5 PORTD Mask */
#define SIM_SCGC5_PORTE_MASK          (0x2000u)                     /* System Clock Gating Control 5 PORTE Mask */
#define SIM_SCGC6_TPM_MASK            (0x1000000u)                  /* System Clock Gating Control 6 TPM Mask */

#define SIM_SOPT2_TPMSRC_MASK         (0x3000000u)
#define SIM_SOPT2_TPMSRC_SHIFT        (24)
#define SIM_SOPT2_TPMSRC(x)           ((((x)<<SIM_SOPT2_TPMSRC_SHIFT))&SIM_SOPT2_TPMSRC_MASK)
#define SIM_SOPT2_PLLFLLSEL_MASK      (0x10000u)
#define SIM_SOPT2_UART0SRC_MASK       (0xC000000u)
#define SIM_SOPT2_UART0SRC_SHIFT      (26)
#define SIM_SOPT2_UART0SRC(x)         ((((x)<<SIM_SOPT2_UART0SRC_SHIFT))&SIM_SOPT2_UART0SRC_MASK)

#define SIM_CLKDIV1_OUTDIV4_MASK      (0x70000u)
#define SIM_CLKDIV1_OUTDIV4_SHIFT     (16)
#define SIM_CLKDIV1_OUTDIV4(x)        ((((x)<<SIM_CLKDIV1_OUTDIV4_SHIFT))&SIM_CLKDIV1_OUTDIV4_MASK)
#define SIM_CLKDIV1_OUTDIV1_MASK      (0xF0000000u)
#define SIM_CLKDIV1_OUTDIV1_SHIFT     (28)
#define SIM_CLKDIV1_OUTDIV1(x)        ((((x)<<SIM_CLKDIV1_OUTDIV1_SHIFT))&SIM_CLKDIV1_OUTDIV1_MASK)

#define SIM_FCFG1_FLASHDIS_MASK       (0x1u)
#define SIM_FCFG1_FLASHDIS_SHIFT      (0)
#define SIM_FCFG1_FLASHDOZE_MASK      (0x2u)
#define SIM_FCFG1_FLASHDOZE_SHIFT     (1)
#define SIM_FCFG1_PFSIZE_MASK         (0xF000000u)
#define SIM_FCFG1_PFSIZE_SHIFT        (24)
#define SIM_FCFG1_PFSIZE(x)           ((((x)<<SIM_FCFG1_PFSIZE_SHIFT))&SIM_FCFG1_PFSIZE_MASK)

/* Peripheral SMC base address */
#define SMC                           (0x4007E000u)                 /* System Mode Controller Base Address */
#define SMC_PMPROT                    (0x000u)                      /* Power Mode Protection Register */
#define SMC_PMCTRL                    (0x001u)                      /* Power Mode Control Register */
#define SMC_STOPCTRL                  (0x002u)                      /* Stop Control Register */
#define SMC_PMSTAT                    (0x003u)                      /* Power Mode Status Register */

#define SMC_PMPROT_AVLLS_MASK         (0x2u)
#define SMC_PMPROT_AVLLS_SHIFT        (1)
#define SMC_PMPROT_AVLP_MASK          (0x20u)
#define SMC_PMPROT_AVLP_SHIFT         (5)
#define SMC_PMCTRL_STOPM_MASK         (0x7u)
#define SMC_PMCTRL_STOPM_SHIFT        (0)
#define SMC_PMCTRL_STOPM(x)           ((((x)<<SMC_PMCTRL_STOPM_SHIFT))&SMC_PMCTRL_STOPM_MASK)
#define SMC_PMCTRL_STOPA_MASK         (0x8u)
#define SMC_PMCTRL_STOPA_SHIFT        (3)
#define SMC_PMCTRL_RUNM_MASK          (0x60u)
#define SMC_PMCTRL_RUNM_SHIFT         (5)
#define SMC_PMCTRL_RUNM(x)            ((((x)<<SMC_PMCTRL_RUNM_SHIFT))&SMC_PMCTRL_RUNM_MASK)
#define SMC_STOPCTRL_VLLSM_MASK       (0x7u)
#define SMC_STOPCTRL_VLLSM_SHIFT      (0)
#define SMC_STOPCTRL_VLLSM(x)         ((((x)<<SMC_STOPCTRL_VLLSM_SHIFT))&SMC_STOPCTRL_VLLSM_MASK)
#define SMC_STOPCTRL_PORPO_MASK       (0x20u)
#define SMC_STOPCTRL_PORPO_SHIFT      (5)
#define SMC_STOPCTRL_PSTOPO_MASK      (0xC0u)
#define SMC_STOPCTRL_PSTOPO_SHIFT     (6)
#define SMC_STOPCTRL_PSTOPO(x)        ((((x)<<SMC_STOPCTRL_PSTOPO_SHIFT))&SMC_STOPCTRL_PSTOPO_MASK)
#define SMC_PMSTAT_PMSTAT_MASK        (0x7Fu)
#define SMC_PMSTAT_PMSTAT_SHIFT       (0)
#define SMC_PMSTAT_PMSTAT(x)          ((((x)<<SMC_PMSTAT_PMSTAT_SHIFT))&SMC_PMSTAT_PMSTAT_MASK)

/* Peripheral MCG base address */
#define MCG                           (0x40064000u)                 /* Multipurpose Clock Generator Base Address */
#define MCG_C1                        (0x000u)                      /* MCG Control 1 Register */
#define MCG_C2                        (0x001u)                      /* MCG Control 2 Register */
#define MCG_C3                        (0x002u)                      /* MCG Control 3 Register */
#define MCG_C4                        (0x003u)                      /* MCG Control 4 Register */
#define MCG_C5                        (0x004u)                      /* MCG Control 5 Register */
#define MCG_C6                        (0x005u)                      /* MCG Control 6 Register */
#define MCG_S                         (0x006u)                      /* MCG Status Register */
#define MCG_SC                        (0x008u)                      /* MCG Status and Control Register */

/* Peripheral MCG Register Masks */
#define MCG_C1_IREFSTEN_MASK          (0x1u)
#define MCG_C1_IREFSTEN_SHIFT         (0)
#define MCG_C1_IRCLKEN_MASK           (0x2u)
#define MCG_C1_IRCLKEN_SHIFT          (1)
#define MCG_C1_IREFS_MASK             (0x4u)
#define MCG_C1_IREFS_SHIFT            (2)
#define MCG_C1_FRDIV_MASK             (0x38u)
#define MCG_C1_FRDIV_SHIFT            (3)
#define MCG_C1_FRDIV(x)               ((((x)<<MCG_C1_FRDIV_SHIFT))&MCG_C1_FRDIV_MASK)
#define MCG_C1_CLKS_MASK              (0xC0u)
#define MCG_C1_CLKS_SHIFT             (6)
#define MCG_C1_CLKS(x)                ((((x)<<MCG_C1_CLKS_SHIFT))&MCG_C1_CLKS_MASK)
#define MCG_C2_IRCS_MASK              (0x1u)
#define MCG_C2_IRCS_SHIFT             (0)
#define MCG_C2_LP_MASK                (0x2u)
#define MCG_C2_LP_SHIFT               (1)
#define MCG_C2_EREFS0_MASK            (0x4u)
#define MCG_C2_EREFS0_SHIFT           (2)
#define MCG_C2_HGO0_MASK              (0x8u)
#define MCG_C2_HGO0_SHIFT             (3)
#define MCG_C2_RANGE0_MASK            (0x30u)
#define MCG_C2_RANGE0_SHIFT           (4)
#define MCG_C2_RANGE0(x)              ((((x)<<MCG_C2_RANGE0_SHIFT))&MCG_C2_RANGE0_MASK)
#define MCG_C2_FCFTRIM_MASK           (0x40u)
#define MCG_C2_FCFTRIM_SHIFT          (6)
#define MCG_C2_LOCRE0_MASK            (0x80u)
#define MCG_C2_LOCRE0_SHIFT           (7)
#define MCG_C3_SCTRIM_MASK            (0xFFu)
#define MCG_C3_SCTRIM_SHIFT           (0)
#define MCG_C3_SCTRIM(x)              ((((x)<<MCG_C3_SCTRIM_SHIFT))&MCG_C3_SCTRIM_MASK)
#define MCG_C4_SCFTRIM_MASK           (0x1u)
#define MCG_C4_SCFTRIM_SHIFT          (0)
#define MCG_C4_FCTRIM_MASK            (0x1Eu)
#define MCG_C4_FCTRIM_SHIFT           (1)
#define MCG_C4_FCTRIM(x)              ((((x)<<MCG_C4_FCTRIM_SHIFT))&MCG_C4_FCTRIM_MASK)
#define MCG_C4_DRST_DRS_MASK          (0x60u)
#define MCG_C4_DRST_DRS_SHIFT         (5)
#define MCG_C4_DRST_DRS(x)            ((((x)<<MCG_C4_DRST_DRS_SHIFT))&MCG_C4_DRST_DRS_MASK)
#define MCG_C4_DMX32_MASK             (0x80u)
#define MCG_C4_DMX32_SHIFT            (7)
#define MCG_C6_CME_MASK               (0x20u)
#define MCG_C6_CME_SHIFT              (5)
#define MCG_S_IRCST_MASK              (0x1u)
#define MCG_S_IRCST_SHIFT             (0)
#define MCG_S_OSCINIT0_MASK           (0x2u)
#define MCG_S_OSCINIT0_SHIFT          (1)
#define MCG_S_CLKST_MASK              (0xCu)
#define MCG_S_CLKST_SHIFT             (2)
#define MCG_S_CLKST(x)                ((((x)<<MCG_S_CLKST_SHIFT))&MCG_S_CLKST_MASK)
#define MCG_S_IREFST_MASK             (0x10u)
#define MCG_S_IREFST_SHIFT            (4)
#define MCG_SC_LOCS0_MASK             (0x1u)
#define MCG_SC_LOCS0_SHIFT            (0)
#define MCG_SC_FCRDIV_MASK            (0xEu)
#define MCG_SC_FCRDIV_SHIFT           (1)
#define MCG_SC_FCRDIV(x)              ((((x)<<MCG_SC_FCRDIV_SHIFT))&MCG_SC_FCRDIV_MASK)
#define MCG_SC_FLTPRSRV_MASK          (0x10u)
#define MCG_SC_FLTPRSRV_SHIFT         (4)
#define MCG_SC_ATMF_MASK              (0x20u)
#define MCG_SC_ATMF_SHIFT             (5)
#define MCG_SC_ATMS_MASK              (0x40u)
#define MCG_SC_ATMS_SHIFT             (6)
#define MCG_SC_ATME_MASK              (0x80u)
#define MCG_SC_ATME_SHIFT             (7)
#define MCG_ATCVH_ATCVH_MASK          (0xFFu)
#define MCG_ATCVH_ATCVH_SHIFT         (0)
#define MCG_ATCVH_ATCVH(x)            ((((x)<<MCG_ATCVH_ATCVH_SHIFT))&MCG_ATCVH_ATCVH_MASK)
#define MCG_ATCVL_ATCVL_MASK          (0xFFu)
#define MCG_ATCVL_ATCVL_SHIFT         (0)
#define MCG_ATCVL_ATCVL(x)            ((((x)<<MCG_ATCVL_ATCVL_SHIFT))&MCG_ATCVL_ATCVL_MASK)

/* Peripheral OSC0 base address */
#define OSC0                          (0x40065000u)
#define OSC0_CR                       (0x000u)                      /* OSC Control Register */

/* Peripheral OSC0 Register Masks */
#define OSC_CR_SC16P_MASK             (0x1u)
#define OSC_CR_SC16P_SHIFT            (0)
#define OSC_CR_SC8P_MASK              (0x2u)
#define OSC_CR_SC8P_SHIFT             (1)
#define OSC_CR_SC4P_MASK              (0x4u)
#define OSC_CR_SC4P_SHIFT             (2)
#define OSC_CR_SC2P_MASK              (0x8u)
#define OSC_CR_SC2P_SHIFT             (3)
#define OSC_CR_EREFSTEN_MASK          (0x20u)
#define OSC_CR_EREFSTEN_SHIFT         (5)
#define OSC_CR_ERCLKEN_MASK           (0x80u)
#define OSC_CR_ERCLKEN_SHIFT          (7)

/* Peripheral LPTMR0 base address */
#define LPTMR0                        (0x40040000u)
#define LPTMR0_CSR                    (0x000u)
#define LPTMR0_PSR                    (0x004u)
#define LPTMR0_CMR                    (0x008u)
#define LPTMR0_CNR                    (0x00Cu)

/* Peripheral LPTMR0 Register Masks */
#define LPTMR_CSR_TEN_MASK            (0x1u)
#define LPTMR_CSR_TEN_SHIFT           (0)
#define LPTMR_CSR_TMS_MASK            (0x2u)
#define LPTMR_CSR_TMS_SHIFT           (1)
#define LPTMR_CSR_TFC_MASK            (0x4u)
#define LPTMR_CSR_TFC_SHIFT           (2)
#define LPTMR_CSR_TPP_MASK            (0x8u)
#define LPTMR_CSR_TPP_SHIFT           (3)
#define LPTMR_CSR_TPS_MASK            (0x30)
#define LPTMR_CSR_TPS_SHIFT           (4)
#define LPTMR_CSR_TPS(x)              ((((x)<<LPTMR_CSR_TPS_SHIFT))&LPTMR_CSR_TPS_MASK)
#define LPTMR_CSR_TIE_MASK            (0x40u)
#define LPTMR_CSR_TIE_SHIFT           (6)
#define LPTMR_CSR_TCF_MASK            (0x80u)
#define LPTMR_CSR_TCF_SHIFT           (7)
#define LPTMR_PSR_PCS_MASK            (0x3u)
#define LPTMR_PSR_PCS_SHIFT           (0)
#define LPTMR_PSR_PCS(x)              ((((x)<<LPTMR_PSR_PCS_SHIFT))&LPTMR_PSR_PCS_MASK)
#define LPTMR_PSR_PBYP_MASK           (0x4u)
#define LPTMR_PSR_PBYP_SHIFT          (2)
#define LPTMR_PSR_PRESCALE_MASK       (0x78u)
#define LPTMR_PSR_PRESCALE_SHIFT      (3)
#define LPTMR_PSR_PRESCALE(x)         ((((x)<<LPTMR_PSR_PRESCALE_SHIFT))&LPTMR_PSR_PRESCALE_MASK)
#define LPTMR_CMR_COMPARE_MASK        (0xFFFFu)
#define LPTMR_CMR_COMPARE_SHIFT       (0)
#define LPTMR_CMR_COMPARE(x)          ((((x)<<LPTMR_CMR_COMPARE_SHIFT))&LPTMR_CMR_COMPARE_MASK)
#define LPTMR_CNR_COUNTER_MASK        (0xFFFFu)
#define LPTMR_CNR_COUNTER_SHIFT       (0)
#define LPTMR_CNR_COUNTER(x)          ((((x)<<LPTMR_CNR_COUNTER_SHIFT))&LPTMR_CNR_COUNTER_MASK)

/* Peripheral PORT base address */
#define PORTA                         (0x40049000u)
#define PORTB                         (0x4004A000u)
#define PORTC                         (0x4004B000u)
#define PORTD                         (0x4004C000u)
#define PORTE                         (0x4004D000u)

/* Peripheral PCR Register Masks */
#define PORT_PCR                      (0x00u)                       /* PORT Pin Control Register Register */
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
#define PORT_ISFR                     (0xA0)                        /* Interrupt Status Flag Register */
#define PORT_ISFR_ISF_MASK            (0xFFFFFFFFu)
#define PORT_ISFR_ISF_SHIFT           (0)
#define PORT_ISFR_ISF(x)              ((((x)<<PORT_ISFR_ISF_SHIFT))&PORT_ISFR_ISF_MASK)

/* Peripheral FPTA base address */
#define FPTA                          (0xF80FF000u)                 /* FPTA Base Address */
#define FPTB                          (0xF80FF040u)                 /* FPTB Base Address */
#define FPTC                          (0xF80FF080u)                 /* FPTC Base Address */
#define FPTD                          (0xF80FF0C0u)                 /* FPTD Base Address */
#define FPTE                          (0xF80FF100u)                 /* FPTE Base Address */

#define FPT_PDOR                      (0x00u)                       /* Port Data Output Register */
#define FPT_PSOR                      (0x04u)                       /* Port Set Output Register */
#define FPT_PCOR                      (0x08u)                       /* Port Clear Output Register */
#define FPT_PTOR                      (0x0Cu)                       /* Port Toggle Output Register */
#define FPT_PDIR                      (0x10u)                       /* Port Data Input Register */
#define FPT_PDDR                      (0x14u)                       /* Port Data Direction Register */

/* Peripheral TPM base address */
#define TPM                           (0x40038000u)                 /* TPM Base Address */
#define TPM_SC                        (0x00u)                       /* Status and Control */
#define TPM_CNT                       (0x04u)                       /* Counter */
#define TPM_MOD                       (0x08u)                       /* Modulo */
#define TPM_C0SC                      (0x0Cu + 0x00u)               /* Channel 0 Status and Control */
#define TPM_C1SC                      (0x0Cu + 0x08u)               /* Channel 1 Status and Control */
#define TPM_C2SC                      (0x0Cu + 0x10u)               /* Channel 1 Status and Control */
#define TPM_C0V                       (0x10u + 0x00u)               /* Channel 0 Value */
#define TPM_C1V                       (0x10u + 0x08u)               /* Channel 1 Value */
#define TPM_C2V                       (0x10u + 0x10u)               /* Channel 2 Value */
#define TPM_CONF                      (0x84)                        /* Configuration */

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

/* Peripheral CMP Base Address */
#define CMP0                          (0x40073000u)                 /* CMP0 Base Address */
#define CMP0_CR0                      (0x00u)                       /* CMP Control Register 0 */
#define CMP0_CR1                      (0x01u)                       /* CMP Control Register 1 */
#define CMP0_FPR                      (0x02)                        /* CMP Filter Period Register */
#define CMP0_SCR                      (0x03)                        /* CMP Status and Control Register */
#define CMP0_DACCR                    (0x04)                        /* DAC Control Register */
#define CMP0_MUXCR                    (0x05)                        /* MUX Control Register */

/* Peripheral CMP Register Masks */
#define CMP_CR0_HYSTCTR_MASK                     (0x3u)
#define CMP_CR0_HYSTCTR_SHIFT                    (0)
#define CMP_CR0_HYSTCTR_WIDTH                    (2)
#define CMP_CR0_HYSTCTR(x)                       ((((x)<<CMP_CR0_HYSTCTR_SHIFT))&CMP_CR0_HYSTCTR_MASK)
#define CMP_CR0_FILTER_CNT_MASK                  (0x70u)
#define CMP_CR0_FILTER_CNT_SHIFT                 (4)
#define CMP_CR0_FILTER_CNT_WIDTH                 (3)
#define CMP_CR0_FILTER_CNT(x)                    ((((x)<<CMP_CR0_FILTER_CNT_SHIFT))&CMP_CR0_FILTER_CNT_MASK)
#define CMP_CR1_EN_MASK                          (0x1u)
#define CMP_CR1_EN_SHIFT                         (0)
#define CMP_CR1_EN_WIDTH                         (1)
#define CMP_CR1_EN(x)                            ((((x)<<CMP_CR1_EN_SHIFT))&CMP_CR1_EN_MASK)
#define CMP_CR1_OPE_MASK                         (0x2u)
#define CMP_CR1_OPE_SHIFT                        (1)
#define CMP_CR1_OPE_WIDTH                        (1)
#define CMP_CR1_OPE(x)                           ((((x)<<CMP_CR1_OPE_SHIFT))&CMP_CR1_OPE_MASK)
#define CMP_CR1_COS_MASK                         (0x4u)
#define CMP_CR1_COS_SHIFT                        (2)
#define CMP_CR1_COS_WIDTH                        (1)
#define CMP_CR1_COS(x)                           ((((x)<<CMP_CR1_COS_SHIFT))&CMP_CR1_COS_MASK)
#define CMP_CR1_INV_MASK                         (0x8u)
#define CMP_CR1_INV_SHIFT                        (3)
#define CMP_CR1_INV_WIDTH                        (1)
#define CMP_CR1_INV(x)                           ((((x)<<CMP_CR1_INV_SHIFT))&CMP_CR1_INV_MASK)
#define CMP_CR1_PMODE_MASK                       (0x10u)
#define CMP_CR1_PMODE_SHIFT                      (4)
#define CMP_CR1_PMODE_WIDTH                      (1)
#define CMP_CR1_PMODE(x)                         ((((x)<<CMP_CR1_PMODE_SHIFT))&CMP_CR1_PMODE_MASK)
#define CMP_CR1_TRIGM_MASK                       (0x20u)
#define CMP_CR1_TRIGM_SHIFT                      (5)
#define CMP_CR1_TRIGM_WIDTH                      (1)
#define CMP_CR1_TRIGM(x)                         ((((x)<<CMP_CR1_TRIGM_SHIFT))&CMP_CR1_TRIGM_MASK)
#define CMP_CR1_WE_MASK                          (0x40u)
#define CMP_CR1_WE_SHIFT                         (6)
#define CMP_CR1_WE_WIDTH                         (1)
#define CMP_CR1_WE(x)                            ((((x)<<CMP_CR1_WE_SHIFT))&CMP_CR1_WE_MASK)
#define CMP_CR1_SE_MASK                          (0x80u)
#define CMP_CR1_SE_SHIFT                         (7)
#define CMP_CR1_SE_WIDTH                         (1)
#define CMP_CR1_SE(x)                            ((((x)<<CMP_CR1_SE_SHIFT))&CMP_CR1_SE_MASK)
#define CMP_FPR_FILT_PER_MASK                    (0xFFu)
#define CMP_FPR_FILT_PER_SHIFT                   (0)
#define CMP_FPR_FILT_PER_WIDTH                   (8)
#define CMP_FPR_FILT_PER(x)                      ((((x)<<CMP_FPR_FILT_PER_SHIFT))&CMP_FPR_FILT_PER_MASK)
#define CMP_SCR_COUT_MASK                        (0x1u)
#define CMP_SCR_COUT_SHIFT                       (0)
#define CMP_SCR_COUT_WIDTH                       (1)
#define CMP_SCR_COUT(x)                          ((((x)<<CMP_SCR_COUT_SHIFT))&CMP_SCR_COUT_MASK)
#define CMP_SCR_CFF_MASK                         (0x2u)
#define CMP_SCR_CFF_SHIFT                        (1)
#define CMP_SCR_CFF_WIDTH                        (1)
#define CMP_SCR_CFF(x)                           ((((x)<<CMP_SCR_CFF_SHIFT))&CMP_SCR_CFF_MASK)
#define CMP_SCR_CFR_MASK                         (0x4u)
#define CMP_SCR_CFR_SHIFT                        (2)
#define CMP_SCR_CFR_WIDTH                        (1)
#define CMP_SCR_CFR(x)                           ((((x)<<CMP_SCR_CFR_SHIFT))&CMP_SCR_CFR_MASK)
#define CMP_SCR_IEF_MASK                         (0x8u)
#define CMP_SCR_IEF_SHIFT                        (3)
#define CMP_SCR_IEF_WIDTH                        (1)
#define CMP_SCR_IEF(x)                           ((((x)<<CMP_SCR_IEF_SHIFT))&CMP_SCR_IEF_MASK)
#define CMP_SCR_IER_MASK                         (0x10u)
#define CMP_SCR_IER_SHIFT                        (4)
#define CMP_SCR_IER_WIDTH                        (1)
#define CMP_SCR_IER(x)                           ((((x)<<CMP_SCR_IER_SHIFT))&CMP_SCR_IER_MASK)
#define CMP_SCR_DMAEN_MASK                       (0x40u)
#define CMP_SCR_DMAEN_SHIFT                      (6)
#define CMP_SCR_DMAEN_WIDTH                      (1)
#define CMP_SCR_DMAEN(x)                         ((((x)<<CMP_SCR_DMAEN_SHIFT))&CMP_SCR_DMAEN_MASK)
#define CMP_DACCR_VOSEL_MASK                     (0x3Fu)
#define CMP_DACCR_VOSEL_SHIFT                    (0)
#define CMP_DACCR_VOSEL_WIDTH                    (6)
#define CMP_DACCR_VOSEL(x)                       ((((x)<<CMP_DACCR_VOSEL_SHIFT))&CMP_DACCR_VOSEL_MASK)
#define CMP_DACCR_VRSEL_MASK                     (0x40u)
#define CMP_DACCR_VRSEL_SHIFT                    (6)
#define CMP_DACCR_VRSEL_WIDTH                    (1)
#define CMP_DACCR_VRSEL(x)                       ((((x)<<CMP_DACCR_VRSEL_SHIFT))&CMP_DACCR_VRSEL_MASK)
#define CMP_DACCR_DACEN_MASK                     (0x80u)
#define CMP_DACCR_DACEN_SHIFT                    (7)
#define CMP_DACCR_DACEN_WIDTH                    (1)
#define CMP_DACCR_DACEN(x)                       ((((x)<<CMP_DACCR_DACEN_SHIFT))&CMP_DACCR_DACEN_MASK)
#define CMP_MUXCR_MSEL_MASK                      (0x7u)
#define CMP_MUXCR_MSEL_SHIFT                     (0)
#define CMP_MUXCR_MSEL_WIDTH                     (3)
#define CMP_MUXCR_MSEL(x)                        ((((x)<<CMP_MUXCR_MSEL_SHIFT))&CMP_MUXCR_MSEL_MASK)
#define CMP_MUXCR_PSEL_MASK                      (0x38u)
#define CMP_MUXCR_PSEL_SHIFT                     (3)
#define CMP_MUXCR_PSEL_WIDTH                     (3)
#define CMP_MUXCR_PSEL(x)                        ((((x)<<CMP_MUXCR_PSEL_SHIFT))&CMP_MUXCR_PSEL_MASK)
#define CMP_MUXCR_PSTM_MASK                      (0x80u)
#define CMP_MUXCR_PSTM_SHIFT                     (7)
#define CMP_MUXCR_PSTM_WIDTH                     (1)
#define CMP_MUXCR_PSTM(x)                        ((((x)<<CMP_MUXCR_PSTM_SHIFT))&CMP_MUXCR_PSTM_MASK)