
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;16F676MPPT.mpas,72 :: 		begin
;16F676MPPT.mpas,73 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt3
;16F676MPPT.mpas,74 :: 		PWM_SIG:=not PWM_SIG;
	MOVLW
	XORWF      RC1_bit+0, 1
;16F676MPPT.mpas,75 :: 		if PWM_SIG=0 then begin
	BTFSC      RC1_bit+0, BitPos(RC1_bit+0)
	GOTO       L__Interrupt6
;16F676MPPT.mpas,76 :: 		doADCRead:=1;
	MOVLW      1
	MOVWF      _doADCRead+0
;16F676MPPT.mpas,78 :: 		ON_PWM:=VOLPWM;
	MOVF       _VOLPWM+0, 0
	MOVWF      _ON_PWM+0
;16F676MPPT.mpas,79 :: 		TMR0:=255-ON_PWM;
	MOVF       _VOLPWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;16F676MPPT.mpas,80 :: 		end else begin
	GOTO       L__Interrupt7
L__Interrupt6:
;16F676MPPT.mpas,82 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	ADDLW      5
	MOVWF      TMR0+0
;16F676MPPT.mpas,83 :: 		end;
L__Interrupt7:
;16F676MPPT.mpas,84 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;16F676MPPT.mpas,85 :: 		end;
L__Interrupt3:
;16F676MPPT.mpas,86 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt9
;16F676MPPT.mpas,87 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      248
	MOVWF      TMR1H+0
;16F676MPPT.mpas,88 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      48
	MOVWF      TMR1L+0
;16F676MPPT.mpas,89 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,90 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
	BTFSC      STATUS+0, 2
	INCF       _TICK_1000+1, 1
;16F676MPPT.mpas,91 :: 		end;
L__Interrupt9:
;16F676MPPT.mpas,92 :: 		end;
L_end_Interrupt:
L__Interrupt64:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main:

;16F676MPPT.mpas,94 :: 		begin
;16F676MPPT.mpas,95 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;16F676MPPT.mpas,96 :: 		ANSEL:=%00000101;       // ADC conversion clock = fRC, RA0=Current, RA2=Voltage
	MOVLW      5
	MOVWF      ANSEL+0
;16F676MPPT.mpas,97 :: 		TRISA0_bit:=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;16F676MPPT.mpas,98 :: 		TRISA1_bit:=1;          // Vref
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;16F676MPPT.mpas,99 :: 		TRISA2_bit:=1;
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;16F676MPPT.mpas,100 :: 		VCFG_bit:=1;
	BSF        VCFG_bit+0, BitPos(VCFG_bit+0)
;16F676MPPT.mpas,101 :: 		CHS1_bit:=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;16F676MPPT.mpas,102 :: 		ADFM_bit:=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;16F676MPPT.mpas,104 :: 		TRISC1_bit:=0;          // PWM
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;16F676MPPT.mpas,105 :: 		TRISC4_bit:=0;          // LED
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;16F676MPPT.mpas,106 :: 		TRISC3_bit:=1;          // OP-AMP Cal
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;16F676MPPT.mpas,108 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,109 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,110 :: 		LED1_tm:=100;
	MOVLW      100
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,111 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;16F676MPPT.mpas,112 :: 		VOLPWM:=0;
	CLRF       _VOLPWM+0
;16F676MPPT.mpas,113 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
	CLRF       _TICK_1000+1
;16F676MPPT.mpas,115 :: 		OPTION_REG:=%11011111;        // ~4KHz @ 4MHz, 1000000 / 4 = 3.9k
	MOVLW      223
	MOVWF      OPTION_REG+0
;16F676MPPT.mpas,116 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;16F676MPPT.mpas,118 :: 		LM358_diff:=cLM358_diff;
	CLRF       _LM358_diff+0
;16F676MPPT.mpas,119 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,120 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,121 :: 		ClrWDT;
	CLRWDT
;16F676MPPT.mpas,123 :: 		if Write_OPAMP=0 then begin
	BTFSC      RC3_bit+0, BitPos(RC3_bit+0)
	GOTO       L__main13
;16F676MPPT.mpas,124 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,125 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,126 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,127 :: 		EEPROM_Write(0, Lo(adc_cur));
	CLRF       FARG_EEPROM_Write_address+0
	MOVF       _adc_cur+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;16F676MPPT.mpas,128 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,129 :: 		LED1:=1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,130 :: 		Delay_ms(700);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L__main15:
	DECFSZ     R13+0, 1
	GOTO       L__main15
	DECFSZ     R12+0, 1
	GOTO       L__main15
	DECFSZ     R11+0, 1
	GOTO       L__main15
	NOP
;16F676MPPT.mpas,131 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,132 :: 		end;
L__main13:
;16F676MPPT.mpas,133 :: 		ClrWDT;
	CLRWDT
