from data_utils import DataPrepare

ttt = DataPrepare('../data/conll2003/train.txt')
sentences = ttt.read_unlabeled_data('../data/conll2003/train.txt')
print(sentences)