#!bin/bash
for b in '0.1' '0.2' '0.3' '0.4' '0.5'
  do
    for g in '0.1' '0.2' '0.3' '0.4' '0.5''0.6' '0.7' '0.8' '0.9' 
      do
        python feature_pu_model.py --beta $b --gamma $g --dataset disease --type bnpu
      done
  done