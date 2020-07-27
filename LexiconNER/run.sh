#!bin/bash
conda activate pulearn
beta=$1
gamma=$2
m=$3
drop=$4
prior=$5
num=$6
iter=0
next_iter=0
python dict_match.py $num >> results/${num}_final_results.txt
python feature_pu_model.py --beta $beta --gamma $gamma --dataset disease --m $m --drop_out $drop --type bnpu --num $num
python ada_dict_generation.py --beta $beta --gamma $gamma --m $m --drop_out $drop --model saved_model/${num}_bnpu_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_percent_1.0 --iter $iter --num $num
python adaptive_pu_model.py --beta $beta --gamma $gamma --m $m --drop_out $drop --p $prior --model saved_model/${num}_bnpu_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_percent_1.0 --iter $iter --output 1 --num $num
rm saved_model/${num}_bnpu_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_percent_1.0 
for i in 0 1 2 3
do
	next_iter=$((iter+1))
	python ada_dict_generation.py --beta $beta --gamma $gamma --m $m --drop_out $drop --model saved_model/${num}_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_iter_${iter} --iter $next_iter --num $num
	python adaptive_pu_model.py --beta $beta --gamma $gamma --m $m --drop_out $drop --p $prior --model saved_model/${num}_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_iter_${iter} --iter $next_iter --output 1 --num $num
	rm saved_model/${num}_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_iter_${iter}
	iter=$((iter+1))
done
rm saved_model/${num}_disease_Disease_lr_0.0001_prior_${m}_beta_${beta}_gamma_${gamma}_iter_${iter}

