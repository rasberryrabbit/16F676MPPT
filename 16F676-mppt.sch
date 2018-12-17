EESchema Schematic File Version 4
LIBS:16F676-mppt-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Simple MPPT with 16F676 v1"
Date "2018-12-17"
Rev "1.6"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:Q_NMOS_GDS Q1
U 1 1 55C339A5
P 8750 5400
F 0 "Q1" H 9000 5300 50  0000 R CNN
F 1 "BUK9511-55A127" H 8950 5100 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220-3_Vertical" H 8950 5500 29  0001 C CNN
F 3 "" H 8750 5400 60  0000 C CNN
	1    8750 5400
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 55C33F64
P 7300 4250
F 0 "R4" V 7380 4250 50  0000 C CNN
F 1 "100k" V 7300 4250 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 7230 4250 30  0001 C CNN
F 3 "" H 7300 4250 30  0000 C CNN
	1    7300 4250
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 55C34015
P 7150 5300
F 0 "R3" V 7230 5300 50  0000 C CNN
F 1 "10k" V 7150 5300 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 7080 5300 30  0001 C CNN
F 3 "" H 7150 5300 30  0000 C CNN
	1    7150 5300
	1    0    0    -1  
$EndComp
$Comp
L 16F676-mppt-rescue:LM358N-RESCUE-12f675-mppt U2
U 2 1 55C3383E
P 7750 4850
F 0 "U2" H 7700 5050 60  0000 L CNN
F 1 "LM358N" H 7700 4600 60  0000 L CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 7750 4850 60  0001 C CNN
F 3 "" H 7750 4850 60  0000 C CNN
	2    7750 4850
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_NMOS_GDS Q2
U 1 1 55C35281
P 7700 2300
F 0 "Q2" V 7900 2550 50  0000 R CNN
F 1 "BUK9511-55A127" V 8000 2800 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220-3_Vertical" H 7900 2400 29  0001 C CNN
F 3 "" H 7700 2300 60  0000 C CNN
	1    7700 2300
	0    -1   -1   0   
$EndComp
$Comp
L 16F676-mppt-rescue:INDUCTOR L1
U 1 1 55C35536
P 9300 2200
F 0 "L1" V 9250 2200 50  0000 C CNN
F 1 "330uH" V 9400 2200 50  0000 C CNN
F 2 "Inductors_THT:L_Toroid_Vertical_L33.0mm_W17.8mm_P12.70mm_Pulse_KM-5" H 9300 2200 60  0001 C CNN
F 3 "" H 9300 2200 60  0000 C CNN
	1    9300 2200
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Schottky D1
U 1 1 55C35659
P 8200 2200
F 0 "D1" H 8250 2100 50  0000 C CNN
F 1 "1N5822A" H 8150 2000 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 8200 2200 60  0001 C CNN
F 3 "" H 8200 2200 60  0000 C CNN
	1    8200 2200
	-1   0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D2
U 1 1 55C356EB
P 8650 2500
F 0 "D2" V 8650 2350 50  0000 C CNN
F 1 "1N5822A" V 8750 2700 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 8650 2500 60  0001 C CNN
F 3 "" H 8650 2500 60  0000 C CNN
	1    8650 2500
	0    -1   1    0   
$EndComp
$Comp
L Device:CP C1
U 1 1 55C3588B
P 9750 2500
F 0 "C1" H 9775 2600 50  0000 L CNN
F 1 "100u" H 9775 2400 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D12.5mm_P5.00mm" H 9788 2350 30  0001 C CNN
F 3 "" H 9750 2500 60  0000 C CNN
	1    9750 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_NPN_EBC Q4
U 1 1 55C35D82
P 6750 2800
F 0 "Q4" H 7050 2700 50  0000 R CNN
F 1 "2N2222A" H 7250 2850 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Wide" H 6950 2900 29  0001 C CNN
F 3 "" H 6750 2800 60  0000 C CNN
	1    6750 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_PNP_EBC Q5
U 1 1 55C35E2B
P 6750 3300
F 0 "Q5" H 7050 3350 50  0000 R CNN
F 1 "2N2907A" H 7250 3200 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Wide" H 6950 3400 29  0001 C CNN
F 3 "" H 6750 3300 60  0000 C CNN
	1    6750 3300
	1    0    0    1   
