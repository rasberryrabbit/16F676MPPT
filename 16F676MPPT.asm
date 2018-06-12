
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;16F676MPPT.mpas,66 :: 		begin
;16F676MPPT.mpas,67 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;16F676MPPT.mpas,68 :: 		if PWM_FLAG=1 then begin
	BTFSS      _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
	GOTO       L__Interrupt5
;16F676MPPT.mpas,69 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;16F676MPPT.mpas,71 :: 		TMR0:=255-ON_PWM;
	MOVF       _VOL_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;16F676MPPT.mpas,72 :: 		PWM_SIG:=0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,73 :: 		PWM_FLAG:=0;
	BCF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,74 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;16F676MPPT.mpas,76 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;16F676MPPT.mpas,77 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,78 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,79 :: 		end;
L__Interrupt6:
;16F676MPPT.mpas,80 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;16F676MPPT.mpas,81 :: 		end;
L__Interrupt2:
;16F676MPPT.mpas,82 :: 		end;
L_end_Interrupt:
L__Interrupt82:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main:

;16F676MPPT.mpas,84 :: 		begin
;16F676MPPT.mpas,85 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;16F676MPPT.mpas,86 :: 		ANSEL:=%00000101;       // ADC conversion clock = fRC, RA0=Current, RA2=Voltage
	MOVLW      5
	MOVWF      ANSEL+0
;16F676MPPT.mpas,87 :: 		TRISA0_bit:=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;16F676MPPT.mpas,88 :: 		TRISA1_bit:=1;          // Vref
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;16F676MPPT.mpas,89 :: 		TRISA2_bit:=1;
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;16F676MPPT.mpas,90 :: 		VCFG_bit:=1;
	BSF        VCFG_bit+0, BitPos(VCFG_bit+0)
;16F676MPPT.mpas,91 :: 		CHS1_bit:=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;16F676MPPT.mpas,92 :: 		ADFM_bit:=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;16F676MPPT.mpas,94 :: 		TRISC1_bit:=0;          // PWM
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;16F676MPPT.mpas,95 :: 		TRISC4_bit:=0;          // LED
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;16F676MPPT.mpas,96 :: 		TRISC3_bit:=1;          // OP-AMP Cal
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;16F676MPPT.mpas,98 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,99 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,100 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,101 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,102 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;16F676MPPT.mpas,103 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;16F676MPPT.mpas,104 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;16F676MPPT.mpas,106 :: 		OPTION_REG:=%11011111;        // ~4KHz @ 4MHz, 1000000 / 4 = 3.9k
	MOVLW      223
	MOVWF      OPTION_REG+0
;16F676MPPT.mpas,107 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;16F676MPPT.mpas,109 :: 		LM358_diff:=cLM358_diff;
	MOVLW      4
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,110 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;16F676MPPT.mpas,112 :: 		if Write_OPAMP=0 then begin
	BTFSC      RC3_bit+0, BitPos(RC3_bit+0)
	GOTO       L__main9
;16F676MPPT.mpas,113 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,114 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,115 :: 		EEPROM_Write(0, Lo(adc_cur));
	CLRF       FARG_EEPROM_Write_address+0
	MOVF       _adc_cur+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;16F676MPPT.mpas,116 :: 		end;
L__main9:
;16F676MPPT.mpas,120 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,121 :: 		LM358_diff:=EEPROM_Read(0);
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,124 :: 		IncPWM_EQ:=0;
	CLRF       _IncPWM_EQ+0
;16F676MPPT.mpas,125 :: 		IncPWM_EQ:=EEPROM_Read(3);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _IncPWM_EQ+0
;16F676MPPT.mpas,128 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;16F676MPPT.mpas,132 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;16F676MPPT.mpas,133 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;16F676MPPT.mpas,134 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,136 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,137 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,138 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,139 :: 		vol1:=0;
	CLRF       _vol1+0
;16F676MPPT.mpas,140 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,141 :: 		Reset_Tick100:=100;
	MOVLW      100
	MOVWF      _Reset_Tick100+0
