
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
	GOTO       L__Interrupt2
;16F676MPPT.mpas,74 :: 		if PWM_FLAG=1 then begin
	BTFSS      _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
	GOTO       L__Interrupt5
;16F676MPPT.mpas,75 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;16F676MPPT.mpas,77 :: 		TMR0:=255-ON_PWM;
	MOVF       _VOL_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;16F676MPPT.mpas,78 :: 		PWM_SIG:=0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,79 :: 		PWM_FLAG:=0;
	BCF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,80 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;16F676MPPT.mpas,82 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;16F676MPPT.mpas,83 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,84 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,85 :: 		end;
L__Interrupt6:
;16F676MPPT.mpas,86 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;16F676MPPT.mpas,87 :: 		end;
L__Interrupt2:
;16F676MPPT.mpas,88 :: 		end;
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

;16F676MPPT.mpas,90 :: 		begin
;16F676MPPT.mpas,91 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;16F676MPPT.mpas,92 :: 		ANSEL:=%00000101;       // ADC conversion clock = fRC, RA0=Current, RA2=Voltage
	MOVLW      5
	MOVWF      ANSEL+0
;16F676MPPT.mpas,93 :: 		TRISA0_bit:=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;16F676MPPT.mpas,94 :: 		TRISA1_bit:=1;          // Vref
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;16F676MPPT.mpas,95 :: 		TRISA2_bit:=1;
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;16F676MPPT.mpas,96 :: 		VCFG_bit:=1;
	BSF        VCFG_bit+0, BitPos(VCFG_bit+0)
;16F676MPPT.mpas,97 :: 		CHS1_bit:=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;16F676MPPT.mpas,98 :: 		ADFM_bit:=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;16F676MPPT.mpas,100 :: 		TRISC1_bit:=0;          // PWM
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;16F676MPPT.mpas,101 :: 		TRISC4_bit:=0;          // LED
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;16F676MPPT.mpas,102 :: 		TRISC3_bit:=1;          // OP-AMP Cal
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;16F676MPPT.mpas,104 :: 		LED1:=0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;16F676MPPT.mpas,105 :: 		PWM_SIG:=1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;16F676MPPT.mpas,106 :: 		PWM_FLAG:=1;
	BSF        _PWM_FLAG+0, BitPos(_PWM_FLAG+0)
;16F676MPPT.mpas,107 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,108 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;16F676MPPT.mpas,109 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;16F676MPPT.mpas,110 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;16F676MPPT.mpas,112 :: 		OPTION_REG:=%11011111;        // ~4KHz @ 4MHz, 1000000 / 4 = 3.9k
	MOVLW      223
	MOVWF      OPTION_REG+0
;16F676MPPT.mpas,113 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;16F676MPPT.mpas,115 :: 		LM358_diff:=cLM358_diff;
	MOVLW      4
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,116 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;16F676MPPT.mpas,118 :: 		if Write_OPAMP=0 then begin
	BTFSC      RC3_bit+0, BitPos(RC3_bit+0)
	GOTO       L__main9
;16F676MPPT.mpas,119 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,120 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,121 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,122 :: 		adc_cur:=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_cur+0
	MOVF       R0+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,123 :: 		EEPROM_Write(0, Lo(adc_cur));
	CLRF       FARG_EEPROM_Write_address+0
	MOVF       _adc_cur+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;16F676MPPT.mpas,124 :: 		end;
L__main9:
;16F676MPPT.mpas,128 :: 		Delay_100ms;
	CALL       _Delay_100ms+0
;16F676MPPT.mpas,129 :: 		LM358_diff:=EEPROM_Read(0);
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,131 :: 		Inc(LM358_diff);
	INCF       R0+0, 0
	MOVWF      _LM358_diff+0
;16F676MPPT.mpas,134 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;16F676MPPT.mpas,138 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;16F676MPPT.mpas,139 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;16F676MPPT.mpas,140 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,142 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,143 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,144 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,145 :: 		vol1:=0;
	CLRF       _vol1+0
;16F676MPPT.mpas,146 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,147 :: 		Reset_Tick100:=100;
	MOVLW      100
	MOVWF      _Reset_Tick100+0
;16F676MPPT.mpas,148 :: 		Reset_Tick:=Reset_Tick_Start;
	MOVLW      220
	MOVWF      _Reset_Tick+0
	MOVLW      5
	MOVWF      _Reset_Tick+1
;16F676MPPT.mpas,150 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;16F676MPPT.mpas,152 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;16F676MPPT.mpas,154 :: 		VOL_PWM:=PWM_MIN;
	MOVLW      2
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,155 :: 		lo_PWM:=PWM_MIN;
	MOVLW      2
	MOVWF      _lo_PWM+0
;16F676MPPT.mpas,156 :: 		hi_PWM:=PWM_MAX;
	MOVLW      255
	MOVWF      _hi_PWM+0