$EndComp
$Comp
L Device:CP C2
U 1 1 55C35FB2
P 7500 2750
F 0 "C2" H 7525 2850 50  0000 L CNN
F 1 "10uF 50v" H 7525 2650 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D12.5mm_P5.00mm" H 7538 2600 30  0001 C CNN
F 3 "" H 7500 2750 60  0000 C CNN
	1    7500 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_NPN_EBC Q3
U 1 1 55C3651D
P 6000 3000
F 0 "Q3" H 5950 3150 50  0000 R CNN
F 1 "2N2222A" H 5950 3250 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Wide" H 6200 3100 29  0001 C CNN
F 3 "" H 6000 3000 60  0000 C CNN
	1    6000 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 55C36B81
P 6100 2500
F 0 "R9" V 6180 2500 50  0000 C CNN
F 1 "10k" V 6100 2500 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 6030 2500 30  0001 C CNN
F 3 "" H 6100 2500 30  0000 C CNN
	1    6100 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 55C36CF2
P 5700 3150
F 0 "R7" V 5780 3150 50  0000 C CNN
F 1 "1k" V 5700 3150 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 5630 3150 30  0001 C CNN
F 3 "" H 5700 3150 30  0000 C CNN
	1    5700 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:D D3
U 1 1 55C36E30
P 5600 2350
F 0 "D3" H 5600 2450 50  0000 C CNN
F 1 "1N4148" H 5600 2250 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 5600 2350 60  0001 C CNN
F 3 "" H 5600 2350 60  0000 C CNN
	1    5600 2350
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 55C376F8
P 6350 2700
F 0 "R10" V 6430 2700 50  0000 C CNN
F 1 "1k" V 6350 2700 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 6280 2700 30  0001 C CNN
F 3 "" H 6350 2700 30  0000 C CNN
	1    6350 2700
	0    1    1    0   
$EndComp
$Comp
L Device:R R5
U 1 1 55C3A8B1
P 1500 3200
F 0 "R5" V 1580 3200 50  0000 C CNN
F 1 "300k" V 1500 3200 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 1430 3200 30  0001 C CNN
F 3 "" H 1500 3200 30  0000 C CNN
	1    1500 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 55C3B177
P 4450 4400
F 0 "R8" V 4530 4400 50  0000 C CNN
F 1 "100k" V 4450 4400 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 4380 4400 30  0001 C CNN
F 3 "" H 4450 4400 30  0000 C CNN
	1    4450 4400
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R6
U 1 1 55C3BCB8
P 4100 4800
F 0 "R6" V 4180 4800 50  0000 C CNN
F 1 "1k" V 4100 4800 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 4030 4800 30  0001 C CNN
F 3 "" H 4100 4800 30  0000 C CNN
	1    4100 4800
	-1   0    0    1   
$EndComp
$Comp
L 16F676-mppt-rescue:LED-RESCUE-12f675-mppt D4
U 1 1 55C3BFD1
P 4100 5250
F 0 "D4" H 4100 5350 50  0000 C CNN
F 1 "LED" H 4100 5150 50  0000 C CNN
F 2 "LEDs:LED_D4.0mm" H 4100 5250 60  0001 C CNN
F 3 "" H 4100 5250 60  0000 C CNN
	1    4100 5250
	0    -1   -1   0   
$EndComp
$Comp
L Device:D D5
U 1 1 55C3D464
P 1900 2900
F 0 "D5" H 1900 3000 50  0000 C CNN
F 1 "1N4007" H 1900 2800 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 1900 2900 60  0001 C CNN
F 3 "" H 1900 2900 60  0000 C CNN
	1    1900 2900
	0    1    -1   0   
$EndComp
$Comp
L Device:C C4
U 1 1 55C3DB01
P 3400 3700
F 0 "C4" H 3425 3800 50  0000 L CNN
F 1 "0.1u" H 3425 3600 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D12.5mm_W5.0mm_P7.50mm" H 3438 3550 30  0001 C CNN
F 3 "" H 3400 3700 60  0000 C CNN
	1    3400 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C3
U 1 1 55C3DBAA
P 2750 3700
F 0 "C3" H 2775 3800 50  0000 L CNN
F 1 "100u" H 2775 3600 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D12.5mm_P5.00mm" H 2788 3550 30  0001 C CNN
F 3 "" H 2750 3700 60  0000 C CNN
	1    2750 3700
	1    0    0    -1  
