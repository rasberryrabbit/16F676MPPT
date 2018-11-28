
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;16F676MPPT.mpas,65 :: 		begin
;16F676MPPT.mpas,66 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt3
;16F676MPPT.mpas,67 :: 		PWM_SIG:=not PWM_SIG;
	MOVLW
	XORWF      RC1_bit+0, 1
;16F676MPPT.mpas,68 :: 		if PWM_SIG=0 then begin
	BTFSC      RC1_bit+0, BitPos(RC1_bit+0)
	GOTO       L__Interrupt6
;16F676MPPT.mpas,70 :: 		ON_PWM:=VOLPWM;
	MOVF       _VOLPWM+0, 0
	MOVWF      _ON_PWM+0
;16F676MPPT.mpas,71 :: 		TMR0:=255-ON_PWM;
	MOVF       _VOLPWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;16F676MPPT.mpas,72 :: 		end else begin
	GOTO       L__Interrupt7
L__Interrupt6:
;16F676MPPT.mpas,74 :: 		doADCRead:=1;
	MOVLW      1
	MOVWF      _doADCRead+0
;16F676MPPT.mpas,75 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	ADDLW      5
	MOVWF      TMR0+0
;16F676MPPT.mpas,76 :: 		end;
L__Interrupt7:
;16F676MPPT.mpas,77 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;16F676MPPT.mpas,78 :: 		end;
L__Interrupt3:
;16F676MPPT.mpas,79 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt9
;16F676MPPT.mpas,80 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      248
	MOVWF      TMR1H+0
;16F676MPPT.mpas,81 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      48
	MOVWF      TMR1L+0
;16F676MPPT.mpas,82 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,83 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
	BTFSC      STATUS+0, 2
	INCF       _TICK_1000+1, 1
;16F676MPPT.mpas,84 :: 		end;
L__Interrupt9:
;16F676MPPT.mpas,85 :: 		end;
L_end_Interrupt:
L__Interrupt65:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main:

;16F676MPPT.mpas,87 :: 		begin
;16F676MPPT.mpas,88 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;16F676MPPT.mpas,89 :: 		ANSEL:=%00000101;       // ADC conversion clock = fRC, RA0=Current, RA2=Voltage
	MOVLW      5
	MOVWF      ANSEL+0
;16F676MPPT.mpas,90 :: 		TRISA0_bit:=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;16F676MPPT.mpas,91 :: 		TRISA1_bit:=1;          // Vref
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;16F676MPPT.mpas,92 :: 		TRISA2_bit:=1;
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;16F676MPPT.mpas,93 :: 		VCFG_bit:=1;
	BSF        VCFG_bit+0, BitPos(VCFG_bit+0)
;16F676MPPT.mpas,94 :: 		CHS1_bit:=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;16F676MPPT.mpas,95 :: 		ADFM_bit:=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;16F676MPPT.mpas,97 :: 		TRISC1_bit:=0;          // PWM
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;16F676MPPT.mpas,98 :: 		TRISC4_bit:=0;          // LED
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;16F676MPPT.mpas,99 :: 		TRISC3_bit:=1;          // OP-AMP Cal
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;16F676MPPT.mpas,101 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,102 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,103 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,104 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;16F676MPPT.mpas,105 :: 		VOLPWM:=0;
	CLRF       _VOLPWM+0
;16F676MPPT.mpas,106 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
	CLRF       _TICK_1000+1
;16F676MPPT.mpas,108 :: 		OPTION_REG:=%11011111;        // ~4KHz @ 4MHz, 1000000 / 4 = 3.9k
	MOVLW      223
	MOVWF      OPTION_REG+0
;16F676MPPT.mpas,109 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;16F676MPPT.mpas,111 :: 		LM358_diff:=cLM358_diff;
	CLRF       _LM358_diff+0
;16F676MPPT.mpas,112 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,113 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,114 :: 		ClrWDT;
	CLRWDT
;16F676MPPT.mpas,116 :: 		if Write_OPAMP=0 then begin
	BTFSC      RC3_bit+0, BitPos(RC3_bit+0)
	GOTO       L__main13