;16F676MPPT.mpas,157 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,158 :: 		p_equal:=False;
	CLRF       _p_equal+0
;16F676MPPT.mpas,159 :: 		cur_prev:=0;
	CLRF       _cur_prev+0
	CLRF       _cur_prev+1
;16F676MPPT.mpas,160 :: 		vol_prev:=0;
	CLRF       _vol_prev+0
	CLRF       _vol_prev+1
;16F676MPPT.mpas,163 :: 		while True do begin
L__main12:
;16F676MPPT.mpas,165 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__main17
;16F676MPPT.mpas,166 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;16F676MPPT.mpas,167 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;16F676MPPT.mpas,168 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;16F676MPPT.mpas,169 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;16F676MPPT.mpas,170 :: 		if TICK_1000>=LED1_tm then begin
	MOVF       _LED1_tm+0, 0
	SUBWF      _TICK_1000+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main20
;16F676MPPT.mpas,171 :: 		LED1:=not LED1;
	MOVLW
	XORWF      RC4_bit+0, 1
;16F676MPPT.mpas,172 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;16F676MPPT.mpas,173 :: 		end;
L__main20:
;16F676MPPT.mpas,196 :: 		end;
L__main17:
;16F676MPPT.mpas,197 :: 		if (VOL_PWM>=(PWM_MAX-1)) then
	MOVLW      254
	SUBWF      _VOL_PWM+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main23
;16F676MPPT.mpas,198 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main24
;16F676MPPT.mpas,199 :: 		else if (VOL_PWM<=lo_PWM) then
L__main23:
	MOVF       _VOL_PWM+0, 0
	SUBWF      _lo_PWM+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main26
;16F676MPPT.mpas,200 :: 		LED1_tm:=90
	MOVLW      90
	MOVWF      _LED1_tm+0
	GOTO       L__main27
;16F676MPPT.mpas,201 :: 		else
L__main26:
;16F676MPPT.mpas,202 :: 		LED1_tm:=120;
	MOVLW      120
	MOVWF      _LED1_tm+0
L__main27:
L__main24:
;16F676MPPT.mpas,204 :: 		power_prev:=power_curr;
	MOVF       _power_curr+0, 0
	MOVWF      _power_prev+0
	MOVF       _power_curr+1, 0
	MOVWF      _power_prev+1
	MOVF       _power_curr+2, 0
	MOVWF      _power_prev+2
	MOVF       _power_curr+3, 0
	MOVWF      _power_prev+3
;16F676MPPT.mpas,205 :: 		cur_prev:=adc_cur;
	MOVF       _adc_cur+0, 0
	MOVWF      _cur_prev+0
	MOVF       _adc_cur+1, 0
	MOVWF      _cur_prev+1
;16F676MPPT.mpas,206 :: 		vol_prev:=adc_vol;
	MOVF       _adc_vol+0, 0
	MOVWF      _vol_prev+0
	MOVF       _adc_vol+1, 0
	MOVWF      _vol_prev+1
;16F676MPPT.mpas,208 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,209 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,210 :: 		for i:=0 to adc_max_loop-1 do begin
	CLRF       _i+0
L__main29:
;16F676MPPT.mpas,211 :: 		adc_cur:=adc_cur+ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      _adc_cur+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_cur+1, 1
;16F676MPPT.mpas,212 :: 		adc_vol:=adc_vol+ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	ADDWF      _adc_vol+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _adc_vol+1, 1
;16F676MPPT.mpas,213 :: 		end;
	MOVF       _i+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__main32
	INCF       _i+0, 1
	GOTO       L__main29
L__main32:
;16F676MPPT.mpas,214 :: 		adc_vol:=adc_vol div adc_max_loop;
	RRF        _adc_vol+1, 1
	RRF        _adc_vol+0, 1
	BCF        _adc_vol+1, 7
;16F676MPPT.mpas,215 :: 		adc_cur:=adc_cur div adc_max_loop;
	MOVF       _adc_cur+0, 0
	MOVWF      R1+0
	MOVF       _adc_cur+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	MOVF       R1+0, 0
	MOVWF      _adc_cur+0
	MOVF       R1+1, 0
	MOVWF      _adc_cur+1
;16F676MPPT.mpas,217 :: 		adc_vol:=adc_vol * VOLMUL;
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
	RLF        _adc_vol+0, 1
	RLF        _adc_vol+1, 1
	BCF        _adc_vol+0, 0
;16F676MPPT.mpas,219 :: 		if adc_cur>LM358_diff then begin
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVF       R1+0, 0
	SUBWF      _LM358_diff+0, 0
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L__main34
;16F676MPPT.mpas,220 :: 		power_curr:= adc_cur * adc_vol;
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
;16F676MPPT.mpas,221 :: 		if power_curr=power_prev then begin
	MOVF       R0+3, 0
	XORWF      _power_prev+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       R0+2, 0
	XORWF      _power_prev+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       R0+1, 0
	XORWF      _power_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       R0+0, 0
	XORWF      _power_prev+0, 0