$EndComp
Text Label 5000 2350 2    60   ~ 0
BootStrap
Text Label 7300 3600 2    60   ~ 0
PV-Current
Text Label 3850 4400 2    60   ~ 0
PV-Voltage
Text Notes 9150 5200 2    60   ~ 0
Heat Sink
$Comp
L Device:R R12
U 1 1 55C48C57
P 1500 4050
F 0 "R12" V 1580 4050 50  0000 C CNN
F 1 "47k" V 1500 4050 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 1430 4050 30  0001 C CNN
F 3 "" H 1500 4050 30  0000 C CNN
	1    1500 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 55CA080E
P 6950 5300
F 0 "R2" V 7030 5300 50  0000 C CNN
F 1 "100k" V 6950 5300 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 6880 5300 30  0001 C CNN
F 3 "" H 6950 5300 30  0000 C CNN
	1    6950 5300
	-1   0    0    1   
$EndComp
$Comp
L Device:R R13
U 1 1 55CA08C8
P 7300 3950
F 0 "R13" V 7380 3950 50  0000 C CNN
F 1 "10k" V 7300 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 7230 3950 30  0001 C CNN
F 3 "" H 7300 3950 30  0000 C CNN
	1    7300 3950
	0    1    1    0   
$EndComp
Text Notes 1050 3650 0    60   ~ 0
Max 25V
$Comp
L 16F676-mppt-rescue:LED-RESCUE-12f675-mppt D9
U 1 1 55CCC105
P 5900 5350
F 0 "D9" H 5900 5450 50  0000 C CNN
F 1 "LED" H 5900 5250 50  0000 C CNN
F 2 "LEDs:LED_D4.0mm" H 5900 5350 60  0001 C CNN
F 3 "" H 5900 5350 60  0000 C CNN
	1    5900 5350
	0    -1   -1   0   
$EndComp
$Comp
L 16F676-mppt-rescue:LED-RESCUE-12f675-mppt D8
U 1 1 55CCC217
P 5900 4850
F 0 "D8" H 5900 4950 50  0000 C CNN
F 1 "LED" H 5900 4750 50  0000 C CNN
F 2 "LEDs:LED_D4.0mm" H 5900 4850 60  0001 C CNN
F 3 "" H 5900 4850 60  0000 C CNN
	1    5900 4850
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R14
U 1 1 55CCC2B4
P 5900 4200
F 0 "R14" V 5980 4200 50  0000 C CNN
F 1 "4.7k" V 5900 4200 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 5830 4200 30  0001 C CNN
F 3 "" H 5900 4200 30  0000 C CNN
	1    5900 4200
	1    0    0    -1  
$EndComp
Text Label 5750 3850 0    60   ~ 0
3.6v
$Comp
L Device:CP C5
U 1 1 55CDDBD9
P 6350 4900
F 0 "C5" H 6375 5000 50  0000 L CNN
F 1 "10u" H 6375 4800 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D12.5mm_P5.00mm" H 6388 4750 30  0001 C CNN
F 3 "" H 6350 4900 60  0000 C CNN
	1    6350 4900
	1    0    0    -1  
$EndComp
Text Label 8800 6000 0    60   ~ 0
3.6v
$Comp
L 16F676-mppt-rescue:LM358N-RESCUE-12f675-mppt U2
U 1 1 56E669E2
P 9100 4350
F 0 "U2" H 9050 4550 60  0000 L CNN
F 1 "LM358N" H 9050 4100 60  0000 L CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 9100 4350 60  0001 C CNN
F 3 "" H 9100 4350 60  0000 C CNN
	1    9100 4350
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 56E67518
P 9450 4850
F 0 "R1" V 9530 4850 50  0000 C CNN
F 1 "2.2k" V 9450 4850 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 9380 4850 50  0001 C CNN
F 3 "" H 9450 4850 50  0000 C CNN
	1    9450 4850
	0    1    1    0   
$EndComp
$Comp
L Device:R R15
U 1 1 56E68956
P 9900 4300
F 0 "R15" V 9980 4300 50  0000 C CNN
F 1 "10k" V 9900 4300 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 9830 4300 50  0001 C CNN
F 3 "" H 9900 4300 50  0000 C CNN
	1    9900 4300
	-1   0    0    1   
$EndComp
$Comp
L Device:CP C7
U 1 1 56E7CE1F
P 2950 2750
F 0 "C7" H 2975 2850 50  0000 L CNN
F 1 "47u" H 2975 2650 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D12.5mm_P5.00mm" H 2988 2600 30  0001 C CNN
F 3 "" H 2950 2750 60  0000 C CNN
	1    2950 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 56ECB4B6
