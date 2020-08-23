NB.Timeaxis uses labels for arbitrary data in x.
load 'plot'

f1=:  0.7  1.3  0.8  _0.2  0.1  0.9  0.6
f2=: 23.4 22.1 45.9  50.4 34.5 67.3 45.6
fx=: 23.4 50.4 45.6

variant1=: verb define
pd 'reset'
pd 'sub 3 1'
pd 'new'
pd 'ycaption ycaption1'
pd 'type line'
pd f1
pd 'use'
pd 'ycaption ycaption2'
pd f2
pd 'use'
pd 'type point'
pd 'xlabel "L1","L2","L3"'
pd (0 3 6);(0 0 0)
pd 'xcaption time'
pd 'ycaption Yy'
pd 'endsub'
pd 'show'
)
]p1=: (<'type line');<f1
]p2=: ((<'type marker; xlabel "L1","L2","L3"; xtic 1,2') ,: <'type line'),.((<(0 3 6);fx),: <f2)
]p=: (<p2),<p1
variant2=: verb define
pd 'reset'
pd 'multi 2 1'
pd 'xgroup 0 1'
pd p
pd 'show'
)
variant3=: verb define
pd 'reset'
pd 'type point'
pd 'xlabel L1, L2, L3'
pd (0 3 6);fx
pd 'type line'
pd f1
pd f2
pd 'show'
)