L__main85:
	BTFSS      STATUS+0, 2
	GOTO       L__main37
;16F676MPPT.mpas,222 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;16F676MPPT.mpas,223 :: 		vol2:=0;
	CLRF       _vol2+0
;16F676MPPT.mpas,224 :: 		Inc_pwm:=1;
	MOVLW      1
	MOVWF      _Inc_pwm+0
;16F676MPPT.mpas,226 :: 		if (not p_equal) or (adc_cur=cur_prev) then begin
	COMF       _p_equal+0, 0
	MOVWF      R1+0
	MOVF       _adc_cur+1, 0
	XORWF      _cur_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVF       _cur_prev+0, 0
	XORWF      _adc_cur+0, 0
L__main86:
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main40
;16F676MPPT.mpas,227 :: 		if adc_vol<vol_prev then
	MOVF       _vol_prev+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main87
	MOVF       _vol_prev+0, 0
	SUBWF      _adc_vol+0, 0
L__main87:
	BTFSC      STATUS+0, 0
	GOTO       L__main43
;16F676MPPT.mpas,228 :: 		flag_inc:=True
	MOVLW      255
	MOVWF      _flag_inc+0
	GOTO       L__main44
;16F676MPPT.mpas,229 :: 		else if adc_vol>vol_prev then
L__main43:
	MOVF       _adc_vol+1, 0
	SUBWF      _vol_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main88
	MOVF       _adc_vol+0, 0
	SUBWF      _vol_prev+0, 0
L__main88:
	BTFSC      STATUS+0, 0
	GOTO       L__main46
;16F676MPPT.mpas,230 :: 		flag_inc:=False
	CLRF       _flag_inc+0
	GOTO       L__main47
;16F676MPPT.mpas,231 :: 		else if adc_cur=cur_prev then begin
L__main46:
	MOVF       _adc_cur+1, 0
	XORWF      _cur_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main89
	MOVF       _cur_prev+0, 0
	XORWF      _adc_cur+0, 0
L__main89:
	BTFSS      STATUS+0, 2
	GOTO       L__main49
;16F676MPPT.mpas,232 :: 		p_equal:=True;
	MOVLW      255
	MOVWF      _p_equal+0
;16F676MPPT.mpas,233 :: 		continue;
	GOTO       L__main12
;16F676MPPT.mpas,234 :: 		end;
L__main49:
L__main47:
L__main44:
;16F676MPPT.mpas,235 :: 		if p_equal and (adc_cur=cur_prev) then
	MOVF       _adc_cur+1, 0
	XORWF      _cur_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main90
	MOVF       _cur_prev+0, 0
	XORWF      _adc_cur+0, 0
L__main90:
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       _p_equal+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main52
;16F676MPPT.mpas,236 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
L__main52:
;16F676MPPT.mpas,237 :: 		end;
L__main40:
;16F676MPPT.mpas,239 :: 		if p_equal or (adc_vol=vol_prev) then begin
	MOVF       _adc_vol+1, 0
	XORWF      _vol_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main91
	MOVF       _vol_prev+0, 0
	XORWF      _adc_vol+0, 0
L__main91:
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       _p_equal+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main55
;16F676MPPT.mpas,240 :: 		if adc_cur<cur_prev then
	MOVF       _cur_prev+1, 0
	SUBWF      _adc_cur+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main92
	MOVF       _cur_prev+0, 0
	SUBWF      _adc_cur+0, 0
L__main92:
	BTFSC      STATUS+0, 0
	GOTO       L__main58
;16F676MPPT.mpas,241 :: 		flag_inc:=False
	CLRF       _flag_inc+0
	GOTO       L__main59
;16F676MPPT.mpas,242 :: 		else if adc_cur>cur_prev then
L__main58:
	MOVF       _adc_cur+1, 0
	SUBWF      _cur_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main93
	MOVF       _adc_cur+0, 0
	SUBWF      _cur_prev+0, 0
L__main93:
	BTFSC      STATUS+0, 0
	GOTO       L__main61
;16F676MPPT.mpas,243 :: 		flag_inc:=True
	MOVLW      255
	MOVWF      _flag_inc+0
	GOTO       L__main62
;16F676MPPT.mpas,244 :: 		else if adc_vol=vol_prev then begin
L__main61:
	MOVF       _adc_vol+1, 0
	XORWF      _vol_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main94
	MOVF       _vol_prev+0, 0
	XORWF      _adc_vol+0, 0
L__main94:
	BTFSS      STATUS+0, 2
	GOTO       L__main64
;16F676MPPT.mpas,245 :: 		p_equal:=True;
	MOVLW      255
	MOVWF      _p_equal+0