P 3550 5000
F 0 "R16" V 3630 5000 50  0000 C CNN
F 1 "10k" V 3550 5000 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 3480 5000 50  0001 C CNN
F 3 "" H 3550 5000 50  0000 C CNN
	1    3550 5000
	0    1    1    0   
$EndComp
$Comp
L 16F676-mppt-rescue:SW_PUSH SW1
U 1 1 56ECBA1E
P 2750 4650
F 0 "SW1" H 2900 4760 50  0000 C CNN
F 1 "Write OP-AMP DIFF" H 2750 4570 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 2750 4650 50  0001 C CNN
F 3 "" H 2750 4650 50  0000 C CNN
	1    2750 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D6
U 1 1 5B182927
P 2750 2200
F 0 "D6" H 2800 2100 50  0000 C CNN
F 1 "1N5822A" H 2700 2000 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 2750 2850 60  0001 C CNN
F 3 "" H 2750 2200 60  0000 C CNN
	1    2750 2200
	-1   0    0    -1  
$EndComp
Text Notes 2450 1900 0    60   ~ 0
100W
Text Notes 8350 1850 0    60   ~ 0
100W
Text Notes 1750 4500 0    60   ~ 0
3.6V
$Comp
L Device:D_Schottky D7
U 1 1 5B186209
P 2750 1900
F 0 "D7" H 2800 1800 50  0000 C CNN
F 1 "1N5822A" H 2700 1700 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 2750 1900 60  0001 C CNN
F 3 "" H 2750 1900 60  0000 C CNN
	1    2750 1900
	-1   0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D10
U 1 1 5B18BCE9
P 8200 1850
F 0 "D10" H 8250 1750 50  0000 C CNN
F 1 "1N5822A" H 8150 1650 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 8200 1850 60  0001 C CNN
F 3 "" H 8200 1850 60  0000 C CNN
	1    8200 1850
	-1   0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D11
U 1 1 5B19189C
P 8950 2500
F 0 "D11" V 8950 2350 50  0000 C CNN
F 1 "1N5822A" V 9050 2250 50  0000 C CNN
F 2 "Diodes_THT:D_DO-201AD_P15.24mm_Horizontal" H 8950 2500 60  0001 C CNN
F 3 "" H 8950 2500 60  0000 C CNN
	1    8950 2500
	0    -1   1    0   
$EndComp
$Comp
L 16F676-mppt-rescue:INDUCTOR L2
U 1 1 5B1972E6
P 9300 1850
F 0 "L2" V 9250 1850 50  0000 C CNN
F 1 "330uH" V 9400 1850 50  0000 C CNN
F 2 "Inductors_THT:L_Toroid_Vertical_L33.0mm_W17.8mm_P12.70mm_Pulse_KM-5" H 9300 1850 60  0001 C CNN
F 3 "" H 9300 1850 60  0000 C CNN
	1    9300 1850
	0    -1   -1   0   
$EndComp
Text Notes 9500 1850 0    60   ~ 0
100W
Text Notes 8950 2700 0    60   ~ 0
100W
Wire Wire Line
	1800 4100 2300 4100
Connection ~ 2300 4100
Wire Wire Line
	2600 3400 2750 3400
Wire Wire Line
	3150 2350 3150 3400
Connection ~ 3150 3400
Wire Wire Line
	7150 5600 7150 5450
Connection ~ 7150 5600
Wire Wire Line
	7450 4250 8250 4250
Wire Wire Line
	7250 4950 7150 4950
Wire Wire Line
	7150 4250 7150 4950
Connection ~ 7150 4950
Wire Wire Line
	6950 4750 7250 4750
Wire Wire Line
	8650 2650 8650 2750
Wire Wire Line
	8650 2750 8950 2750
Wire Wire Line
	8350 2200 8450 2200
Wire Wire Line
	8650 2200 8650 2350
Connection ~ 8650 2200
Wire Wire Line
	9600 2200 9750 2200
Wire Wire Line
	9750 2200 9750 2350
Wire Wire Line
	7900 2200 8000 2200
Wire Wire Line
	8000 3500 7500 3500
Wire Wire Line
	8000 1850 8000 2200
Connection ~ 8000 2200
Wire Wire Line
	6550 2700 6550 2800
Wire Wire Line
	7500 2900 7500 3500
