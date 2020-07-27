#!bin/bash
file=$1
entity_name=$2
percent=$3
beta=0.1
gamma=0.2
iter=0
next_iter=0
python make_dico.py train.tsv $percent Disease 
cp $entity_name.txt ./dictionary/disease.txt
cp $entity_name.txt ./dictionary/disease/disease.txt
mv $entity_name.txt diseaseBigDic.txt
mv diseaseBigDic.txt ./feature_dictionary/disease/
python dict_match.py > dict_result.txt
