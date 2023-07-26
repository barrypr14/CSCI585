
import math
R=0.0006
r=0.0001
a=0.0008
ans=[]
t = 0.01
stop = 12*math.pi
step = 0.1
with open("spiral_points＿hw4.txt",'w+') as f:
    f.truncate(0)
    #f.write(str(-118.285441 + R+r-a)+","+str(+34.020546) + "\n")
    f.write("[\n")
    while t<=stop:
        x = (R+r)*math.cos((r/R)*t) - a*math.cos((1+r/R)*t) + 34.0205619
        y = (R+r)*math.sin((r/R)*t) - a*math.sin((1+r/R)*t) - 118.2854468

        point = ""
        point += str(y) + "," + str(x)
        f.write("{\n")
        f.write("'loc' : [")
        f.write(point)
        f.write("]\n")
        f.write("},\n")
        t+=step

    f.write("]")