Connection ~ 7500 3500
Wire Wire Line
	6100 5600 6100 3200
Connection ~ 6100 5600
Wire Wire Line
	6100 2650 6100 2700
Wire Wire Line
	5550 3400 5700 3400
Wire Wire Line
	5700 3400 5700 3300
Wire Wire Line
	5700 3000 5800 3000
Wire Wire Line
	5750 2350 6100 2350
Wire Wire Line
	6850 2350 6850 2600
Connection ~ 6100 2350
Wire Wire Line
	3150 2350 5450 2350
Wire Wire Line
	6500 2700 6550 2700
Connection ~ 6550 2800
Wire Wire Line
	6200 2700 6100 2700
Connection ~ 6100 2700
Connection ~ 1900 2200
Connection ~ 2300 5600
Connection ~ 1500 2200
Wire Wire Line
	1500 3050 1500 2200
Wire Wire Line
	1500 3350 1500 3500
Wire Wire Line
	1750 3500 1500 3500
Connection ~ 1500 3500
Wire Wire Line
	4100 5600 4100 5450
Connection ~ 4100 5600
Wire Wire Line
	4100 5050 4100 4950
Wire Wire Line
	1900 2200 1900 2750
Wire Wire Line
	2750 3850 2750 4100
Connection ~ 2750 4100
Wire Wire Line
	2750 3550 2750 3400
Connection ~ 2750 3400
Wire Wire Line
	3400 3850 3400 4100
Connection ~ 3400 4100
Wire Wire Line
	3400 3550 3400 3400
Connection ~ 3400 3400
Wire Wire Line
	7500 2350 7500 2600
Connection ~ 6850 2350
Connection ~ 7650 5600
Connection ~ 7650 4450
Wire Wire Line
	9750 2750 9750 2650
Connection ~ 8650 2750
Connection ~ 9750 2750
Connection ~ 9750 2200
Wire Notes Line
	6150 5850 10050 5850
Wire Wire Line
	5450 3600 6350 3600
Wire Wire Line
	1500 4200 1500 5600
Connection ~ 1500 5600
Wire Wire Line
	6950 3950 6950 4750
Wire Wire Line
	6950 5600 6950 5450
Connection ~ 6950 5600
Wire Wire Line
	6950 3950 7150 3950
Connection ~ 6950 4750
Wire Wire Line
	7450 3950 8650 3950
Connection ~ 8650 3950
Wire Wire Line
	5900 4350 5900 4500
Wire Wire Line
	5900 5050 5900 5150
Wire Wire Line
	5900 5600 5900 5550
Connection ~ 5900 5600
Wire Wire Line
	5900 4050 6250 4050
Wire Wire Line
	6350 5600 6350 5050
Connection ~ 6350 5600
Wire Wire Line
	6350 4750 6350 3600
Connection ~ 6350 3600
Wire Notes Line
	6150 3500 6150 5850
Wire Notes Line
	6150 3500 6750 3500
Wire Notes Line
	6750 3500 6950 3750
Wire Notes Line
	6950 3750 10050 3750
Wire Wire Line
	3150 6100 8400 6100
Wire Wire Line
	8400 6100 8400 4450
Wire Wire Line
	1750 3500 1750 4400
Wire Wire Line
	1750 4400 4300 4400
Wire Wire Line
	5650 4400 5650 3700
Wire Wire Line
	5650 3700 5350 3700
Wire Wire Line
	5900 4500 5750 4500
Wire Wire Line
	5750 3650 5750 4500
Connection ~ 5900 4500
Wire Wire Line
	6250 4050 6250 4450
Wire Wire Line
	5400 3650 5750 3650
Wire Wire Line
	9100 5400 8950 5400
Wire Wire Line
	5750 6000 9100 6000
Wire Wire Line
	9100 6000 9100 5400
Connection ~ 5750 4500
Wire Wire Line
	6250 4450 7650 4450
Wire Wire Line
	9700 5600 8650 5600
Wire Wire Line
	8250 4250 8250 4850
Wire Wire Line
	8250 4850 9000 4850
Wire Wire Line
	9100 3850 9100 3600
Wire Wire Line
	9700 4450 9700 4850
Connection ~ 8650 5600
Wire Wire Line
	9300 4850 9200 4850
Connection ~ 9700 4850
Connection ~ 8400 4450
Wire Wire Line
	9900 5100 9900 4450
Wire Wire Line
	9900 3600 9900 4150
