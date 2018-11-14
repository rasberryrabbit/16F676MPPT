
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;16F676MPPT.mpas,62 :: 		begin
;16F676MPPT.mpas,63 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt3
;16F676MPPT.mpas,64 :: 		if PWM_FLAG=1 then begin
	BTFSS      _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
	GOTO       L__Interrupt6
;16F676MPPT.mpas,65 :: 		PWM_SIG:=0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,66 :: 		PWM_FLAG:=0;
	BCF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,67 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;16F676MPPT.mpas,69 :: 		TMR0:=255-ON_PWM;
	MOVF       _VOL_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;16F676MPPT.mpas,70 :: 		end else begin
	GOTO       L__Interrupt7
L__Interrupt6:
;16F676MPPT.mpas,72 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	ADDLW      55
	MOVWF      TMR0+0
;16F676MPPT.mpas,73 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,74 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,75 :: 		end;
L__Interrupt7:
;16F676MPPT.mpas,76 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;16F676MPPT.mpas,77 :: 		end;
L__Interrupt3:
;16F676MPPT.mpas,78 :: 		end;
L_end_Interrupt:
L__Interrupt54:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main:

;16F676MPPT.mpas,80 :: 		begin
;16F676MPPT.mpas,81 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;16F676MPPT.mpas,82 :: 		ANSEL:=%00000101;       // ADC conversion clock = fRC, RA0=Current, RA2=Voltage
	MOVLW      5
	MOVWF      ANSEL+0
;16F676MPPT.mpas,83 :: 		TRISA0_bit:=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;16F676MPPT.mpas,84 :: 		TRISA1_bit:=1;          // Vref
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;16F676MPPT.mpas,85 :: 		TRISA2_bit:=1;
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;16F676MPPT.mpas,86 :: 		VCFG_bit:=1;
	BSF        VCFG_bit+0, BitPos(VCFG_bit+0)
;16F676MPPT.mpas,87 :: 		CHS1_bit:=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;16F676MPPT.mpas,88 :: 		ADFM_bit:=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;16F676MPPT.mpas,90 :: 		TRISC1_bit:=0;          // PWM
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;16F676MPPT.mpas,91 :: 		TRISC4_bit:=0;          // LED
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;16F676MPPT.mpas,92 :: 		TRISC3_bit:=1;          // OP-AMP Cal
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;16F676MPPT.mpas,94 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,95 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,96 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,97 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,98 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;16F676MPPT.mpas,99 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;16F676MPPT.mpas,100 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
	CLRF       _TICK_1000+1
;16F676MPPT.mpas,102 :: 		OPTION_REG:=%11011111;        // ~4KHz @ 4MHz, 1000000 / 4 = 3.9k
	MOVLW      223
	MOVWF      OPTION_REG+0
;16F676MPPT.mpas,103 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;16F676MPPT.mpas,105 :: 		LM358_diff:=cLM358_diff;
	CLRF       _LM358_diff+0
;16F676MPPT.mpas,106 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;16F676MPPT.mpas,108 :: 		if Write_OPAMP=0 then begin
	BTFSC      RC3_bit+0, BitPos(RC3_bit+0)
	GOTO       L__main10
;16F676MPPT.mpas,109 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,110 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,111 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,112 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,113 :: 		EEPROM_Write(0, Lo(adc_cur));
	CLRF       FARG_EEPROM_Write_address+0
	MOVF       _adc_cur+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;16F676MPPT.mpas,114 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,115 :: 		LED1:=1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,116 :: 		Delay_ms(700);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L__main12:
	DECFSZ     R13+0, 1
	GOTO       L__main12
	DECFSZ     R12+0, 1
	GOTO       L__main12
	DECFSZ     R11+0, 1
	GOTO       L__main12
	NOP
;16F676MPPT.mpas,117 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,118 :: 		end;
L__main10:
;16F676MPPT.mpas,122 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,123 :: 		LM358_diff:=EEPROM_Read(0);
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,126 :: 		T1CKPS1_bit:=1;               // timer prescaler 1:4
	BSF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;16F676MPPT.mpas,130 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;16F676MPPT.mpas,131 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      24
	MOVWF      TMR1L+0
;16F676MPPT.mpas,132 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,133 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,135 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,136 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,137 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,139 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;16F676MPPT.mpas,141 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;16F676MPPT.mpas,143 :: 		VOL_PWM:=PWM_MID;
	MOVLW      101
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,144 :: 		flag_inc:=False;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,145 :: 		cur_prev:=0;
	CLRF       _cur_prev+0
	CLRF       _cur_prev+1
;16F676MPPT.mpas,146 :: 		vol_prev1:=0;
	CLRF       _vol_prev1+0
	CLRF       _vol_prev1+1