;16F676MPPT.mpas,117 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,118 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,119 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,120 :: 		EEPROM_Write(0, Lo(adc_cur));
	CLRF       FARG_EEPROM_Write_address+0
	MOVF       _adc_cur+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;16F676MPPT.mpas,121 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,122 :: 		LED1:=1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,123 :: 		Delay_ms(700);
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
;16F676MPPT.mpas,124 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,125 :: 		end;
L__main13:
;16F676MPPT.mpas,126 :: 		ClrWDT;
	CLRWDT
;16F676MPPT.mpas,130 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,131 :: 		LM358_diff:=EEPROM_Read(0);
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,133 :: 		if LM358_diff>$1f then
	MOVF       R0+0, 0
	SUBLW      31
	BTFSC      STATUS+0, 0
	GOTO       L__main17
;16F676MPPT.mpas,134 :: 		LM358_diff:=0;
	CLRF       _LM358_diff+0
L__main17:
;16F676MPPT.mpas,136 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;16F676MPPT.mpas,141 :: 		T1CKPS1_bit:=0;
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;16F676MPPT.mpas,142 :: 		T1CKPS0_bit:=0;               // timer prescaler 1:1
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;16F676MPPT.mpas,144 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      48
	MOVWF      TMR1L+0
;16F676MPPT.mpas,145 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      248
	MOVWF      TMR1H+0
;16F676MPPT.mpas,146 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,148 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,149 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,150 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,152 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;16F676MPPT.mpas,153 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;16F676MPPT.mpas,155 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;16F676MPPT.mpas,157 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;16F676MPPT.mpas,159 :: 		VOLPWM:=PWM_MID;
	MOVLW      125
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,160 :: 		flag_inc:=False;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,161 :: 		vol_prev1:=0;
	CLRF       _vol_prev1+0
	CLRF       _vol_prev1+1
;16F676MPPT.mpas,163 :: 		powertime:=0;
	CLRF       _powertime+0
	CLRF       _powertime+1
;16F676MPPT.mpas,164 :: 		prevtime:=0;
	CLRF       _prevtime+0
	CLRF       _prevtime+1
;16F676MPPT.mpas,165 :: 		voltime:=0;
	CLRF       _voltime+0
	CLRF       _voltime+1
;16F676MPPT.mpas,167 :: 		volbuf[0]:=0;
	CLRF       _volbuf+0
	CLRF       _volbuf+1
;16F676MPPT.mpas,168 :: 		volbuf[1]:=0;
	CLRF       _volbuf+2
	CLRF       _volbuf+3
;16F676MPPT.mpas,169 :: 		curbuf[0]:=0;
	CLRF       _curbuf+0
	CLRF       _curbuf+1
;16F676MPPT.mpas,170 :: 		curbuf[1]:=0;
	CLRF       _curbuf+2
	CLRF       _curbuf+3
;16F676MPPT.mpas,171 :: 		idx:=0;
	CLRF       _idx+0
;16F676MPPT.mpas,173 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,174 :: 		delay_ms(300);
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
;16F676MPPT.mpas,175 :: 		LED1:=1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,176 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L__main20:
	DECFSZ     R13+0, 1
	GOTO       L__main20
	DECFSZ     R12+0, 1
	GOTO       L__main20
	DECFSZ     R11+0, 1
	GOTO       L__main20
	NOP
	NOP
;16F676MPPT.mpas,177 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,178 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,180 :: 		while True do begin
L__main22:
;16F676MPPT.mpas,182 :: 		wtmp := TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wtmp+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,183 :: 		if wtmp - prevtime > LED1_tm then begin
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
	GOTO       L__main67
	MOVF       R1+0, 0
	SUBWF      _LED1_tm+0, 0
L__main67:
	BTFSC      STATUS+0, 0
	GOTO       L__main27
;16F676MPPT.mpas,184 :: 		prevtime := wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _prevtime+0
	MOVF       _wtmp+1, 0
	MOVWF      _prevtime+1
;16F676MPPT.mpas,185 :: 		LED1 := not LED1;
	MOVLW
	XORWF      RC4_bit+0, 1
;16F676MPPT.mpas,186 :: 		end;
L__main27:
;16F676MPPT.mpas,189 :: 		vol_prev2:=vol_prev1;
	MOVF       _vol_prev1+0, 0
	MOVWF      _vol_prev2+0
	MOVF       _vol_prev1+1, 0
	MOVWF      _vol_prev2+1
;16F676MPPT.mpas,190 :: 		vol_prev1:=adc_vol;
	MOVF       _adc_vol+0, 0
	MOVWF      _vol_prev1+0
	MOVF       _adc_vol+1, 0
	MOVWF      _vol_prev1+1
