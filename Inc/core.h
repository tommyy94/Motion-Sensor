/* Auxiliary constants */
#define NotAvail_IRQn         (-128u)            /* Not available device specific interrupt */

/* Core interrupts */
#define NonMaskableInt_IRQn   (-14u)             /* Non Maskable Interrupt */
#define HardFault_IRQn        (-13u)             /* Cortex-M0 SV Hard Fault Interrupt */
#define SVCall_IRQn           (-5u)              /* Cortex-M0 SV Call Interrupt */
#define PendSV_IRQn           (-2u)              /* Cortex-M0 Pend SV Interrupt */
#define SysTick_IRQn          (-1u)              /* Cortex-M0 System Tick Interrupt */

/* Device specific interrupts */
#define DMA0_IRQn             (0u)               /* DMA channel 0 transfer complete */
#define DMA1_IRQn             (1u)               /* DMA channel 1 transfer complete */
#define DMA2_IRQn             (2u)               /* DMA channel 2 transfer complete */
#define DMA3_IRQn             (3u)               /* DMA channel 3 transfer complete 19 */
#define Reserved20_IRQn       (4u)               /* Reserved interrupt 20 */
#define FTFA_IRQn             (5u)               /* FTFA command complete/read collision interrupt */
#define LVD_LVW_IRQn          (6u)               /* Low Voltage Detect Low Voltage Warning */
#define LLWU_IRQn             (7u)               /* Low leakage wakeup Unit */
#define I2C0_IRQn             (8u)               /* I2C0 interrupt */
#define I2C1_IRQn             (9u)               /* I2C1 interrupt */
#define SPI0_IRQn             (10u)              /* SPI0 interrupt */
#define SPI1_IRQn             (11u)              /* SPI1 interrupt */
#define UART0_IRQn            (12u)              /* UART0 status/error interrupt */
#define UART1_IRQn            (13u)              /* UART1 status/error interrupt */
#define UART2_IRQn            (14u)              /* UART2 status/error interrupt */
#define ADC0_IRQn             (15u)              /* ADC0 interrupt */
#define CMP0_IRQn             (16u)              /* CMP0 interrupt */
#define TPM0_IRQn             (17u)              /* TPM0 fault overflow and channels interrupt */
#define TPM1_IRQn             (18u)              /* TPM1 fault overflow and channels interrupt */
#define TPM2_IRQn             (19u)              /* TPM1 fault overflow and channels interrupt */
#define RTC_IRQn              (20u)              /* RTC alarm */
#define RTC_Seconds_IRQn      (21u)              /* RTC seconds */
#define PIT_IRQn              (22u)              /* PIT interrupt */
#define Reserved39_IRQn       (23u)              /* Reserved interrupt 39 */
#define USB0_IRQn             (24u)              /* USB0 interrupt */
#define DAC0_IRQn             (25u)              /* DAC0 interrupt */
#define TSI0_IRQn             (26u)              /* TSI0 interrupt */
#define MCG_IRQn              (27u)              /* MCG interrupt */
#define LPTMR0_IRQn           (28u)              /* LPTMR0 interrupt */
#define Reserved45_IRQn       (29u)              /* Reserved interrupt 45 */
#define PORTA_IRQn            (30u)              /* Port A interrupt */
#define PORTD_IRQn            (31u)              /* Port D interrupt */

/* Cortex M0+ has 2 priority bits => 2^2 = 4 priority levels */
#define NVIC_IPRn_LEVEL0      (0x00u)
#define NVIC_IPRn_LEVEL1      (0x40u)
#define NVIC_IPRn_LEVEL2      (0x80u)
#define NVIC_IPRn_LEVEL3      (0xC0u)
