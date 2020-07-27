num=0
for beta in 0.1 0.2 0.3 0.4 0.5 
do
  for gamma in 0.1 0.2 0.4 0.6 0.8 0.9
  do
    for m in 0.3 1.1 1.5 
    do
      for drop in 0.5 
      do
	for p in 0.08 1.0  
	do
		if ["$num" = "100"] -o ["$num" = "101"] -o ["$num" = "10"]; then
		echo $beta $gamma $m $drop $p $num
		fi
		num=$((num+1))
	done
      done
    done
  done
done