;16F676MPPT.mpas,192 :: 		doADCRead:=0;
	CLRF       _doADCRead+0
;16F676MPPT.mpas,193 :: 		while doADCRead=0 do ;
L__main30:
	MOVF       _doADCRead+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main30
;16F676MPPT.mpas,195 :: 		volbuf[idx]:=ADC_Read(2);
	MOVF       _idx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _volbuf+0
	MOVWF      FLOC__main+0
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;16F676MPPT.mpas,196 :: 		curbuf[idx]:=ADC_Read(0);
	MOVF       _idx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _curbuf+0
	MOVWF      FLOC__main+0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;16F676MPPT.mpas,197 :: 		idx:=1-idx;
	MOVF       _idx+0, 0
	SUBLW      1
	MOVWF      _idx+0
;16F676MPPT.mpas,198 :: 		adc_cur:=(curbuf[0]+curbuf[1]+1) div 2;
	MOVF       _curbuf+2, 0
	ADDWF      _curbuf+0, 0
	MOVWF      _adc_cur+0
	MOVF       _curbuf+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _curbuf+3, 0
	MOVWF      _adc_cur+1
	INCF       _adc_cur+0, 1
	BTFSC      STATUS+0, 2
	INCF       _adc_cur+1, 1
	RRF        _adc_cur+1, 1
	RRF        _adc_cur+0, 1
	BCF        _adc_cur+1, 7
;16F676MPPT.mpas,199 :: 		adc_vol:=(volbuf[0]+volbuf[1]+1) div 2;
	MOVF       _volbuf+2, 0
	ADDWF      _volbuf+0, 0
	MOVWF      _adc_vol+0
	MOVF       _volbuf+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _volbuf+3, 0
	MOVWF      _adc_vol+1
	INCF       _adc_vol+0, 1
	BTFSC      STATUS+0, 2
	INCF       _adc_vol+1, 1
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
;16F676MPPT.mpas,200 :: 		adc_vol:=adc_vol * VOLMUL;
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
;16F676MPPT.mpas,203 :: 		wtmp:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wtmp+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,204 :: 		if wtmp - powertime < _UPDATE_INT then
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
	MOVLW      45
	SUBWF      R1+0, 0
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L__main35
;16F676MPPT.mpas,205 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
L__main35:
;16F676MPPT.mpas,206 :: 		clrwdt;
	CLRWDT
;16F676MPPT.mpas,207 :: 		powertime:=wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _powertime+0
	MOVF       _wtmp+1, 0
	MOVWF      _powertime+1
;16F676MPPT.mpas,209 :: 		power_prev:= power_curr;
	MOVF       _power_curr+0, 0
	MOVWF      _power_prev+0
	MOVF       _power_curr+1, 0
	MOVWF      _power_prev+1
	MOVF       _power_curr+2, 0
	MOVWF      _power_prev+2
	MOVF       _power_curr+3, 0
	MOVWF      _power_prev+3
;16F676MPPT.mpas,210 :: 		power_curr:= adc_vol * adc_cur;
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
;16F676MPPT.mpas,213 :: 		wtmp:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _wtmp+0
	MOVF       _TICK_1000+1, 0
	MOVWF      _wtmp+1
;16F676MPPT.mpas,214 :: 		if ON_PWM>PWM_MID then begin
	MOVF       _ON_PWM+0, 0
	SUBLW      125
	BTFSC      STATUS+0, 0
	GOTO       L__main38
;16F676MPPT.mpas,215 :: 		if wtmp - voltime > _PWM_CHECK then begin
	MOVF       _voltime+0, 0
	SUBWF      _wtmp+0, 0
	MOVWF      R1+0
	MOVF       _voltime+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _wtmp+1, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBLW      8
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVF       R1+0, 0
	SUBLW      202
L__main69:
	BTFSC      STATUS+0, 0
	GOTO       L__main41
;16F676MPPT.mpas,216 :: 		voltime:=wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _voltime+0
	MOVF       _wtmp+1, 0
	MOVWF      _voltime+1
;16F676MPPT.mpas,217 :: 		adc_cur:=LM358_diff;
	MOVF       _LM358_diff+0, 0
	MOVWF      _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,218 :: 		end;
