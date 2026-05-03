import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, classification_report

# ============================================================
# TREINO DO MODELO E GERACAO DE REGRAS PROLOG - Triagem SNS24
# Projecto 1B - Tecnicas de Inteligencia Artificial
#
# Processo:
#   1. Carrega triagem_dados.csv
#   2. Divide em treino (80%) e teste (20%)
#   3. Treina Decision Tree sem limite de profundidade
#   4. Avalia precisao do modelo
#   5. Extrai regras e converte para Prolog (encaminhamento_ml/1)
#   6. Guarda em regras_geradas.pl
#
# A Decision Tree foi escolhida porque as suas regras sao
# directamente traduziveis para regras de producao Prolog.
# ============================================================

print('============================================================')
print('  TREINO DO MODELO - Decision Tree')
print('============================================================')
print()

# 1. Carregar dados
df = pd.read_csv('triagem_dados.csv')
X = df.drop('resultado', axis=1)
y = df['resultado']
colunas = list(X.columns)

print(f'  Total de casos: {len(df)}')
print(f'  Features: {len(colunas)}')
print(f'  Classes: {sorted(y.unique())}')
print()

# 2. Dividir treino/teste
X_treino, X_teste, y_treino, y_teste = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y)

print(f'  Treino: {len(X_treino)} casos (80%)')
print(f'  Teste:  {len(X_teste)} casos (20%)')
print()

# 3. Treinar Decision Tree
modelo = DecisionTreeClassifier(
    random_state=42,
    max_depth=None,
    min_samples_split=2,
    min_samples_leaf=1
)
modelo.fit(X_treino, y_treino)
print('  Modelo treinado.')
print()

# 4. Avaliar
y_pred = modelo.predict(X_teste)
precisao = accuracy_score(y_teste, y_pred)
print(f'  Precisao no conjunto de teste: {precisao * 100:.1f}%')
print()
print('  Relatorio por classe:')
print(classification_report(y_teste, y_pred))

# 5. Extrair regras da arvore
arvore  = modelo.tree_
classes = modelo.classes_

def gerar_regras_prolog(arvore, classes, colunas):
    regras = []

    def percorrer(no, condicoes):
        if arvore.children_left[no] == -1:
            classe_idx = arvore.value[no][0].argmax()
            classe     = classes[classe_idx]
            if condicoes:
                corpo = ',\n    '.join(condicoes)
                regras.append(f'encaminhamento_ml({classe}) :-\n    {corpo}.')
        else:
            coluna = colunas[arvore.feature[no]]
            percorrer(
                arvore.children_right[no],
                condicoes + [f'sintoma({coluna})']
            )
            percorrer(
                arvore.children_left[no],
                condicoes + [f'\\+ sintoma({coluna})']
            )

    percorrer(0, [])
    return regras

regras = gerar_regras_prolog(arvore, classes, colunas)
print(f'  Total de regras Prolog geradas: {len(regras)}')
print()

# 6. Guardar ficheiro Prolog
with open('regras_geradas.pl', 'w', encoding='utf-8') as f:
    f.write('% ============================================================\n')
    f.write('% REGRAS GERADAS AUTOMATICAMENTE - Parte B\n')
    f.write('% Projecto 1B - Tecnicas de Inteligencia Artificial\n')
    f.write('%\n')
    f.write('% Geradas por: Decision Tree (sklearn)\n')
    f.write('% Algoritmo:   DecisionTreeClassifier sem limite de profundidade\n')
    f.write(f'% Precisao:    {precisao * 100:.1f}% no conjunto de teste\n')
    f.write(f'% Regras:      {len(regras)} regras de producao geradas\n')
    f.write('%\n')
    f.write('% Predicado usado: encaminhamento_ml/1\n')
    f.write('% (distinto de encaminhamento/1 das regras manuais - Parte A)\n')
    f.write('% ============================================================\n')
    f.write('\n')
    f.write(':- discontiguous encaminhamento_ml/1.\n')
    f.write('\n')

    for i, regra in enumerate(regras, 1):
        f.write(f'% Regra {i}\n')
        f.write(regra)
        f.write('\n\n')

print('  Ficheiro guardado: regras_geradas.pl')
print()
print('  Primeiras 3 regras geradas:')
print()
for r in regras[:3]:
    print(r)
    print()
print('============================================================')

# ============================================================
# 7. VISUALIZACAO DA ARVORE DE DECISAO
# ============================================================

from sklearn.tree import plot_tree
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(60, 30))
plot_tree(modelo,
          feature_names=colunas,
          class_names=sorted(y.unique()),
          filled=True,
          rounded=True,
          fontsize=6,
          ax=ax)
plt.title('Arvore de Decisao - Sistema de Triagem SNS24', fontsize=16)
plt.savefig('arvore_decisao.png', dpi=150, bbox_inches='tight')
plt.close()
print('  Imagem da arvore guardada: arvore_decisao.png')
print('============================================================')