;16F676MPPT.mpas,246 :: 		continue;
	GOTO       L__main12
;16F676MPPT.mpas,247 :: 		end;
L__main64:
L__main62:
L__main59:
;16F676MPPT.mpas,248 :: 		if (not p_equal) and (adc_vol=vol_prev) then
	COMF       _p_equal+0, 0
	MOVWF      R1+0
	MOVF       _adc_vol+1, 0
	XORWF      _vol_prev+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main95
	MOVF       _vol_prev+0, 0
	XORWF      _adc_vol+0, 0
L__main95:
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main67
;16F676MPPT.mpas,249 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
L__main67:
;16F676MPPT.mpas,250 :: 		end;
L__main55:
;16F676MPPT.mpas,251 :: 		p_equal:=True;
	MOVLW      255
	MOVWF      _p_equal+0
;16F676MPPT.mpas,252 :: 		end else begin
	GOTO       L__main38
L__main37:
;16F676MPPT.mpas,253 :: 		p_equal:=False;
	CLRF       _p_equal+0
;16F676MPPT.mpas,258 :: 		if power_curr<power_prev then begin
	MOVF       _power_prev+3, 0
	SUBWF      _power_curr+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVF       _power_prev+2, 0
	SUBWF      _power_curr+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVF       _power_prev+1, 0
	SUBWF      _power_curr+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVF       _power_prev+0, 0
	SUBWF      _power_curr+0, 0
L__main96:
	BTFSC      STATUS+0, 0
	GOTO       L__main70
;16F676MPPT.mpas,259 :: 		flag_inc:=not flag_inc;
	COMF       _flag_inc+0, 1
;16F676MPPT.mpas,291 :: 		end else begin
	GOTO       L__main71
L__main70:
;16F676MPPT.mpas,293 :: 		vol2:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _vol2+0
;16F676MPPT.mpas,294 :: 		end;
L__main71:
;16F676MPPT.mpas,295 :: 		end;
L__main38:
;16F676MPPT.mpas,296 :: 		end else begin
	GOTO       L__main35
L__main34:
;16F676MPPT.mpas,298 :: 		power_curr:=0;
	CLRF       _power_curr+0
	CLRF       _power_curr+1
	CLRF       _power_curr+2
	CLRF       _power_curr+3
;16F676MPPT.mpas,299 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,300 :: 		adc_cur:=0;
	CLRF       _adc_cur+0
	CLRF       _adc_cur+1
;16F676MPPT.mpas,301 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;16F676MPPT.mpas,302 :: 		p_equal:=False;
	CLRF       _p_equal+0
;16F676MPPT.mpas,303 :: 		lo_PWM:=PWM_MIN;
	MOVLW      2
	MOVWF      _lo_PWM+0
;16F676MPPT.mpas,304 :: 		hi_PWM:=PWM_MAX;
	MOVLW      255
	MOVWF      _hi_PWM+0
;16F676MPPT.mpas,309 :: 		end;
L__main35:
;16F676MPPT.mpas,311 :: 		if flag_inc then begin
	MOVF       _flag_inc+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main73
;16F676MPPT.mpas,316 :: 		if VOL_PWM<PWM_MAX then begin
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main76
;16F676MPPT.mpas,317 :: 		Inc(VOL_PWM);
	INCF       _VOL_PWM+0, 1
;16F676MPPT.mpas,319 :: 		end else begin
	GOTO       L__main77
L__main76:
;16F676MPPT.mpas,320 :: 		VOL_PWM:=hi_PWM;
	MOVF       _hi_PWM+0, 0
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,321 :: 		flag_inc:=False;
	CLRF       _flag_inc+0
;16F676MPPT.mpas,322 :: 		end;
L__main77:
;16F676MPPT.mpas,323 :: 		end else begin
	GOTO       L__main74
L__main73:
;16F676MPPT.mpas,328 :: 		if VOL_PWM>PWM_MIN then begin
	MOVF       _VOL_PWM+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L__main79
;16F676MPPT.mpas,329 :: 		Dec(VOL_PWM);
	DECF       _VOL_PWM+0, 1
;16F676MPPT.mpas,331 :: 		end else begin
	GOTO       L__main80
L__main79:
;16F676MPPT.mpas,332 :: 		VOL_PWM:=lo_PWM;
	MOVF       _lo_PWM+0, 0
	MOVWF      _VOL_PWM+0
;16F676MPPT.mpas,333 :: 		flag_inc:=True;
	MOVLW      255
	MOVWF      _flag_inc+0
;16F676MPPT.mpas,334 :: 		end;
L__main80:
;16F676MPPT.mpas,335 :: 		end;
L__main74:
;16F676MPPT.mpas,336 :: 		end;
	GOTO       L__main12
;16F676MPPT.mpas,337 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
