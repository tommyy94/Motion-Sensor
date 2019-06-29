/* Core interrupts */
#define NonMaskableInt_IRQn   (-14u)             /* Non Maskable Interrupt */
#define HardFault_IRQn        (-13u)             /* Cortex-M0 SV Hard Fault Interrupt */
#define SVCall_IRQn           (-5u)              /* Cortex-M0 SV Call Interrupt */
#define PendSV_IRQn           (-2u)              /* Cortex-M0 Pend SV Interrupt */
#define SysTick_IRQn          (-1u)              /* Cortex-M0 System Tick Interrupt */

/* Device specific interrupts */
#define Reserved16_IRQn       (0u)               /* Reserved interrupt 16 */
#define Reserved17_IRQn       (1u)               /* Reserved interrupt 17 */
#define Reserved18_IRQn       (2u)               /* Reserved interrupt 18 */
#define Reserved19_IRQn       (3u)               /* Reserved interrupt 19 */
#define Reserved20_IRQn       (4u)               /* Reserved interrupt 20 */
#define FTFA_IRQn             (5u)               /* FTFA command complete/read collision interrupt */
#define LVD_LVW_IRQn          (6u)               /* Low Voltage Detect Low Voltage Warning */
#define Reserved23_IRQn       (7u)               /* Reserved interrupt 23 */
#define I2C0_IRQn             (8u)               /* I2C0 interrupt */
#define I2C1_IRQn             (9u)               /* I2C1 interrupt */
#define SPI0_IRQn             (10u)              /* SPI0 interrupt */
#define Reserved27_IRQn       (11u)              /* Reserved interrupt 27 */
#define UART0_IRQn            (12u)              /* UART0 status/error interrupt */
#define Reserved29_IRQn       (13u)              /* Reserved interrupt 29 */
#define Reserved30_IRQn       (14u)              /* Reserved interrupt 30 */
#define ADC0_IRQn             (15u)              /* ADC0 interrupt */
#define CMP0_IRQn             (16u)              /* CMP0 interrupt */
#define TPM0_IRQn             (17u)              /* TPM0 fault overflow and channels interrupt */
#define TPM1_IRQn             (18u)              /* TPM1 fault overflow and channels interrupt */
#define Reserved35_IRQn       (19u)              /* Reserved interrupt 35 */
#define Reserved36_IRQn       (20u)              /* Reserved interrupt 36 */
#define Reserved37_IRQn       (21u)              /* Reserved interrupt 37 */
#define Reserved38_IRQn       (22u)              /* Reserved interrupt 38 */
#define Reserved39_IRQn       (23u)              /* Reserved interrupt 39 */
#define Reserved40_IRQn       (24u)              /* Reserved interrupt 40 */
#define Reserved41_IRQn       (25u)              /* Reserved interrupt 41 */
#define Reserved42_IRQn       (26u)              /* Reserved interrupt 42 */
#define MCG_IRQn              (27u)              /* MCG interrupt */
#define LPTimer_IRQn          (28u)              /* LPTimer interrupt */
#define Reserved45_IRQn       (29u)              /* Reserved interrupt 45 */
#define PORTA_IRQn            (30u)              /* Port A interrupt */
#define PORTB_IRQn            (31u)              /* Port B interrupt */

/* Cortex M0+ has 2 priority bits => 2^2 = 4 priority levels */
#define NVIC_IPRn_LEVEL0      (0x00u)
#define NVIC_IPRn_LEVEL1      (0x40u)
#define NVIC_IPRn_LEVEL2      (0x80u)
#define NVIC_IPRn_LEVEL3      (0xC0u)