Connection ~ 9100 3600
Wire Notes Line
	10050 3750 10050 5850
Wire Wire Line
	9600 4850 9700 4850
Wire Wire Line
	9900 5100 9200 5100
Wire Wire Line
	9200 5100 9200 4850
Wire Wire Line
	1200 2200 1500 2200
Wire Wire Line
	2900 2200 2950 2200
Wire Wire Line
	2950 1900 2950 2200
Connection ~ 2950 2200
Wire Wire Line
	1800 4100 1800 3100
Wire Wire Line
	1800 3100 2950 3100
Wire Wire Line
	2950 3100 2950 2900
Wire Wire Line
	3400 5000 3150 5000
Connection ~ 3150 5000
Wire Wire Line
	3800 4550 3800 4650
Wire Wire Line
	3800 5000 3700 5000
Connection ~ 3800 4650
Wire Wire Line
	2300 4650 2450 4650
Connection ~ 2300 4650
Wire Wire Line
	3500 3400 3500 2500
Wire Wire Line
	3700 3750 3700 4550
Wire Wire Line
	3700 4550 3800 4550
Wire Wire Line
	3800 4650 3050 4650
Wire Wire Line
	2600 1900 2400 1900
Wire Wire Line
	2400 1900 2400 2200
Connection ~ 2400 2200
Wire Wire Line
	2900 1900 2950 1900
Wire Wire Line
	8050 1850 8000 1850
Wire Wire Line
	8350 1850 8450 1850
Wire Wire Line
	8450 1850 8450 2200
Connection ~ 8450 2200
Wire Wire Line
	8950 2650 8950 2750
Connection ~ 8950 2750
Wire Wire Line
	8950 1850 8950 2200
Connection ~ 8950 2200
Wire Wire Line
	9600 1850 9600 2200
Wire Wire Line
	9000 1850 8950 1850
Wire Notes Line
	2300 1750 2300 2150
Wire Notes Line
	2300 2150 3000 2150
Wire Notes Line
	3000 2150 3000 1750
Wire Notes Line
	3000 1750 2300 1750
Wire Notes Line
	7950 1650 7950 2100
Wire Notes Line
	7950 2100 8700 2100
Wire Notes Line
	8700 2100 8700 1650
Wire Notes Line
	8700 1650 7950 1650
Wire Notes Line
	8850 1650 8850 2100
Wire Notes Line
	8850 2100 9800 2100
Wire Notes Line
	9800 2100 9800 1650
Wire Notes Line
	9800 1650 8850 1650
Wire Notes Line
	8850 2300 8850 2700
Wire Notes Line
	8850 2700 9400 2700
Wire Notes Line
	9400 2700 9400 2300
Wire Notes Line
	9400 2300 8850 2300
$Comp
L 16F676-mppt-rescue:16F676 U3
U 1 1 5B1F6627
P 4500 3350
F 0 "U3" H 4100 4050 60  0000 C CNN
F 1 "16F676" H 4500 3050 60  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 4700 3300 60  0001 C CNN
F 3 "" H 4700 3300 60  0001 C CNN
	1    4500 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 3750 3800 3750
Wire Wire Line
	5250 3450 5350 3450
Wire Wire Line
	5350 3450 5350 3700
Wire Wire Line
	5400 3650 5400 3350
Wire Wire Line
	5400 3350 5250 3350
Wire Wire Line
	5450 3600 5450 3250
Wire Wire Line
	5450 3250 5250 3250
Wire Wire Line
	3500 2500 4500 2500
Wire Wire Line
	5250 3650 5300 3650
Wire Wire Line
	5300 3650 5300 3750
Wire Wire Line
	5300 3750 5550 3750
Wire Wire Line
	5550 3750 5550 3400
Wire Wire Line
	4100 4650 4100 4200
Wire Wire Line
	4100 4200 3600 4200
Wire Wire Line
	3600 4200 3600 3650
Wire Wire Line
	3600 3650 3800 3650
NoConn ~ 3800 2950
NoConn ~ 3800 3050
NoConn ~ 3800 3150
NoConn ~ 3800 3550
NoConn ~ 5250 3550
NoConn ~ 5250 3750
Wire Wire Line
	7650 5250 7650 5600
Wire Wire Line
	9700 4450 9500 4450
