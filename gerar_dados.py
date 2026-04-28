import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

import pandas as pd
import random
random.seed(42)

# ============================================================
# GERACAO DE DADOS SINTETIZADOS - Sistema de Triagem SNS24
# Projecto 1B - Tecnicas de Inteligencia Artificial
#
# Gera 500 casos de triagem consistentes com o fluxo do
# algoritmo SNS24 (Protocolo Altitude - Sintomaticos).
#
# Cada linha representa um utente com os seus sintomas (0/1)
# e o resultado esperado do encaminhamento.
#
# Factos de controlo:
#   entrou_algoritmo - passou a pre-triagem e tem pelo menos
#                      um sintoma de entrada no algoritmo
#
# Para executar: python gerar_dados.py
# Ficheiro gerado: triagem_dados.csv
# ============================================================

casos = []

def caso(
    # PRE-TRIAGEM
    inconsciente, dificuldade_respiratoria_grave, hemorragia_grave,
    # CONTROLO
    entrou_algoritmo,
    # Q1
    covid_180_dias,
    # BLOCO FEBRE
    febre, febre_muito_alta, febre_grave, convulsao_febril,
    desidratacao, sinais_meningite,
    # BLOCO RESPIRATORIO
    falta_ar_dispneia, obstrucao_via_aerea, respiracao_ruidosa,
    # BLOCO TOSSE
    tosse, expetoracao,
    # BLOCO OUTROS SINTOMAS
    outros_sintomas, condicao_risco,
    # BLOCO OLFATO/PALADAR
    perda_olfato, causa_conhecida_olfato,
    perda_paladar, causa_conhecida_paladar,
    # BLOCO SOCIAL
    condicoes_casa,
    # RESULTADO
    resultado):

    casos.append({
        'inconsciente':                  inconsciente,
        'dificuldade_respiratoria_grave': dificuldade_respiratoria_grave,
        'hemorragia_grave':              hemorragia_grave,
        'entrou_algoritmo':              entrou_algoritmo,
        'covid_180_dias':                covid_180_dias,
        'febre':                         febre,
        'febre_muito_alta':              febre_muito_alta,
        'febre_grave':                   febre_grave,
        'convulsao_febril':              convulsao_febril,
        'desidratacao':                  desidratacao,
        'sinais_meningite':              sinais_meningite,
        'falta_ar_dispneia':             falta_ar_dispneia,
        'obstrucao_via_aerea':           obstrucao_via_aerea,
        'respiracao_ruidosa':            respiracao_ruidosa,
        'tosse':                         tosse,
        'expetoracao':                   expetoracao,
        'outros_sintomas':               outros_sintomas,
        'condicao_risco':                condicao_risco,
        'perda_olfato':                  perda_olfato,
        'causa_conhecida_olfato':        causa_conhecida_olfato,
        'perda_paladar':                 perda_paladar,
        'causa_conhecida_paladar':       causa_conhecida_paladar,
        'condicoes_casa':                condicoes_casa,
        'resultado':                     resultado
    })

# Guia de leitura dos argumentos:
# caso(incons, dif_resp, hemorr,
#      entrou,
#      covid,
#      febre, febre_alta, febre_grave, conv_febril, desidrat, sinais_mening,
#      falta_ar, obstr_via, resp_ruidosa,
#      tosse, expet,
#      outros, cond_risco,
#      perda_olf, causa_olf, perda_pal, causa_pal,
#      cond_casa,
#      resultado)

# ============================================================
# PRE-TRIAGEM => INEM (75 casos)
# ============================================================
for _ in range(25):
    caso(1,0,0, 0, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'inem')
for _ in range(25):
    caso(0,1,0, 0, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'inem')
for _ in range(25):
    caso(0,0,1, 0, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'inem')

# ============================================================
# SEM SINTOMAS DE ENTRADA => TRANSFERENCIA (25 casos)
# ============================================================
for _ in range(25):
    caso(0,0,0, 0, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'transferencia_sns24')

# ============================================================
# Q1: COVID 180 DIAS => TRANSFERENCIA (25 casos)
# ============================================================
for _ in range(25):
    caso(0,0,0, 1, 1, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'transferencia_sns24')

# ============================================================
# BLOCO FEBRE => ADR-SU
# ============================================================