;16F676MPPT.mpas,142 :: 		Reset_Tick:=Reset_Tick_Start;
	MOVLW      220
	MOVWF      _Reset_Tick+0
	MOVLW      5
	MOVWF      _Reset_Tick+1
;16F676MPPT.mpas,144 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;16F676MPPT.mpas,146 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;16F676MPPT.mpas,148 :: 		VOL_PWM:=PWM_LOW;
	MOVLW      1
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,149 :: 		lo_PWM:=PWM_LOW;
	MOVLW      1
	MOVWF      _lo_PWM+0
;16F676MPPT.mpas,150 :: 		hi_PWM:=PWM_MAX;
	MOVLW      255
	MOVWF      _hi_PWM+0
;16F676MPPT.mpas,151 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,152 :: 		adc_prev:=0;
	CLRF       _adc_prev+0
	CLRF       _adc_prev+1
;16F676MPPT.mpas,154 :: 		while True do begin
L__main12:
;16F676MPPT.mpas,156 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__main17
;16F676MPPT.mpas,157 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,158 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;16F676MPPT.mpas,159 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,160 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;16F676MPPT.mpas,161 :: 		if TICK_1000>=LED1_tm then begin
	MOVF       _LED1_tm+0, 0
	SUBWF      _TICK_1000+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main20
;16F676MPPT.mpas,162 :: 		LED1:=not LED1;
	MOVLW
	XORWF      RC4_bit+0, 1
;16F676MPPT.mpas,163 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;16F676MPPT.mpas,164 :: 		end;
L__main20:
;16F676MPPT.mpas,187 :: 		end;
L__main17:
;16F676MPPT.mpas,188 :: 		if (VOL_PWM>=(PWM_MAX-1)) then
	MOVLW      254
	SUBWF      _VOL_PWM+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main23
;16F676MPPT.mpas,189 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main24
;16F676MPPT.mpas,190 :: 		else if (VOL_PWM<=lo_PWM) then
L__main23:
	MOVF       _VOL_PWM+0, 0
	SUBWF      _lo_PWM+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main26
;16F676MPPT.mpas,191 :: 		LED1_tm:=90
	MOVLW      90
	MOVWF      _LED1_tm+0
	GOTO       L__main27
;16F676MPPT.mpas,192 :: 		else
L__main26:
;16F676MPPT.mpas,193 :: 		LED1_tm:=120;
	MOVLW      120
	MOVWF      _LED1_tm+0
L__main27:
L__main24:
;16F676MPPT.mpas,195 :: 		power_prev:=power_curr;
	MOVF       _power_curr+0, 0
	MOVWF      _power_prev+0
	MOVF       _power_curr+1, 0
	MOVWF      _power_prev+1
	MOVF       _power_curr+2, 0
	MOVWF      _power_prev+2
	MOVF       _power_curr+3, 0
	MOVWF      _power_prev+3
;16F676MPPT.mpas,196 :: 		adc_prev:=adc_cur;
	MOVF       _adc_cur+0, 0
	MOVWF      _adc_prev+0
	MOVF       _adc_cur+1, 0
	MOVWF      _adc_prev+1
;16F676MPPT.mpas,198 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,199 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,200 :: 		for i:=0 to adc_max_loop-1 do begin
	CLRF       _i+0
L__main29:
;16F676MPPT.mpas,201 :: 		adc_cur:=adc_cur+ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      _adc_cur+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_cur+1, 1
;16F676MPPT.mpas,202 :: 		adc_vol:=adc_vol+ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      _adc_vol+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_vol+1, 1
;16F676MPPT.mpas,203 :: 		end;
	MOVF       _i+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main32
	INCF       _i+0, 1
	GOTO       L__main29