;16F676MPPT.mpas,148 :: 		powertime:=0;
	CLRF       _powertime+0
	CLRF       _powertime+1
;16F676MPPT.mpas,149 :: 		prevtime:=0;
	CLRF       _prevtime+0
	CLRF       _prevtime+1
;16F676MPPT.mpas,151 :: 		while True do begin
L__main14:
;16F676MPPT.mpas,153 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__main19
;16F676MPPT.mpas,154 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,155 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      24
	MOVWF      TMR1L+0
;16F676MPPT.mpas,156 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,157 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
	BTFSC      STATUS+0, 2
	INCF       _TICK_1000+1, 1
;16F676MPPT.mpas,158 :: 		end;
L__main19:
;16F676MPPT.mpas,160 :: 		wPWM := TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wPWM+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,161 :: 		if wPWM - prevtime > LED1_tm then begin
	MOVF       _prevtime+0, 0
	SUBWF      _TICK_1000+0, 0
	MOVWF      R1+0
	MOVF       _prevtime+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _TICK_1000+1, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       R1+0, 0
	SUBWF      _LED1_tm+0, 0
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L__main22
;16F676MPPT.mpas,162 :: 		prevtime := TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _prevtime+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _prevtime+1
;16F676MPPT.mpas,163 :: 		LED1 := not LED1;
	MOVLW
	XORWF      RC4_bit+0, 1
;16F676MPPT.mpas,164 :: 		end;
L__main22:
;16F676MPPT.mpas,167 :: 		cur_prev:=adc_cur;
	MOVF       _adc_cur+0, 0
	MOVWF      _cur_prev+0
	MOVF       _adc_cur+1, 0
	MOVWF      _cur_prev+1
;16F676MPPT.mpas,168 :: 		vol_prev2:=vol_prev1;
	MOVF       _vol_prev1+0, 0
	MOVWF      _vol_prev2+0
	MOVF       _vol_prev1+1, 0
	MOVWF      _vol_prev2+1
;16F676MPPT.mpas,169 :: 		vol_prev1:=adc_vol;
	MOVF       _adc_vol+0, 0
	MOVWF      _vol_prev1+0
	MOVF       _adc_vol+1, 0
	MOVWF      _vol_prev1+1
;16F676MPPT.mpas,171 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,172 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,173 :: 		for i:=0 to adc_max_loop-1 do begin
	CLRF       _i+0
L__main25:
;16F676MPPT.mpas,174 :: 		wPWM:=ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _wPWM+0
	MOVF       R0+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,175 :: 		wTemp:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _wTemp+0
	MOVF       R0+1, 0
	MOVWF      _wTemp+1
;16F676MPPT.mpas,176 :: 		adc_vol:=adc_vol+wPWM;
	MOVF       _wPWM+0, 0
	ADDWF      _adc_vol+0, 1
	MOVF       _wPWM+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_vol+1, 1
;16F676MPPT.mpas,177 :: 		adc_cur:=adc_cur+wTemp;
	MOVF       R0+0, 0
	ADDWF      _adc_cur+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_cur+1, 1
;16F676MPPT.mpas,178 :: 		end;
	MOVF       _i+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L__main28
	INCF       _i+0, 1
	GOTO       L__main25
L__main28:
;16F676MPPT.mpas,179 :: 		adc_vol:=adc_vol div adc_max_loop;
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
;16F676MPPT.mpas,180 :: 		adc_cur:=adc_cur div adc_max_loop;
	RRF        _adc_cur+1, 1
	RRF        _adc_cur+0, 1
	BCF        _adc_cur+1, 7
	RRF        _adc_cur+1, 1
	RRF        _adc_cur+0, 1
	BCF        _adc_cur+1, 7
	RRF        _adc_cur+1, 1
	RRF        _adc_cur+0, 1
	BCF        _adc_cur+1, 7
;16F676MPPT.mpas,181 :: 		adc_vol:=adc_vol * VOLMUL;
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
;16F676MPPT.mpas,184 :: 		wPWM:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wPWM+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,185 :: 		if wPWM - powertime < _UPDATE_INT then
	MOVF       _powertime+0, 0
	SUBWF      _TICK_1000+0, 0
	MOVWF      R1+0
	MOVF       _powertime+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _TICK_1000+1, 0
	MOVWF      R1+1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      20
	SUBWF      R1+0, 0
L__main57:
	BTFSC      STATUS+0, 0
	GOTO       L__main30
;16F676MPPT.mpas,186 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
L__main30:
;16F676MPPT.mpas,187 :: 		powertime:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _powertime+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _powertime+1
;16F676MPPT.mpas,189 :: 		power_prev:=power_curr;
	MOVF       _power_curr+0, 0
	MOVWF      _power_prev+0
	MOVF       _power_curr+1, 0
	MOVWF      _power_prev+1
	MOVF       _power_curr+2, 0
	MOVWF      _power_prev+2
	MOVF       _power_curr+3, 0
	MOVWF      _power_prev+3
