NB.Surface stellt die Fläche sin(r)/r für x,y -15..+15,-15..+15 dar.
load 'plot trig numeric'
x =. steps _15 15 99 NB.0,0 ist eine 0/0-Stelle, wird hier weggelassen
y =. steps _15 15 99
z =. x j./ y
r =. | z
data =. (% r) * sin r
'surface; viewpoint 4 4 3.8' plot data