$Comp
L 16F676-mppt-rescue:Conn_01x01 J1
U 1 1 5B23F935
P 1200 1100
F 0 "J1" H 1200 1200 50  0000 C CNN
F 1 "S+" H 1200 1000 50  0000 C CNN
F 2 "Connectors:1pin" H 1200 1100 50  0001 C CNN
F 3 "" H 1200 1100 50  0001 C CNN
	1    1200 1100
	0    -1   -1   0   
$EndComp
$Comp
L 16F676-mppt-rescue:Conn_01x01 J2
U 1 1 5B23FA7C
P 1600 1100
F 0 "J2" H 1600 1200 50  0000 C CNN
F 1 "S-" H 1600 1000 50  0000 C CNN
F 2 "Connectors:1pin" H 1600 1100 50  0001 C CNN
F 3 "" H 1600 1100 50  0001 C CNN
	1    1600 1100
	0    -1   -1   0   
$EndComp
$Comp
L 16F676-mppt-rescue:Conn_01x01 J3
U 1 1 5B23FC85
P 9900 1200
F 0 "J3" H 9900 1300 50  0000 C CNN
F 1 "VB+" H 9900 1100 50  0000 C CNN
F 2 "Connectors:1pin" H 9900 1200 50  0001 C CNN
F 3 "" H 9900 1200 50  0001 C CNN
	1    9900 1200
	0    -1   -1   0   
$EndComp
$Comp
L 16F676-mppt-rescue:Conn_01x01 J4
U 1 1 5B23FEF9
P 10250 1200
F 0 "J4" H 10250 1300 50  0000 C CNN
F 1 "VB-" H 10250 1100 50  0000 C CNN
F 2 "Connectors:1pin" H 10250 1200 50  0001 C CNN
F 3 "" H 10250 1200 50  0001 C CNN
	1    10250 1200
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5B2402FB
P 1250 5700
F 0 "#PWR01" H 1250 5450 50  0001 C CNN
F 1 "GND" H 1250 5550 50  0000 C CNN
F 2 "" H 1250 5700 50  0001 C CNN
F 3 "" H 1250 5700 50  0001 C CNN
	1    1250 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 5600 1250 5700
$Comp
L power:GND #PWR02
U 1 1 5B24072D
P 1600 1500
F 0 "#PWR02" H 1600 1250 50  0001 C CNN
F 1 "GND" H 1600 1350 50  0000 C CNN
F 2 "" H 1600 1500 50  0001 C CNN
F 3 "" H 1600 1500 50  0001 C CNN
	1    1600 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1300 1600 1500
$Comp
L power:VDD #PWR03
U 1 1 5B24099D
P 1200 2200
F 0 "#PWR03" H 1200 2050 50  0001 C CNN
F 1 "VDD" H 1200 2350 50  0000 C CNN
F 2 "" H 1200 2200 50  0001 C CNN
F 3 "" H 1200 2200 50  0001 C CNN
	1    1200 2200
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR04
U 1 1 5B240AAB
P 1300 1600
F 0 "#PWR04" H 1300 1450 50  0001 C CNN
F 1 "VDD" H 1300 1750 50  0000 C CNN
F 2 "" H 1300 1600 50  0001 C CNN
F 3 "" H 1300 1600 50  0001 C CNN
	1    1300 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 1600 1200 1600
Wire Wire Line
	1200 1600 1200 1300
$Comp
L power:+BATT #PWR05
U 1 1 5B246782
P 10500 2200
F 0 "#PWR05" H 10500 2050 50  0001 C CNN
F 1 "+BATT" H 10500 2340 50  0000 C CNN
F 2 "" H 10500 2200 50  0001 C CNN
F 3 "" H 10500 2200 50  0001 C CNN
	1    10500 2200
	1    0    0    -1  
$EndComp
$Comp
L power:-BATT #PWR06
U 1 1 5B2467FA
P 10500 2750
F 0 "#PWR06" H 10500 2600 50  0001 C CNN
F 1 "-BATT" H 10500 2890 50  0000 C CNN
F 2 "" H 10500 2750 50  0001 C CNN
F 3 "" H 10500 2750 50  0001 C CNN
	1    10500 2750
	1    0    0    -1  
$EndComp
$Comp
L power:+BATT #PWR07
U 1 1 5B246B6F
P 9650 1400
F 0 "#PWR07" H 9650 1250 50  0001 C CNN
F 1 "+BATT" H 9650 1540 50  0000 C CNN
F 2 "" H 9650 1400 50  0001 C CNN
F 3 "" H 9650 1400 50  0001 C CNN
	1    9650 1400
	1    0    0    -1  