L__main32:
;16F676MPPT.mpas,204 :: 		adc_vol:=adc_vol div adc_max_loop;
;16F676MPPT.mpas,205 :: 		adc_cur:=adc_cur div adc_max_loop;
;16F676MPPT.mpas,207 :: 		if adc_cur>LM358_diff then
	MOVF       _adc_cur+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVF       _adc_cur+0, 0
	SUBWF      _LM358_diff+0, 0
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L__main34
;16F676MPPT.mpas,208 :: 		adc_cur:=adc_cur-LM358_diff
	MOVF       _LM358_diff+0, 0
	SUBWF      _adc_cur+0, 1
	BTFSS      STATUS+0, 0
	DECF       _adc_cur+1, 1
	GOTO       L__main35
;16F676MPPT.mpas,209 :: 		else
L__main34:
;16F676MPPT.mpas,210 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
L__main35:
;16F676MPPT.mpas,212 :: 		if (adc_cur>0) then begin
	MOVF       _adc_cur+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       _adc_cur+0, 0
	SUBLW      0
L__main85:
	BTFSC      STATUS+0, 0
	GOTO       L__main37
;16F676MPPT.mpas,213 :: 		if lo_PWM=0 then
	MOVF       _lo_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
;16F676MPPT.mpas,214 :: 		lo_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _lo_PWM+0
L__main40:
;16F676MPPT.mpas,215 :: 		power_curr:= adc_cur * adc_vol;
	MOVF       _adc_cur+0, 0
	MOVWF      R0+0
	MOVF       _adc_cur+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       _adc_vol+0, 0
	MOVWF      R4+0
	MOVF       _adc_vol+1, 0
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
;16F676MPPT.mpas,216 :: 		if power_curr=power_prev then begin
	MOVF       R0+3, 0
	XORWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVF       R0+2, 0
	XORWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVF       R0+1, 0
	XORWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVF       R0+0, 0
	XORWF      _power_prev+0, 0
L__main86:
	BTFSS      STATUS+0, 2
	GOTO       L__main43
;16F676MPPT.mpas,217 :: 		Inc_pwm:=0;
	CLRF       _Inc_pwm+0
;16F676MPPT.mpas,218 :: 		if adc_cur>adc_prev then begin
	MOVF       _adc_cur+1, 0
	SUBWF      _adc_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main87
	MOVF       _adc_cur+0, 0
	SUBWF      _adc_prev+0, 0
L__main87:
	BTFSC      STATUS+0, 0
	GOTO       L__main46
;16F676MPPT.mpas,219 :: 		flag_inc:=False;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,220 :: 		end else
	GOTO       L__main47
L__main46:
;16F676MPPT.mpas,221 :: 		if adc_cur<adc_prev then begin
	MOVF       _adc_prev+1, 0
	SUBWF      _adc_cur+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main88
	MOVF       _adc_prev+0, 0
	SUBWF      _adc_cur+0, 0
L__main88:
	BTFSC      STATUS+0, 0
	GOTO       L__main49
;16F676MPPT.mpas,222 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,223 :: 		end else begin
	GOTO       L__main50
L__main49:
;16F676MPPT.mpas,224 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,225 :: 		end;
L__main50:
L__main47:
;16F676MPPT.mpas,226 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,227 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,228 :: 		continue;
	GOTO       L__main12
;16F676MPPT.mpas,229 :: 		end else begin
L__main43:
;16F676MPPT.mpas,230 :: 		if Inc_pwm<Inc_Pwm_Max then
	MOVLW      8
	SUBWF      _Inc_pwm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main52
;16F676MPPT.mpas,231 :: 		Inc(Inc_pwm);
	INCF       _Inc_pwm+0, 1
L__main52:
;16F676MPPT.mpas,232 :: 		if power_curr<power_prev then begin
	MOVF       _power_prev+3, 0
	SUBWF      _power_curr+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main89
	MOVF       _power_prev+2, 0
	SUBWF      _power_curr+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main89
	MOVF       _power_prev+1, 0
	SUBWF      _power_curr+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main89
	MOVF       _power_prev+0, 0
	SUBWF      _power_curr+0, 0
L__main89:
	BTFSC      STATUS+0, 0
	GOTO       L__main55