L__main41:
;16F676MPPT.mpas,219 :: 		end else
	GOTO       L__main39
L__main38:
;16F676MPPT.mpas,220 :: 		voltime:=wtmp;
	MOVF       _wtmp+0, 0
	MOVWF      _voltime+0
	MOVF       _wtmp+1, 0
	MOVWF      _voltime+1
L__main39:
;16F676MPPT.mpas,222 :: 		if adc_cur>LM358_diff then begin
	MOVF       _adc_cur+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       _adc_cur+0, 0
	SUBWF      _LM358_diff+0, 0
L__main70:
	BTFSC      STATUS+0, 0
	GOTO       L__main44
;16F676MPPT.mpas,224 :: 		if power_curr = power_prev then begin
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
	BTFSS      STATUS+0, 2
	GOTO       L__main47
;16F676MPPT.mpas,225 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,226 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,227 :: 		end else if power_curr > power_prev then begin
L__main47:
	MOVF       _power_curr+3, 0
	SUBWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVF       _power_curr+2, 0
	SUBWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVF       _power_curr+1, 0
	SUBWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVF       _power_curr+0, 0
	SUBWF      _power_prev+0, 0
L__main72:
	BTFSC      STATUS+0, 0
	GOTO       L__main50
;16F676MPPT.mpas,228 :: 		LED1_tm:=200;
	MOVLW      200
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,229 :: 		end else begin
	GOTO       L__main51
L__main50:
;16F676MPPT.mpas,230 :: 		LED1_tm:=150;
	MOVLW      150
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,231 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,232 :: 		end;
L__main51:
;16F676MPPT.mpas,233 :: 		if (adc_vol+vol_prev2+1) div 2 < vol_prev1 then begin
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
	GOTO       L__main73
	MOVF       _vol_prev1+0, 0
	SUBWF      R1+0, 0
L__main73:
	BTFSC      STATUS+0, 0
	GOTO       L__main53
;16F676MPPT.mpas,234 :: 		flag_inc:=true;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,235 :: 		end;
L__main53:
;16F676MPPT.mpas,236 :: 		end else begin
	GOTO       L__main45
L__main44:
;16F676MPPT.mpas,237 :: 		LED1_tm:=100;
	MOVLW      100
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,238 :: 		VOLPWM:=PWM_MID;
	MOVLW      125
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,239 :: 		flag_inc:=false;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,240 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,241 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,242 :: 		goto CONTLOOP;
	GOTO       L__main_CONTLOOP
;16F676MPPT.mpas,243 :: 		end;
L__main45:
;16F676MPPT.mpas,246 :: 		if flag_inc then begin
	MOVF       _flag_inc+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main56
;16F676MPPT.mpas,247 :: 		if VOLPWM<PWM_MAX then
	MOVLW      250
	SUBWF      _VOLPWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main59
;16F676MPPT.mpas,248 :: 		Inc(VOLPWM)
	INCF       _VOLPWM+0, 1
	GOTO       L__main60
;16F676MPPT.mpas,249 :: 		else begin
L__main59:
;16F676MPPT.mpas,250 :: 		VOLPWM:=PWM_MAX;
	MOVLW      250
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,251 :: 		flag_inc:=false;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,252 :: 		end;
L__main60:
;16F676MPPT.mpas,253 :: 		end else begin
	GOTO       L__main57
L__main56:
;16F676MPPT.mpas,254 :: 		if VOLPWM>PWM_MIN then
	MOVF       _VOLPWM+0, 0
	SUBLW      1
	BTFSC      STATUS+0, 0
	GOTO       L__main62
;16F676MPPT.mpas,255 :: 		Dec(VOLPWM)
	DECF       _VOLPWM+0, 1
	GOTO       L__main63
;16F676MPPT.mpas,256 :: 		else begin
L__main62:
;16F676MPPT.mpas,257 :: 		VOLPWM:=PWM_MIN;
	MOVLW      1
	MOVWF      _VOLPWM+0
;16F676MPPT.mpas,258 :: 		flag_inc:=true;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,259 :: 		end;
L__main63:
;16F676MPPT.mpas,260 :: 		end;
L__main57:
;16F676MPPT.mpas,261 :: 		CONTLOOP:
L__main_CONTLOOP:
;16F676MPPT.mpas,263 :: 		end;
	GOTO       L__main22
;16F676MPPT.mpas,264 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
