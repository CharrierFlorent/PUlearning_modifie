import sys
import random
if len(sys.argv) < 3 :
	print('usage : python3 ', sys.argv[0], ' <nom_du_fichier> <ratio du dico complet utilise> [nom entite]')
	exit(1)
if len(sys.argv) == 4 :
	entity_name = '-'+str(sys.argv[3])
	dico = open(str(sys.argv[3])+'.txt','w')
else:
	entity_name = ''
	dico = open("dictionnaire.txt",'w')

dico_ratio = float(sys.argv[2])
f = open(sys.argv[1])
entity = ''
entity_set = set()
updated = False

for line in f:
	words = line.split()
	if len(words) < 1:
		continue
	if words[1] == 'B'+entity_name : 
		entity = words[0]
		updated = True
	elif words[1] == 'I'+entity_name :
		entity = entity  + ' ' + words[0]
		updated = True
	else:
		if updated:
			entity_set.add(entity)
		updated = False
f.close()

for unique_entite in entity_set:
	if random.random() < dico_ratio:
		print(unique_entite, file=dico)
dico.close()
