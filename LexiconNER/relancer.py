num = 0
for beta in [0.2]:
  for gamma in [0.9]:
    for m in [0.3 ,1.5]:
      for drop in [0.5] :
        for p in [0.1,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5]:  
          print(str(beta) + ' ' +  str(gamma) + ' ' +  str(m) + ' ' +  str(drop) + ' ' + str(p) + ' ' + str(num))
          num = num +  1