;16F676MPPT.mpas,137 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,138 :: 		LM358_diff:=EEPROM_Read(0);
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,140 :: 		if LM358_diff>$1f then
	MOVF       R0+0, 0
	SUBLW      31
	BTFSC      STATUS+0, 0
	GOTO       L__main17
;16F676MPPT.mpas,141 :: 		LM358_diff:=0;
	CLRF       _LM358_diff+0
L__main17:
;16F676MPPT.mpas,143 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;16F676MPPT.mpas,148 :: 		T1CKPS1_bit:=0;
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;16F676MPPT.mpas,149 :: 		T1CKPS0_bit:=0;               // timer prescaler 1:1
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;16F676MPPT.mpas,151 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      48
	MOVWF      TMR1L+0
;16F676MPPT.mpas,152 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      248
	MOVWF      TMR1H+0
;16F676MPPT.mpas,153 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,155 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,156 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,157 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,159 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;16F676MPPT.mpas,160 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;16F676MPPT.mpas,162 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;16F676MPPT.mpas,164 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;16F676MPPT.mpas,166 :: 		VOLPWM:=PWM_MIN;
	MOVLW      10
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,167 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,168 :: 		vol_prev1:=0;
	CLRF       _vol_prev1+0
	CLRF       _vol_prev1+1
;16F676MPPT.mpas,170 :: 		powertime:=0;
	CLRF       _powertime+0
	CLRF       _powertime+1
;16F676MPPT.mpas,171 :: 		prevtime:=0;
	CLRF       _prevtime+0
	CLRF       _prevtime+1
;16F676MPPT.mpas,172 :: 		voltime:=0;
	CLRF       _voltime+0
	CLRF       _voltime+1
;16F676MPPT.mpas,175 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,176 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L__main19:
	DECFSZ     R13+0, 1
	GOTO       L__main19
	DECFSZ     R12+0, 1
	GOTO       L__main19
	DECFSZ     R11+0, 1
	GOTO       L__main19
;16F676MPPT.mpas,177 :: 		LED1:=1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,178 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L__main20:
	DECFSZ     R13+0, 1
	GOTO       L__main20
	DECFSZ     R12+0, 1
	GOTO       L__main20
	DECFSZ     R11+0, 1
	GOTO       L__main20
;16F676MPPT.mpas,179 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,180 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,182 :: 		while True do begin
L__main22:
;16F676MPPT.mpas,184 :: 		wtmp := TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wtmp+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,185 :: 		if wtmp - prevtime > LED1_tm then begin
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
	GOTO       L__main66
	MOVF       R1+0, 0
	SUBWF      _LED1_tm+0, 0
L__main66:
	BTFSC      STATUS+0, 0
	GOTO       L__main27
;16F676MPPT.mpas,186 :: 		prevtime := wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _prevtime+0
	MOVF       _wtmp+1, 0
	MOVWF      _prevtime+1
;16F676MPPT.mpas,187 :: 		LED1 := not LED1;
	MOVLW
	XORWF      RC4_bit+0, 1
;16F676MPPT.mpas,188 :: 		end;
L__main27:
;16F676MPPT.mpas,191 :: 		vol_prev2:=vol_prev1;
	MOVF       _vol_prev1+0, 0
	MOVWF      _vol_prev2+0
	MOVF       _vol_prev1+1, 0
	MOVWF      _vol_prev2+1
;16F676MPPT.mpas,192 :: 		vol_prev1:=adc_vol;
	MOVF       _adc_vol+0, 0
	MOVWF      _vol_prev1+0
	MOVF       _adc_vol+1, 0
	MOVWF      _vol_prev1+1
;16F676MPPT.mpas,194 :: 		doADCRead:=0;
	CLRF       _doADCRead+0
;16F676MPPT.mpas,195 :: 		while doADCRead=0 do ;
L__main30:
	MOVF       _doADCRead+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main30
;16F676MPPT.mpas,198 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,199 :: 		adc_vol:=ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;16F676MPPT.mpas,200 :: 		for i:=0 to adc_max_loop-2 do begin
	CLRF       _i+0
L__main35:
;16F676MPPT.mpas,201 :: 		xtmp:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _xtmp+0
	MOVF       R0+1, 0
	MOVWF      _xtmp+1
;16F676MPPT.mpas,202 :: 		wtmp:=ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _wtmp+0
	MOVF       R0+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,203 :: 		adc_vol:=(adc_vol+wtmp) div 2;
	MOVF       R0+0, 0
	ADDWF      _adc_vol+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_vol+1, 1
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
;16F676MPPT.mpas,204 :: 		if xtmp > adc_cur then
	MOVF       _xtmp+1, 0
	SUBWF      _adc_cur+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVF       _xtmp+0, 0
	SUBWF      _adc_cur+0, 0
L__main67:
	BTFSC      STATUS+0, 0
	GOTO       L__main40