$EndComp
$Comp
L power:-BATT #PWR08
U 1 1 5B246BE7
P 10550 1400
F 0 "#PWR08" H 10550 1250 50  0001 C CNN
F 1 "-BATT" H 10550 1540 50  0000 C CNN
F 2 "" H 10550 1400 50  0001 C CNN
F 3 "" H 10550 1400 50  0001 C CNN
	1    10550 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 1400 9900 1400
Wire Wire Line
	10250 1400 10550 1400
$Comp
L 16F676-mppt-rescue:LM7805_TO220 U1
U 1 1 5B233034
P 2300 3400
F 0 "U1" H 2150 3525 50  0000 C CNN
F 1 "LM7805_TO220" H 2300 3550 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Vertical" H 2300 3625 50  0001 C CIN
F 3 "" H 2300 3350 50  0001 C CNN
	1    2300 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 3400 2000 3400
Wire Wire Line
	2300 3700 2300 4100
Wire Wire Line
	1900 3050 1900 3400
Connection ~ 8250 4850
Connection ~ 9200 4850
Text Notes 9100 3850 0    60   ~ 0
x47(50, 6A)
Wire Wire Line
	2300 4100 2750 4100
Wire Wire Line
	2300 4100 2300 4650
Wire Wire Line
	3150 3400 3400 3400
Wire Wire Line
	3150 3400 3150 5000
Wire Wire Line
	7150 5600 6950 5600
Wire Wire Line
	7150 4950 7150 5150
Wire Wire Line
	8650 2200 8950 2200
Wire Wire Line
	8000 2200 8050 2200
Wire Wire Line
	7500 3500 6850 3500
Wire Wire Line
	6100 5600 5900 5600
Wire Wire Line
	6100 2350 6850 2350
Wire Wire Line
	6550 2800 6550 3300
Wire Wire Line
	6100 2700 6100 2800
Wire Wire Line
	1900 2200 2400 2200
Wire Wire Line
	2300 5600 1500 5600
Wire Wire Line
	1500 2200 1900 2200
Wire Wire Line
	1500 3500 1500 3900
Wire Wire Line
	4100 5600 2300 5600
Wire Wire Line
	2750 4100 3400 4100
Wire Wire Line
	2750 3400 3150 3400
Wire Wire Line
	3400 4100 4500 4100
Wire Wire Line
	3400 3400 3500 3400
Wire Wire Line
	6850 2350 7500 2350
Wire Wire Line
	7650 5600 7150 5600
Wire Wire Line
	7650 4450 8400 4450
Wire Wire Line
	8650 2750 8650 3950
Wire Wire Line
	9750 2750 10500 2750
Wire Wire Line
	9750 2200 10500 2200
Wire Wire Line
	1500 5600 1250 5600
Wire Wire Line
	6950 5600 6350 5600
Wire Wire Line
	6950 4750 6950 5150
Wire Wire Line
	8650 3950 8650 5200
Wire Wire Line
	6350 5600 6100 5600
Wire Wire Line
	5900 4500 5900 4650
Wire Wire Line
	5750 4500 5750 6000
Wire Wire Line
	8650 5600 7650 5600
Wire Wire Line
	9700 4850 9700 5600
Wire Wire Line
	8400 4450 8700 4450
Wire Wire Line
	9100 3600 9900 3600
Wire Wire Line
	2950 2200 7500 2200
Wire Wire Line
	2950 2200 2950 2600
Wire Wire Line
	3150 5000 3150 6100
Wire Wire Line
	3800 4650 3800 5000
Wire Wire Line
	2300 4650 2300 5600
Wire Wire Line
	2400 2200 2600 2200
Wire Wire Line
	8450 2200 8650 2200
Wire Wire Line
	8950 2750 9750 2750
Wire Wire Line
	8950 2200 8950 2350
Wire Wire Line
	8950 2200 9000 2200
Wire Wire Line
	6850 3000 6850 3050
Wire Wire Line
	8000 2200 8000 3500
Connection ~ 6850 3050
Wire Wire Line
	6850 3050 6850 3100
Wire Wire Line
	7700 3050 7700 2500
Wire Wire Line
	6350 3600 9100 3600
Wire Wire Line
	6850 3050 7700 3050
Wire Wire Line
	4600 4400 5650 4400
Wire Wire Line
	4100 5600 5900 5600
$EndSCHEMATC
