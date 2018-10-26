$example HSPICE setup file

$transistor model
.include "/home/cad/kits/IBM_CMRF8SF-LM013/IBM_PDK/cmrf8sf/V1.2.0.0LM/HSPICE/models/model013.lib_inc"
.include "/home/eng/j/jxb150730/cad/cadence/oai21lvs.sp"

.global vdd! gnd!
.option post runlvl=5

xi a b c d out oai21

vdd vdd! gnd! 1.2v
vina a gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 6ns 0v 6.05ns 1.2v 12ns 1.2v)
vinb b gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 6ns 0v 6.05ns 1.2v 12ns 1.2v)
vinc c gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 6ns 0v 6.05ns 1.2v 12ns 1.2v)
vind d gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 6ns 0v 6.05ns 1.2v 12ns 1.2v)
cout out gnd! 80f

$transient analysis
.tr 100ps 12ns
$example of parameter sweep, replace numeric value W of pfet with WP in oai21lvs.sp
$.tr 100ps 12ns sweep WP 1u 9u 0.5u

.measure tran trisea trig v(ina) val=0.6v fall=1 targ v(out) val=0.6v rise=1 $measure tlh at 0.6v
.measure tran tfalla trig v(ina) val=0.6v rise=1 targ v(out) val=0.6v fall=1 $measure tpl at 0.6v

.measure tran triseb trig v(inb) val=0.6v fall=1 targ v(out) val=0.6v rise=1 $measure tlh at 0.6v
.measure tran tfallb trig v(inb) val=0.6v rise=1 targ v(out) val=0.6v fall=1 $measure tpl at 0.6v

.measure tran trisec trig v(inc) val=0.6v fall=1 targ v(out) val=0.6v rise=1 $measure tlh at 0.6v
.measure tran tfallc trig v(inc) val=0.6v rise=1 targ v(out) val=0.6v fall=1 $measure tpl at 0.6v

.measure tavga param = '(trisea+tfalla)/2' $calculate average delay
.measure tdiffa param='abs(trisea-tfalla)' $calculate delay difference
.measure delaya param='max(trisea,tfalla)' $calculate worst case delay

.measure tavgb param = '(triseb+tfallb)/2' $calculate average delay
.measure tdiffb param='abs(triseb-tfallb)' $calculate delay difference
.measure delayb param='max(triseb,tfallb)' $calculate worst case delay

.measure tavgc param = '(trisec+tfallc)/2' $calculate average delay
.measure tdiffc param='abs(trisec-tfallc)' $calculate delay difference
.measure delayc param='max(trisec,tfallc)' $calculate worst case delay

$ method 1
.measure tran iavg avg i(vdd) from=0 to=10n $average current in one clock cycle
.measure energy param='1.2*iavg*10n' $calculate energy in one clock cycle
.measure edp1 param='abs(delaya*energy)'

$ method 2
.measure tran t1 when v(ina)=1.19 fall=1
.measure tran t2 when v(out)=1.19 rise=1
.measure tran t3 when v(ina)=0.01 rise=1
.measure tran t4 when v(out)=0.01 fall=1

.measure tran i1 avg i(vdd) from=t1 to=t2 $average current when output rise
.measure tran i2 avg i(vdd) from=t3 to=t4 $average current when output fall
.measure energy1 param='1.2*i1*(t2-t1)' $calculate energy when output rise
.measure energy2 param='1.2*i2*(t4-t3)' $calculate energy when output fall
.measure energysum param='energy1+energy2'
.measure edp2 param='abs(delaya*energysum)'

.end
