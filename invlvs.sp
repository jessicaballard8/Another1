*
*
*
*                       LINUX           Thu Oct  4 12:47:51 2018
*
*
*
*  PROGRAM  advgen
*
*  Name           : advgen - QRC - (32-bit)
*  Version        : 9.1.3-p005
*  Build Date     : Tue Aug  3 12:36:00 PDT 2010
*
*  HSPICE LIBRARY
*
*
*
.GLOBAL gnd! vdd!
*
.SUBCKT inv in out
*
*
*  caps2d version: 10
*
*
*       TRANSISTOR CARDS
*
*
MT1	out	in	gnd!	gnd!	nfet	L=0.12U	W=0.6U
+ wt=6e-07 rf=0 nrs=0.396396 nrd=0.396396 ngcon=1 nf=1 mSwitch=0 m=1 blockParasiticsBetween="PC sub" PWORIENT=1 PLORIENT=1
MT0	out	in	vdd!	vdd!	pfet	L=0.12U	W=1.7U
+ wt=1.7e-06 rf=0 nrs=0.132931 nrd=0.132931 ngcon=1 nf=1 mSwitch=0 m=1 blockParasiticsBetween="PC sub" PWORIENT=1 PLORIENT=1
*
*
*       CAPACITOR CARDS
*
*
C1	vdd!	gnd!	1.06563E-16
C2	in	gnd!	4.65901E-16
C3	out	gnd!	2.75912E-16
*
*
.ENDS inv
*