;16F676MPPT.mpas,234 :: 		vol1:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _vol1+0
;16F676MPPT.mpas,235 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,237 :: 		if vol2<>0 then begin
	MOVF       _vol2+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main58
;16F676MPPT.mpas,238 :: 		Inc_pwm:=0;
	CLRF       _Inc_pwm+0
;16F676MPPT.mpas,239 :: 		wPWM:=vol1;
	MOVF       _vol1+0, 0
	MOVWF      _wPWM+0
	CLRF       _wPWM+1
;16F676MPPT.mpas,240 :: 		wPWM:=(wPWM+vol2+1) div 2+3; { >=3 }
	MOVF       _vol2+0, 0
	ADDWF      _wPWM+0, 1
	BTFSC      STATUS+0, 0
	INCF       _wPWM+1, 1
	INCF       _wPWM+0, 1
	BTFSC      STATUS+0, 2
	INCF       _wPWM+1, 1
	RRF        _wPWM+1, 1
	RRF        _wPWM+0, 1
	BCF        _wPWM+1, 7
	MOVLW      3
	ADDWF      _wPWM+0, 1
	BTFSC      STATUS+0, 0
	INCF       _wPWM+1, 1
;16F676MPPT.mpas,241 :: 		if (Hi(wPWM)<>0) or (Lo(wPWM)>PWM_MAX) then
	MOVF       _wPWM+1, 0
	XORLW      0
	MOVLW      255
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _wPWM+0, 0
	SUBLW      255
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main61
;16F676MPPT.mpas,242 :: 		wPWM:=word(PWM_MAX)
	MOVLW      255
	MOVWF      _wPWM+0
	MOVLW      0
	MOVWF      _wPWM+1
	GOTO       L__main62
;16F676MPPT.mpas,243 :: 		else if Lo(wPWM)<PWM_LOW then
L__main61:
	MOVLW      1
	SUBWF      _wPWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main64
;16F676MPPT.mpas,244 :: 		wPWM:=word(PWM_LOW);
	MOVLW      1
	MOVWF      _wPWM+0
	MOVLW      0
	MOVWF      _wPWM+1
L__main64:
L__main62:
;16F676MPPT.mpas,246 :: 		VOL_PWM:=lo(wPWM);
	MOVF       _wPWM+0, 0
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,248 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,250 :: 		wPWM:=(word(PWM_MAX-VOL_PWM)+((PWMHI_DIV+1) div 2)) div PWMHI_DIV;
	MOVF       _wPWM+0, 0
	SUBLW      255
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	MOVLW      3
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      6
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _wPWM+0
	MOVF       R0+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,251 :: 		wPWM:=wPWM+word(VOL_PWM);
	MOVF       _VOL_PWM+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      _wPWM+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,252 :: 		if (Hi(wPWM)<>0) or (Lo(wPWM)>PWM_MAX) then
	MOVF       _wPWM+1, 0
	XORLW      0
	MOVLW      255
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _wPWM+0, 0
	SUBLW      255
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main67
;16F676MPPT.mpas,253 :: 		wPWM:=PWM_MAX;
	MOVLW      255
	MOVWF      _wPWM+0
	CLRF       _wPWM+1
L__main67:
;16F676MPPT.mpas,254 :: 		hi_PWM:=lo(wPWM);
	MOVF       _wPWM+0, 0
	MOVWF      _hi_PWM+0
;16F676MPPT.mpas,256 :: 		wPWM:=(word(VOL_PWM-PWM_LOW)+((PWMLO_DIV+1) div 2)) div PWMLO_DIV;
	MOVLW      1
	SUBWF      _VOL_PWM+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	MOVLW      8
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      15
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _wPWM+0
	MOVF       R0+1, 0
	MOVWF      _wPWM+1
;16F676MPPT.mpas,257 :: 		wPWM:=word(VOL_PWM)-wPWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _wPWM+0
	CLRF       _wPWM+1
	MOVF       R0+0, 0
	SUBWF      _wPWM+0, 1
	BTFSS      STATUS+0, 0
	DECF       _wPWM+1, 1
	MOVF       R0+1, 0
	SUBWF      _wPWM+1, 1
