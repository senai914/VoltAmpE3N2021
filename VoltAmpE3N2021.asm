
_main:

;VoltAmpE3N2021.c,25 :: 		void main()
;VoltAmpE3N2021.c,27 :: 		char i = 0;
	CLRF       main_i_L0+0
;VoltAmpE3N2021.c,44 :: 		ADCON0 = 0x00;
	CLRF       ADCON0+0
;VoltAmpE3N2021.c,45 :: 		ADCON1 = 0x00;
	CLRF       ADCON1+0
;VoltAmpE3N2021.c,46 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;VoltAmpE3N2021.c,47 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;VoltAmpE3N2021.c,48 :: 		Lcd_Cmd(_Lcd_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;VoltAmpE3N2021.c,49 :: 		Lcd_Out(1, 1, "   SENAI 2X21   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_VoltAmpE3N2021+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,50 :: 		Lcd_Out(2, 1, "Volt/Amperimetro");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_VoltAmpE3N2021+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,51 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;VoltAmpE3N2021.c,52 :: 		Lcd_Out(1, 1, "Volt=          V");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_VoltAmpE3N2021+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,53 :: 		Lcd_Out(2, 1, "Amp=           A");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_VoltAmpE3N2021+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,56 :: 		while (1)
L_main1:
;VoltAmpE3N2021.c,60 :: 		voltAD = 0;
	CLRF       main_voltAD_L0+0
	CLRF       main_voltAD_L0+1
;VoltAmpE3N2021.c,61 :: 		ampAD = 0;
	CLRF       main_ampAD_L0+0
	CLRF       main_ampAD_L0+1
;VoltAmpE3N2021.c,62 :: 		for (i = 0; i < 16; i++)
	CLRF       main_i_L0+0
L_main3:
	MOVLW      16
	SUBWF      main_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;VoltAmpE3N2021.c,64 :: 		voltAD += Adc_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      main_voltAD_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_voltAD_L0+1, 1
;VoltAmpE3N2021.c,65 :: 		ampAD += Adc_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      main_ampAD_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_ampAD_L0+1, 1
;VoltAmpE3N2021.c,67 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
;VoltAmpE3N2021.c,62 :: 		for (i = 0; i < 16; i++)
	INCF       main_i_L0+0, 1
;VoltAmpE3N2021.c,68 :: 		}
	GOTO       L_main3
L_main4:
;VoltAmpE3N2021.c,69 :: 		voltAD = voltAD / 16;
	MOVF       main_voltAD_L0+0, 0
	MOVWF      R4+0
	MOVF       main_voltAD_L0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVF       R4+0, 0
	MOVWF      main_voltAD_L0+0
	MOVF       R4+1, 0
	MOVWF      main_voltAD_L0+1
;VoltAmpE3N2021.c,70 :: 		ampAD = ampAD / 16;
	RRF        main_ampAD_L0+1, 1
	RRF        main_ampAD_L0+0, 1
	BCF        main_ampAD_L0+1, 7
	RRF        main_ampAD_L0+1, 1
	RRF        main_ampAD_L0+0, 1
	BCF        main_ampAD_L0+1, 7
	RRF        main_ampAD_L0+1, 1
	RRF        main_ampAD_L0+0, 1
	BCF        main_ampAD_L0+1, 7
	RRF        main_ampAD_L0+1, 1
	RRF        main_ampAD_L0+0, 1
	BCF        main_ampAD_L0+1, 7
;VoltAmpE3N2021.c,73 :: 		voltAD = (float)voltAD / 3.0;   // Constante de conversão
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      64
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+2
	MOVF       R0+1, 0
	MOVWF      FLOC__main+3
	MOVF       FLOC__main+2, 0
	MOVWF      main_voltAD_L0+0
	MOVF       FLOC__main+3, 0
	MOVWF      main_voltAD_L0+1
;VoltAmpE3N2021.c,74 :: 		voltInteiro = voltAD / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+0
	MOVF       FLOC__main+3, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+0
	MOVF       FLOC__main+3, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;VoltAmpE3N2021.c,75 :: 		voltDecimal = voltAD % 10;
	MOVF       R0+0, 0
	MOVWF      main_voltDecimal_L0+0
	MOVF       R0+1, 0
	MOVWF      main_voltDecimal_L0+1
;VoltAmpE3N2021.c,76 :: 		IntToStr(voltInteiro, voltInteiroStr);
	MOVF       FLOC__main+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FLOC__main+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_voltInteiroStr_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;VoltAmpE3N2021.c,77 :: 		IntToStr(voltDecimal, voltDecimalStr);
	MOVF       main_voltDecimal_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_voltDecimal_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_voltDecimalStr_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;VoltAmpE3N2021.c,78 :: 		Ltrim(voltDecimalStr);
	MOVLW      main_voltDecimalStr_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;VoltAmpE3N2021.c,81 :: 		ampAD = (float)ampAD * 1.1;     // Constante de conversão
	MOVF       main_ampAD_L0+0, 0
	MOVWF      R0+0
	MOVF       main_ampAD_L0+1, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	MOVWF      main_ampAD_L0+0
	MOVF       FLOC__main+1, 0
	MOVWF      main_ampAD_L0+1
;VoltAmpE3N2021.c,82 :: 		ampInteiro = ampAD / 100;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+2
	MOVF       R0+1, 0
	MOVWF      FLOC__main+3
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
;VoltAmpE3N2021.c,84 :: 		ampDecimal1 = ampDecimal / 10;
	MOVF       R0+0, 0
	MOVWF      main_ampDecimal1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_ampDecimal1_L0+1
;VoltAmpE3N2021.c,85 :: 		ampDecimal2 = ampDecimal % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_ampDecimal2_L0+0
	MOVF       R0+1, 0
	MOVWF      main_ampDecimal2_L0+1
;VoltAmpE3N2021.c,86 :: 		IntToStr(ampInteiro, ampInteiroStr);
	MOVF       FLOC__main+2, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FLOC__main+3, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_ampInteiroStr_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;VoltAmpE3N2021.c,87 :: 		IntToStr(ampDecimal1, ampDecimal1Str);
	MOVF       main_ampDecimal1_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_ampDecimal1_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_ampDecimal1Str_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;VoltAmpE3N2021.c,88 :: 		IntToStr(ampDecimal2, ampDecimal2Str);
	MOVF       main_ampDecimal2_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_ampDecimal2_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_ampDecimal2Str_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;VoltAmpE3N2021.c,89 :: 		Ltrim(ampDecimal1Str);
	MOVLW      main_ampDecimal1Str_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;VoltAmpE3N2021.c,90 :: 		Ltrim(ampDecimal2Str);
	MOVLW      main_ampDecimal2Str_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;VoltAmpE3N2021.c,93 :: 		Lcd_Out(1, 8, voltInteiroStr);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_voltInteiroStr_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,94 :: 		Lcd_Chr_CP(',');
	MOVLW      44
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;VoltAmpE3N2021.c,95 :: 		Lcd_Out(1, 15, voltDecimalStr);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_voltDecimalStr_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,98 :: 		Lcd_Out(2, 7, ampInteiroStr);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_ampInteiroStr_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,99 :: 		Lcd_Chr_CP(',');
	MOVLW      44
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;VoltAmpE3N2021.c,100 :: 		Lcd_Out(2, 14, ampDecimal1Str);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_ampDecimal1Str_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,101 :: 		Lcd_Out(2, 15, ampDecimal2Str);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_ampDecimal2Str_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;VoltAmpE3N2021.c,102 :: 		}
	GOTO       L_main1
;VoltAmpE3N2021.c,103 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