;16F676MPPT.mpas,205 :: 		adc_cur := xtmp;
	MOVF       _xtmp+0, 0
	MOVWF      _adc_cur+0
	MOVF       _xtmp+1, 0
	MOVWF      _adc_cur+1
L__main40:
;16F676MPPT.mpas,207 :: 		end;
	MOVF       _i+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__main38
	INCF       _i+0, 1
	GOTO       L__main35
L__main38:
;16F676MPPT.mpas,208 :: 		adc_vol:=adc_vol * VOLMUL;
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
;16F676MPPT.mpas,211 :: 		wtmp:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wtmp+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,212 :: 		if wtmp - powertime < _UPDATE_INT then
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
	GOTO       L__main68
	MOVLW      15
	SUBWF      R1+0, 0
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L__main43
;16F676MPPT.mpas,213 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
L__main43:
;16F676MPPT.mpas,214 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,215 :: 		powertime:=wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _powertime+0
	MOVF       _wtmp+1, 0
	MOVWF      _powertime+1
;16F676MPPT.mpas,217 :: 		power_prev:= power_curr;
	MOVF       _power_curr+0, 0
	MOVWF      _power_prev+0
	MOVF       _power_curr+1, 0
	MOVWF      _power_prev+1
	MOVF       _power_curr+2, 0
	MOVWF      _power_prev+2
	MOVF       _power_curr+3, 0
	MOVWF      _power_prev+3
;16F676MPPT.mpas,218 :: 		power_curr:= dword(adc_vol * adc_cur);
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
;16F676MPPT.mpas,232 :: 		if adc_cur>LM358_diff then begin
	MOVF       _adc_cur+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVF       _adc_cur+0, 0
	SUBWF      _LM358_diff+0, 0
L__main69:
	BTFSC      STATUS+0, 0
	GOTO       L__main46
;16F676MPPT.mpas,234 :: 		if power_curr = power_prev then begin
	MOVF       _power_curr+3, 0
	XORWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       _power_curr+2, 0
	XORWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       _power_curr+1, 0
	XORWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       _power_curr+0, 0
	XORWF      _power_prev+0, 0
L__main70:
	BTFSS      STATUS+0, 2
	GOTO       L__main49
;16F676MPPT.mpas,235 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,236 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,237 :: 		end else if power_curr <> power_prev then begin
L__main49:
	MOVF       _power_curr+3, 0
	XORWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVF       _power_curr+2, 0
	XORWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVF       _power_curr+1, 0
	XORWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVF       _power_curr+0, 0
	XORWF      _power_prev+0, 0
L__main71:
	BTFSC      STATUS+0, 2
	GOTO       L__main52
;16F676MPPT.mpas,238 :: 		LED1_tm:=150;
	MOVLW      150
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,239 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,240 :: 		end;
L__main52:
;16F676MPPT.mpas,246 :: 		end else begin
	GOTO       L__main47
L__main46:
;16F676MPPT.mpas,247 :: 		LED1_tm:=100;
	MOVLW      100
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,248 :: 		VOLPWM:=PWM_MIN;
	MOVLW      10
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,249 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,250 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,251 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,252 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,253 :: 		end;
L__main47:
;16F676MPPT.mpas,256 :: 		if flag_inc then begin
	MOVF       _flag_inc+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main55
;16F676MPPT.mpas,257 :: 		if VOLPWM<PWM_MAX then
	MOVLW      250
	SUBWF      _VOLPWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main58
;16F676MPPT.mpas,258 :: 		Inc(VOLPWM)
	INCF       _VOLPWM+0, 1
	GOTO       L__main59
;16F676MPPT.mpas,259 :: 		else begin
L__main58:
;16F676MPPT.mpas,260 :: 		VOLPWM:=PWM_MAX;
	MOVLW      250
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,261 :: 		flag_inc:=false;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,262 :: 		end;
L__main59:
;16F676MPPT.mpas,263 :: 		end else begin
	GOTO       L__main56
L__main55:
;16F676MPPT.mpas,264 :: 		if VOLPWM>PWM_MIN then
	MOVF       _VOLPWM+0, 0
	SUBLW      10
	BTFSC      STATUS+0, 0
	GOTO       L__main61
;16F676MPPT.mpas,265 :: 		Dec(VOLPWM)
	DECF       _VOLPWM+0, 1
	GOTO       L__main62
;16F676MPPT.mpas,266 :: 		else begin
L__main61:
;16F676MPPT.mpas,267 :: 		VOLPWM:=PWM_MIN;
	MOVLW      10
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,268 :: 		flag_inc:=true;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,269 :: 		end;
L__main62:
;16F676MPPT.mpas,270 :: 		end;
L__main56:
;16F676MPPT.mpas,271 :: 		CONTLOOP:
L__main_CONTLOOP:
;16F676MPPT.mpas,273 :: 		end;
	GOTO       L__main22
;16F676MPPT.mpas,274 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