# Febre muito alta (25 casos)
for _ in range(25):
    caso(0,0,0, 1, 0, 1,1,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Febre grave > 48h (25 casos)
for _ in range(25):
    caso(0,0,0, 1, 0, 1,0,1,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Convulsao febril (20 casos)
for _ in range(20):
    caso(0,0,0, 1, 0, 1,0,0,1,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Sinais de meningite (20 casos)
for _ in range(20):
    caso(0,0,0, 1, 0, 1,0,0,0,0,1, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Falta de ar + febre (20 casos)
for _ in range(20):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 1,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Falta de ar + tosse (20 casos)
for _ in range(20):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,0,0, 1,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Falta de ar + outros sintomas (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,0,0, 0,0, 1,0, 0,0,0,0, 0, 'adr_su')

# Falta de ar + condicao risco (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,0,0, 0,0, 0,1, 0,0,0,0, 0, 'adr_su')

# Febre + tosse + outros sintomas (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 1,0, 1,0, 0,0,0,0, 0, 'adr_su')

# Febre + tosse + condicao risco (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 1,0, 0,1, 0,0,0,0, 0, 'adr_su')

# Febre + desidratacao + outros sintomas (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,1,0, 0,0,0, 0,0, 1,0, 0,0,0,0, 0, 'adr_su')

# Febre + desidratacao + tosse (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,1,0, 0,0,0, 1,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Febre + desidratacao + condicao risco (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,1,0, 0,0,0, 0,0, 0,1, 0,0,0,0, 0, 'adr_su')

# Tosse + expetoracao + febre (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 1,1, 0,0, 0,0,0,0, 0, 'adr_su')

# Tosse + expetoracao + outros sintomas (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,1, 1,0, 0,0,0,0, 0, 'adr_su')

# Tosse + expetoracao + condicao risco (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,1, 0,1, 0,0,0,0, 0, 'adr_su')

# Outros sintomas + condicao risco + febre (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 1,1, 0,0,0,0, 0, 'adr_su')

# Outros sintomas + condicao risco + tosse (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 1,1, 0,0,0,0, 0, 'adr_su')

# Respiracao ruidosa - so e perguntada se tem falta_ar_dispneia (Q8=sim)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,0,1, 0,0, 0,0, 0,0,0,0, 0, 'adr_su')

# Obstrucao via aerea => INEM - so e perguntada se tem falta_ar_dispneia (Q8=sim)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,1,0, 0,0, 0,0, 0,0,0,0, 0, 'inem')

# ============================================================
# ADR-CSP
# ============================================================

# Falta de ar sozinha (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 1,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_csp')

# Febre + desidratacao sem agravantes (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,1,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_csp')

# Febre + tosse sem agravantes (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 1,0, 0,0, 0,0,0,0, 0, 'adr_csp')

# Febre + outros sintomas sem condicao risco (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 1,0, 0,0,0,0, 0, 'adr_csp')

# Febre + condicao risco sem tosse nem outros (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 0,1, 0,0,0,0, 0, 'adr_csp')

# Tosse + expetoracao sem agravantes (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,1, 0,0, 0,0,0,0, 0, 'adr_csp')

# Tosse + outros sintomas sem condicao risco (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 1,0, 0,0,0,0, 0, 'adr_csp')

# Tosse + condicao risco sem outros sintomas (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 0,1, 0,0,0,0, 0, 'adr_csp')

# Outros sintomas + condicao risco sem febre nem tosse (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 1,1, 0,0,0,0, 0, 'adr_csp')

# Perda olfato + febre (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 0,0, 1,0,0,0, 0, 'adr_csp')

# Perda olfato + tosse (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 0,0, 1,0,0,0, 0, 'adr_csp')

# Perda olfato + outros sintomas (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 1,0, 1,0,0,0, 0, 'adr_csp')

# Perda olfato + condicao risco (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,1, 1,0,0,0, 0, 'adr_csp')

# Perda paladar + febre (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,1,0, 0, 'adr_csp')

# Perda paladar + tosse (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 0,0, 0,0,1,0, 0, 'adr_csp')

# Perda paladar + outros sintomas (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 1,0, 0,0,1,0, 0, 'adr_csp')

# Perda paladar + condicao risco (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,1, 0,0,1,0, 0, 'adr_csp')

# Febre sozinha sem condicoes em casa (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 0, 'adr_csp')

# Tosse sozinha sem condicoes em casa (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 0,0, 0,0,0,0, 0, 'adr_csp')

# Outros sintomas sozinhos sem condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 1,0, 0,0,0,0, 0, 'adr_csp')

# Perda olfato sem causa conhecida, sem condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 1,0,0,0, 0, 'adr_csp')

# Perda paladar sem causa conhecida, sem condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,1,0, 0, 'adr_csp')

# ============================================================
# TRANSFERENCIA SNS24
# ============================================================

# Condicao risco sem sintomas de entrada (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,1, 0,0,0,0, 0, 'transferencia_sns24')

# Perda olfato com causa conhecida (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 1,1,0,0, 0, 'transferencia_sns24')

# Perda paladar com causa conhecida (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,1,1, 0, 'transferencia_sns24')

# ============================================================
# AUTOCUIDADO (com condicoes em casa)
# ============================================================

# Febre sozinha com condicoes em casa (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 1,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,0,0, 1, 'autocuidado')

# Tosse sozinha com condicoes em casa (15 casos)
for _ in range(15):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 1,0, 0,0, 0,0,0,0, 1, 'autocuidado')

# Outros sintomas com condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 1,0, 0,0,0,0, 1, 'autocuidado')

# Perda olfato sem causa conhecida com condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 1,0,0,0, 1, 'autocuidado')

# Perda paladar sem causa conhecida com condicoes em casa (10 casos)
for _ in range(10):
    caso(0,0,0, 1, 0, 0,0,0,0,0,0, 0,0,0, 0,0, 0,0, 0,0,1,0, 1, 'autocuidado')

# ============================================================
# GUARDAR CSV
# ============================================================

df = pd.DataFrame(casos)
df = df.sample(frac=1, random_state=42).reset_index(drop=True)
df.to_csv('triagem_dados.csv', index=False)

print('============================================================')
print('  BASE DE DADOS GERADA - Triagem SNS24')
print('============================================================')
print(f'  Total de casos: {len(df)}')
print(f'  Features: {len(df.columns) - 1}')
print()
print('  Distribuicao por resultado:')
for resultado, count in df['resultado'].value_counts().items():
    print(f'    {resultado:<35} {count} casos')
print()
print('  Ficheiro guardado: triagem_dados.csv')
print('============================================================')