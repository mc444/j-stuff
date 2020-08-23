NB.Surface draws the surface sin(r)/r for x,y -15..+15,-15..+15.
load 'plot trig numeric'
x =. steps _15 15 99 NB.0,0 is a 0/0-position, left out here.
y =. steps _15 15 99
z =. x j./ y
r =. | z
data =. (% r) * sin r
'surface; viewpoint 4 4 3.8' plot data
