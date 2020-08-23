NB. Points draws some points in a grid.
require 'gl2 numeric'
coinsert 'jgl2'

LightGray=: 3 # 211
MediumGray=: 3 # 190
DarkGray=: 3 # 169
Gray=: 3 # 128
DimGray=: 3 # 105

NB. (16,3), (12,17), (0,6), (-4,-6), (16,6), (16,-7), 
NB. (16,-3), (17,-4), (5,19), (19,-8), (3,16), (12,13), 
NB. (3,-4), (17,5), (-3,15), (-3,-9), (0,11), (-9,-3), 
NB. (-4,-2) and (12,10)
pts =. 16j3,12j17,0j6,_4j_6,16j6,16j_7,16j_3,17j_4,5j19,19j_8,3j16,12j13,3j_4,17j5,_3j15,_3j_9,0j11,_9j_3,_4j_2,12j10
B     =: 40
]scale=: 20
]xmin =: <./ 0 {"1 +. pts
]xmax =: >./ 0 {"1 +. pts
]ymin =: <./ 1 {"1 +. pts
]ymax =: >./ 1 {"1 +. pts
]X0   =: B + scale * | xmin NB. Betrag, positiver Wert xmin -> X0 = B
]Y0   =: B + scale * | ymax NB. Betrag, negativer Wert ymin -> Y0 = B
]P0   =: X0 j. Y0
]Xmax =: (+: B) + scale * | xmax - xmin 
]Ymax =: (+: B) + scale * | ymax - ymin
NB. weltKS(x,y) xmin,ymin - xmyx,ymax
NB. to BildKS X,Y
NB.
NB. o────>                            ──┐ (Xmax,Y=0)
NB. │    X                             o│
NB. │        ^                        P2
NB. vY       │        o                  
NB.          │        P3xy=16,3                 
NB.          o────>   P3XY=35,26                   
NB.          X,Y=X0,Y0 -> x,y=0,0      
NB.             =19,29                        
NB.                                     
NB. │ o                                │
NB. └─P1                             ──┘
NB. (X=0,Ymax)                      (Xmax,Ymax)
NB. 
NB. B   := 10 dist to border with circle radius of 5
NB. X0   = xmin + B
NB. Y0   = ymax + B
NB. Xmax = |xmax - xmin| +2*B
NB. Ymax = |ymax - ymin| +2*B
NB. Xi   = X0 + xi
NB. Yi   = Y0 - yi
POINTS1 =: noun define
pc points;pn "Points";
)
POINTS2 =: noun define
cc isi isigraph flush;
) 
POINTS =: POINTS1, 'minwh ', (":(>. Xmax), (>. Ymax)) ,'; ', POINTS2
NB.isi is target of gl2 commands
NB.it will be changed by the paint event
points_run =: verb define 
  wd POINTS,'pshow'
  NB.wd 'timer ',":DT * 1000
)
points_close =: verb define
  NB. wd 'timer 0; pclose'
  wd 'pclose'
)
NB.changes to this control cause a paint event
NB.all drawings have to be done within the paint event
points_isi_paint =: verb define
  drawPoints pts
)
drawGrid =: monad define
  NB. y-Raster-Abstand
  li =. range X0, 0, y
  re =. range X0, Xmax, y
  GridH =: ~. li, re
  drawLineV"0 GridH
  ut =. range Y0, Ymax, y
  ob =. range Y0, 0, y
  GridV =: ~. ut, ob
  drawLineH"0 GridV
)
drawLineV =: monad define
  gllines y, 0, y, Ymax
)
drawLineH =: monad define
  gllines 0, y, Xmax, y
)
drawNumberH =: monad define
  Text =. ": 0 { +. BKS2WKS y j. Y0
  Pos =. (y-8), (Y0+5)
  glrgb 60 60 60 NB. dark grey
  gltextcolor''
  gltextxy Pos 
  gltext Text
)
drawNumberV =: monad define
  Text =. ": 1 { +. BKS2WKS X0 j. y
  Pos =. (X0-25), (y-8)
  glrgb 60 60 60 NB. dark grey
  gltextcolor''
  gltextxy Pos 
  gltext Text
)
WKS2BKS =: monad define
  NB. Xi   = X0 + xi
  NB. Yi   = Y0 - yi
  P0 + scale * (+y)
)
BKS2WKS =: monad define
  + ((y) - P0) % scale
)
drawPoint =: monad define
  'u v' =. |: +. y
  p =. u, v
  glellipse (,~ p - -:) 10 10
  NB. ( ,~ pt - -:) w h -> (ptX - w/2) (ptY - h/2) w h
  NB.                       '-> left upper corner
)
drawKS=: verb define
  glrgb 220 220 220       NB. very light gray
  glpen 1
  drawGrid 50
  glrgb 192 192 192       NB. light gray
  glpen 1
  drawGrid 100
  glrgb 91 91 91       NB. dark gray
  glpen 1
  gllines X0,Y0 , (X0+40), Y0  NB.draw connected lines between points (list length 2)
  glpolygon (X0+50), Y0, (X0+40), (Y0-3), (X0+40), (Y0+3)
  gllines X0,Y0 , (X0), (Y0-40)  NB.draw connected lines between points (list length 2)  
  glpolygon X0, (Y0-50), (X0+3), (Y0-40), (X0-3), (Y0-40)  
  glrgb 60 60 60 NB. dark grey
  gltextcolor''
  gltextxy (X0+35), Y0+5 
  gltext 'x'
  gltextxy (X0-15), Y0-45 
  gltext 'iy'
  drawNumberH"0 GridH -. X0
  drawNumberV"0 GridV -. Y0
)
drawPoints=: monad define
  glclear'' NB.reset the area to white and the brush etc.
  drawKS''
  
  glbrush glrgb 255 255 0      NB. yellow
  drawPoint"0 WKS2BKS y  
)
points_run''
