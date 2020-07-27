#!bin/bash
file=$1
entity_name=$2
beta=0.1
gamma=0.2
iter=0
next_iter=0
for percent in 0.2 #0.4 0.6 0.8
do
	python make_dico.py $file $percent $entity_name 
	cp $entity_name.txt ./dictionary/disease.txt
	cp $entity_name.txt ./dictionary/disease/disease.txt
	mv $entity_name.txt diseaseBigDic.txt
	mv diseaseBigDic.txt ./feature_dictionary/disease/
	for m in 0.5 #1.0 1.2 1.5 2.0
	do
		for drop in 0.3 #0.5 0.7 
		do
			for prior in 0.02 #0.05 0.1 0.2
			do
        echo $percent $m $drop $prior >> results/final_results.txt

        python dict_match.py >> results/final_results.txt
        echo "feature" >> results/final_results.txt
        python feature_pu_model.py --beta $beta --gamma $gamma --dataset disease --m $m --drop_out $drop --type bnpu

        python ada_dict_generation.py --beta $beta --gamma $gamma --m $m --drop_out $drop --model saved_model/bnpu_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_percent_1.0 --iter $iter
        echo "ada 0" >> results/final_results.txt
				python adaptive_pu_model.py --beta $beta --gamma $gamma --m $m --drop_out $drop --p $prior --model saved_model/bnpu_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_percent_1.0 --iter $iter
			 	for i in 0 #1 2 3 
				do
					next_iter=$((iter+1))
					echo "ada" $((i+1)) >> results/final_results.txt
			    python ada_dict_generation.py --beta $beta --gamma $gamma --m $m --drop_out $drop --model saved_model/disease_Disease_lr_0.0001_prior_${prior}_beta_${beta}_gamma_${gamma}_iter_${iter} --iter $next_iter
					python adaptive_pu_model.py --beta $beta --gamma $gamma --m $m --drop_out $drop --p $prior --model saved_model/disease_Disease_lr_0.0001_prior_${prior}_beta_${beta}_gamma_${gamma}_iter_${iter} --iter $next_iter
					rm saved_model/disease_Disease_lr_0.0001_prior_${prior}_beta_${beta}_gamma_${gamma}_iter_${iter}
					iter=$((iter+1))
				done
			done
		done
	done
	rm ./dictionary/disease.txt
	rm ./dictionary/disease/disease.txt
	rm ./feature_dictionary/disease/diseaseBigDic.txt
done