;16F676MPPT.mpas,258 :: 		if (Hi(wPWM)<>0) or (Lo(wPWM)<PWM_LOW) then
	MOVF       _wPWM+1, 0
	XORLW      0
	MOVLW      255
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVLW      1
	SUBWF      _wPWM+0, 0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main70
;16F676MPPT.mpas,259 :: 		wPWM:=PWM_LOW;
	MOVLW      1
	MOVWF      _wPWM+0
	CLRF       _wPWM+1
L__main70:
;16F676MPPT.mpas,260 :: 		lo_PWM:=lo(wPWM);
	MOVF       _wPWM+0, 0
	MOVWF      _lo_PWM+0
;16F676MPPT.mpas,261 :: 		continue;
	GOTO       L__main12
;16F676MPPT.mpas,262 :: 		end;
L__main58:
;16F676MPPT.mpas,263 :: 		end else begin
	GOTO       L__main56
L__main55:
;16F676MPPT.mpas,265 :: 		vol2:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _vol2+0
;16F676MPPT.mpas,266 :: 		end;
L__main56:
;16F676MPPT.mpas,268 :: 		end else begin
	GOTO       L__main38
L__main37:
;16F676MPPT.mpas,270 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,271 :: 		Inc_pwm:=Inc_Pwm_Max;
	MOVLW      8
	MOVWF      _Inc_pwm+0
;16F676MPPT.mpas,272 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,273 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,274 :: 		lo_PWM:=0;
	CLRF       _lo_PWM+0
;16F676MPPT.mpas,275 :: 		hi_PWM:=PWM_MAX;
	MOVLW      255
	MOVWF      _hi_PWM+0
;16F676MPPT.mpas,276 :: 		end;
L__main38:
;16F676MPPT.mpas,278 :: 		if flag_inc then begin
	MOVF       _flag_inc+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main73
;16F676MPPT.mpas,279 :: 		if VOL_PWM<(hi_PWM-Inc_pwm) then begin
	MOVF       _Inc_pwm+0, 0
	SUBWF      _hi_PWM+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main76
;16F676MPPT.mpas,280 :: 		VOL_PWM:=VOL_PWM+Inc_pwm;
	MOVF       _Inc_pwm+0, 0
	ADDWF      _VOL_PWM+0, 1
;16F676MPPT.mpas,281 :: 		end else
	GOTO       L__main77
L__main76:
;16F676MPPT.mpas,282 :: 		VOL_PWM:=hi_PWM;
	MOVF       _hi_PWM+0, 0
	MOVWF      _VOL_PWM+0
L__main77:
;16F676MPPT.mpas,283 :: 		end else begin
	GOTO       L__main74
L__main73:
;16F676MPPT.mpas,284 :: 		if VOL_PWM>(lo_PWM+(Inc_Pwm_Max+1-Inc_pwm)) then begin
	MOVF       _Inc_pwm+0, 0
	SUBLW      9
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      _lo_PWM+0, 0
	MOVWF      R1+0
	MOVF       _VOL_PWM+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main79
;16F676MPPT.mpas,285 :: 		VOL_PWM:=VOL_PWM-(Inc_Pwm_Max+1-Inc_pwm);
	MOVF       _Inc_pwm+0, 0
	SUBLW      9
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      _VOL_PWM+0, 1
;16F676MPPT.mpas,286 :: 		end else
	GOTO       L__main80
L__main79:
;16F676MPPT.mpas,287 :: 		VOL_PWM:=lo_PWM;
	MOVF       _lo_PWM+0, 0
	MOVWF      _VOL_PWM+0
L__main80:
;16F676MPPT.mpas,288 :: 		end;
L__main74:
;16F676MPPT.mpas,289 :: 		end;
	GOTO       L__main12
;16F676MPPT.mpas,290 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
