/**
 ******************************************************************************
 * @file    VoltAmpE3N2021.c
 * @version V0.1.0
 * @date    17-Dez-2021
 * @brief   Projeto Volt/Amperímetro.
 ******************************************************************************
 */

/* Pinos do LCD -------------------------------------------------------------*/
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

/* Função Principal ---------------------------------------------------------*/
void main()
{
    char i = 0;
    unsigned int voltAD;
    unsigned int voltDecimal;
    unsigned int voltInteiro;
    unsigned int ampAD;
    unsigned int ampDecimal;
    unsigned int ampInteiro;
    unsigned int ampDecimal1;
    unsigned int ampDecimal2;
    char voltDecimalStr[7];
    char voltInteiroStr[7];
    char ampDecimal1Str[7];
    char ampInteiroStr[7];
    char ampDecimal2Str[7];
    int leitura = 0;

    /* Inicializações */
    ADCON0 = 0x00;
    ADCON1 = 0x00;
    TRISA = 0xFF;
    Lcd_Init();
    Lcd_Cmd(_Lcd_CURSOR_OFF);
    Lcd_Out(1, 1, "   SENAI 2021   ");
    Lcd_Out(2, 1, "Volt/Amperimetro");
    Delay_ms(2000);
    Lcd_Out(1, 1, "Volt=          V");
    Lcd_Out(2, 1, "Amp=           A");

    /* LOOP PRINCIPAL */
    while (1)
    {

        /* Realiza as leituras das entradas analógicas e calcula a média */
        voltAD = 0;
        ampAD = 0;
        for (i = 0; i < 16; i++)
        {
            voltAD += Adc_Read(0);
            ampAD += Adc_Read(1);

            delay_ms(10);
        }
        voltAD = voltAD / 16;
        ampAD = ampAD / 16;

        /* Converte para Tensão separando a casa decimal */
        voltAD = (float)voltAD / 3.0;   // Constante de conversão
        voltInteiro = voltAD / 10;
        voltDecimal = voltAD % 10;
        IntToStr(voltInteiro, voltInteiroStr);
        IntToStr(voltDecimal, voltDecimalStr);
        Ltrim(voltDecimalStr);
        
        /* Converte para Corrente separando a casa decimal */
        ampAD = (float)ampAD * 1.1;     // Constante de conversão
        ampInteiro = ampAD / 100;
        ampDecimal = ampAD % 100;
        ampDecimal1 = ampDecimal / 10;
        ampDecimal2 = ampDecimal % 10;
        IntToStr(ampInteiro, ampInteiroStr);
        IntToStr(ampDecimal1, ampDecimal1Str);
        IntToStr(ampDecimal2, ampDecimal2Str);
        Ltrim(ampDecimal1Str);
        Ltrim(ampDecimal2Str);
        
        /* Mostra a Tensão no LCD - formato: 62,8V */
        Lcd_Out(1, 8, voltInteiroStr);
        Lcd_Chr_CP(',');
        Lcd_Out(1, 15, voltDecimalStr);

        /* Mostra a Tensão no LCD - formato: 0,28A */
        Lcd_Out(2, 7, ampInteiroStr);
        Lcd_Chr_CP(',');
        Lcd_Out(2, 14, ampDecimal1Str);
        Lcd_Out(2, 15, ampDecimal2Str);
    }
}