;16F676MPPT.mpas,190 :: 		power_curr:= adc_vol * adc_cur;
	MOVF       _adc_vol+0, 0
	MOVWF      R0+0
	MOVF       _adc_vol+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       _adc_cur+0, 0
	MOVWF      R4+0
	MOVF       _adc_cur+1, 0
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _power_curr+0
	MOVF       R0+1, 0
	MOVWF      _power_curr+1
	MOVF       R0+2, 0
	MOVWF      _power_curr+2
	MOVF       R0+3, 0
	MOVWF      _power_curr+3
;16F676MPPT.mpas,192 :: 		if adc_cur>LM358_diff then begin
	MOVF       _adc_cur+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       _adc_cur+0, 0
	SUBWF      _LM358_diff+0, 0
L__main58:
	BTFSC      STATUS+0, 0
	GOTO       L__main33
;16F676MPPT.mpas,194 :: 		if power_curr = power_prev then begin
	MOVF       _power_curr+3, 0
	XORWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _power_curr+2, 0
	XORWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _power_curr+1, 0
	XORWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _power_curr+0, 0
	XORWF      _power_prev+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L__main36
;16F676MPPT.mpas,195 :: 		LED1_tm:=125;
	MOVLW      125
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,196 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,197 :: 		end else if power_curr > power_prev then begin
L__main36:
	MOVF       _power_curr+3, 0
	SUBWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _power_curr+2, 0
	SUBWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _power_curr+1, 0
	SUBWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _power_curr+0, 0
	SUBWF      _power_prev+0, 0
L__main60:
	BTFSC      STATUS+0, 0
	GOTO       L__main39
;16F676MPPT.mpas,198 :: 		LED1_tm:=100;
	MOVLW      100
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,199 :: 		end else begin
	GOTO       L__main40
L__main39:
;16F676MPPT.mpas,200 :: 		LED1_tm:=75;
	MOVLW      75
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,201 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,202 :: 		end;
L__main40:
;16F676MPPT.mpas,203 :: 		if (adc_vol+vol_prev2+1) div 2 < vol_prev1 then
	MOVF       _vol_prev2+0, 0
	ADDWF      _adc_vol+0, 0
	MOVWF      R0+0
	MOVF       _adc_vol+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _vol_prev2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R3+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	MOVF       _vol_prev1+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _vol_prev1+0, 0
	SUBWF      R1+0, 0
L__main61:
	BTFSC      STATUS+0, 0
	GOTO       L__main42
;16F676MPPT.mpas,204 :: 		flag_inc:=true;
	MOVLW      255
	MOVWF      _flag_inc+0
L__main42:
;16F676MPPT.mpas,205 :: 		end else begin
	GOTO       L__main34
L__main33:
;16F676MPPT.mpas,206 :: 		LED1_tm:=75;
	MOVLW      75
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,207 :: 		VOL_PWM:=PWM_MID;
	MOVLW      101
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,208 :: 		flag_inc:=false;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,209 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,210 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,211 :: 		power_flag:=0;
	CLRF       _power_flag+0
;16F676MPPT.mpas,212 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,213 :: 		end;
L__main34:
;16F676MPPT.mpas,216 :: 		if flag_inc then begin
	MOVF       _flag_inc+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main45
;16F676MPPT.mpas,217 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      200
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main48
;16F676MPPT.mpas,218 :: 		Inc(VOL_PWM)
	INCF       _VOL_PWM+0, 1
	GOTO       L__main49
;16F676MPPT.mpas,219 :: 		else begin
L__main48:
;16F676MPPT.mpas,220 :: 		VOL_PWM:=PWM_MAX;
	MOVLW      200
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,221 :: 		flag_inc:=false;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,222 :: 		end;
L__main49:
;16F676MPPT.mpas,223 :: 		end else begin
	GOTO       L__main46
L__main45:
;16F676MPPT.mpas,224 :: 		if VOL_PWM>PWM_MIN then
	MOVF       _VOL_PWM+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L__main51
;16F676MPPT.mpas,225 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main52
;16F676MPPT.mpas,226 :: 		else begin
L__main51:
;16F676MPPT.mpas,227 :: 		VOL_PWM:=PWM_MIN;
	MOVLW      2
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,228 :: 		flag_inc:=true;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,229 :: 		end;
L__main52:
;16F676MPPT.mpas,230 :: 		end;
L__main46:
;16F676MPPT.mpas,231 :: 		CONTLOOP:
L__main_CONTLOOP:
;16F676MPPT.mpas,232 :: 		end;
	GOTO       L__main14
;16F676MPPT.mpas,233 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
