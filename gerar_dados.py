import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

import pandas as pd
import random
random.seed(42)

# ============================================================
# GERACAO DE DADOS SINTETIZADOS - Sistema de Triagem SNS24
# Projecto 1B - Tecnicas de Inteligencia Artificial
#
# Abordagem hibrida:
#   1. Casos garantidos - pelo menos 10 casos por regra especifica
#      para garantir cobertura total de todos os cenarios
#   2. Casos aleatorios - combinacoes aleatorias de sintomas com
#      resultado determinado pelo motor de inferencia (as nossas regras)
#
# Para executar: python gerar_dados.py
# Ficheiro gerado: triagem_dados.csv
# ============================================================

SINTOMAS = [
    'inconsciente', 'dificuldade_respiratoria_grave', 'hemorragia_grave',
    'entrou_algoritmo', 'covid_180_dias',
    'febre', 'febre_muito_alta', 'febre_grave', 'convulsao_febril',
    'desidratacao', 'sinais_meningite',
    'falta_ar_dispneia', 'obstrucao_via_aerea', 'respiracao_ruidosa',
    'tosse', 'expetoracao',
    'outros_sintomas', 'condicao_risco',
    'perda_olfato', 'causa_conhecida_olfato',
    'perda_paladar', 'causa_conhecida_paladar',
    'condicoes_casa',
]

# ============================================================
# MOTOR DE INFERENCIA
# Replica exatamente a logica da base_conhecimento.pl
# ============================================================

def inferir(s):
    # PRE-TRIAGEM: INEM
    if 'inconsciente' in s: return 'inem'
    if 'dificuldade_respiratoria_grave' in s: return 'inem'
    if 'hemorragia_grave' in s: return 'inem'
    if 'obstrucao_via_aerea' in s: return 'inem'

    # ADR-SU: factos isolados
    if 'febre_muito_alta' in s: return 'adr_su'
    if 'febre_grave' in s: return 'adr_su'
    if 'convulsao_febril' in s: return 'adr_su'
    if 'sinais_meningite' in s: return 'adr_su'
    if 'respiracao_ruidosa' in s: return 'adr_su'

    # ADR-SU: falta de ar com agravantes
    if 'falta_ar_dispneia' in s and 'febre' in s: return 'adr_su'
    if 'falta_ar_dispneia' in s and 'tosse' in s: return 'adr_su'
    if 'falta_ar_dispneia' in s and 'outros_sintomas' in s: return 'adr_su'
    if 'falta_ar_dispneia' in s and 'condicao_risco' in s: return 'adr_su'

    # ADR-SU: febre com combinacoes graves
    if 'febre' in s and 'tosse' in s and 'outros_sintomas' in s: return 'adr_su'
    if 'febre' in s and 'tosse' in s and 'condicao_risco' in s: return 'adr_su'
    if 'febre' in s and 'desidratacao' in s and 'outros_sintomas' in s: return 'adr_su'
    if 'febre' in s and 'desidratacao' in s and 'tosse' in s: return 'adr_su'
    if 'febre' in s and 'desidratacao' in s and 'condicao_risco' in s: return 'adr_su'

    # ADR-SU: tosse com expetoracao e agravantes
    if 'tosse' in s and 'expetoracao' in s and 'febre' in s: return 'adr_su'
    if 'tosse' in s and 'expetoracao' in s and 'outros_sintomas' in s: return 'adr_su'
    if 'tosse' in s and 'expetoracao' in s and 'condicao_risco' in s: return 'adr_su'

    # ADR-SU: outros sintomas com risco e agravantes
    if 'outros_sintomas' in s and 'condicao_risco' in s and 'febre' in s: return 'adr_su'
    if 'outros_sintomas' in s and 'condicao_risco' in s and 'tosse' in s: return 'adr_su'

    # ADR-CSP: falta de ar sozinha
    if ('falta_ar_dispneia' in s and
        'febre' not in s and 'tosse' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'

    # ADR-CSP: febre com agravantes moderados
    if 'febre' in s and 'desidratacao' in s and 'outros_sintomas' not in s and 'condicao_risco' not in s:
        return 'adr_csp'
    if 'febre' in s and 'tosse' in s and 'outros_sintomas' not in s and 'condicao_risco' not in s:
        return 'adr_csp'
    if 'febre' in s and 'outros_sintomas' in s and 'condicao_risco' not in s:
        return 'adr_csp'
    if 'febre' in s and 'condicao_risco' in s and 'tosse' not in s and 'outros_sintomas' not in s:
        return 'adr_csp'

    # ADR-CSP: tosse com agravantes moderados
    if ('tosse' in s and 'expetoracao' in s and
        'febre' not in s and 'falta_ar_dispneia' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'
    if 'tosse' in s and 'outros_sintomas' in s and 'condicao_risco' not in s:
        return 'adr_csp'
    if 'tosse' in s and 'condicao_risco' in s and 'outros_sintomas' not in s:
        return 'adr_csp'

    # ADR-CSP: outros sintomas com risco sem febre nem tosse
    if ('outros_sintomas' in s and 'condicao_risco' in s and
        'febre' not in s and 'tosse' not in s):
        return 'adr_csp'

    # ADR-CSP: perda olfato com agravantes
    if 'perda_olfato' in s and 'febre' in s: return 'adr_csp'
    if 'perda_olfato' in s and 'tosse' in s: return 'adr_csp'
    if 'perda_olfato' in s and 'outros_sintomas' in s: return 'adr_csp'
    if 'perda_olfato' in s and 'condicao_risco' in s: return 'adr_csp'

    # ADR-CSP: perda paladar com agravantes
    if 'perda_paladar' in s and 'febre' in s: return 'adr_csp'
    if 'perda_paladar' in s and 'tosse' in s: return 'adr_csp'
    if 'perda_paladar' in s and 'outros_sintomas' in s: return 'adr_csp'
    if 'perda_paladar' in s and 'condicao_risco' in s: return 'adr_csp'

    # ADR-CSP: sintomas sozinhos sem condicoes em casa
    if ('febre' in s and 'condicoes_casa' not in s and
        'tosse' not in s and 'desidratacao' not in s and
        'falta_ar_dispneia' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'
    if ('tosse' in s and 'condicoes_casa' not in s and
        'expetoracao' not in s and 'febre' not in s and
        'falta_ar_dispneia' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'
    if ('outros_sintomas' in s and 'condicoes_casa' not in s and
        'febre' not in s and 'tosse' not in s and
        'falta_ar_dispneia' not in s and 'condicao_risco' not in s):
        return 'adr_csp'
    if ('perda_olfato' in s and 'causa_conhecida_olfato' not in s and
        'condicoes_casa' not in s and
        'febre' not in s and 'tosse' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'
    if ('perda_paladar' in s and 'causa_conhecida_paladar' not in s and
        'condicoes_casa' not in s and
        'febre' not in s and 'tosse' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'adr_csp'

    # TRANSFERENCIA SNS24
    sintomas_entrada = {'febre', 'tosse', 'falta_ar_dispneia', 'perda_olfato', 'perda_paladar', 'outros_sintomas'}
    if 'entrou_algoritmo' not in s and not s.intersection(sintomas_entrada):
        return 'transferencia_sns24'
    if 'covid_180_dias' in s: return 'transferencia_sns24'
    if ('condicao_risco' in s and
        not s.intersection({'febre', 'tosse', 'falta_ar_dispneia',
                           'outros_sintomas', 'perda_olfato', 'perda_paladar'})):
        return 'transferencia_sns24'
    if 'perda_olfato' in s and 'causa_conhecida_olfato' in s: return 'transferencia_sns24'
    if 'perda_paladar' in s and 'causa_conhecida_paladar' in s: return 'transferencia_sns24'

    # AUTOCUIDADO
    if ('febre' in s and 'condicoes_casa' in s and
        'tosse' not in s and 'desidratacao' not in s and
        'falta_ar_dispneia' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'autocuidado'
    if ('tosse' in s and 'condicoes_casa' in s and
        'expetoracao' not in s and 'febre' not in s and
        'falta_ar_dispneia' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'autocuidado'
    if ('outros_sintomas' in s and 'condicoes_casa' in s and
        'febre' not in s and 'tosse' not in s and
        'falta_ar_dispneia' not in s and 'condicao_risco' not in s):
        return 'autocuidado'
    if ('perda_olfato' in s and 'condicoes_casa' in s and
        'causa_conhecida_olfato' not in s and
        'febre' not in s and 'tosse' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'autocuidado'
    if ('perda_paladar' in s and 'condicoes_casa' in s and
        'causa_conhecida_paladar' not in s and
        'febre' not in s and 'tosse' not in s and
        'outros_sintomas' not in s and 'condicao_risco' not in s):
        return 'autocuidado'

    # FALLBACK
    return 'adr_csp'

# ============================================================
# RESTRICOES DE FLUXO
#
# Garantem que os sintomas gerados sao consistentes com o
# fluxo real do algoritmo (ex: febre_muito_alta so pode
# existir se febre tambem existir)
# ============================================================

def aplicar_restricoes(s):
    """Aplica restricoes de fluxo para garantir consistencia."""
    # febre_muito_alta, febre_grave, convulsao_febril,
    # desidratacao, sinais_meningite so existem se febre existir
    if any(x in s for x in ['febre_muito_alta', 'febre_grave',
                             'convulsao_febril', 'desidratacao',
                             'sinais_meningite']):
        s.add('febre')

    # obstrucao_via_aerea e respiracao_ruidosa so existem
    # se falta_ar_dispneia existir
    if any(x in s for x in ['obstrucao_via_aerea', 'respiracao_ruidosa']):
        s.add('falta_ar_dispneia')

    # expetoracao so existe se tosse existir
    if 'expetoracao' in s:
        s.add('tosse')

    # causa_conhecida_olfato so existe se perda_olfato existir
    if 'causa_conhecida_olfato' in s:
        s.add('perda_olfato')

    # causa_conhecida_paladar so existe se perda_paladar existir
    if 'causa_conhecida_paladar' in s:
        s.add('perda_paladar')

    # se tem qualquer sintoma clinico, entrou_algoritmo = True
    sintomas_clinicos = {
        'febre', 'tosse', 'falta_ar_dispneia', 'perda_olfato',
        'perda_paladar', 'outros_sintomas', 'febre_muito_alta',
        'febre_grave', 'convulsao_febril', 'sinais_meningite',
        'desidratacao', 'respiracao_ruidosa', 'expetoracao',
        'condicao_risco'
    }
    if s.intersection(sintomas_clinicos):
        s.add('entrou_algoritmo')

    return s

# ============================================================
# 1. CASOS GARANTIDOS
# Pelo menos 10 casos por regra especifica para garantir
# cobertura total de todos os cenarios do sistema.
# ============================================================

casos_garantidos = []

def adicionar_garantidos(base, n=10):
    """Adiciona N casos com a combinacao base mais sintomas aleatorios."""
    adicionados = 0
    tentativas = 0
    while adicionados < n and tentativas < n * 50:
        tentativas += 1
        s = set(base)
        # Adiciona sintomas aleatorios extras (realismo)
        for sint in SINTOMAS:
            if sint not in s and random.random() < 0.15:
                s.add(sint)
        s = aplicar_restricoes(s)
        resultado = inferir(s)
        # So aceita se o resultado esperado e o correto
        esperado = inferir(set(base))
        if resultado == esperado:
            row = {sint: (1 if sint in s else 0) for sint in SINTOMAS}
            row['resultado'] = resultado
            casos_garantidos.append(row)
            adicionados += 1

# PRE-TRIAGEM: INEM
adicionar_garantidos({'inconsciente'})
adicionar_garantidos({'dificuldade_respiratoria_grave'})
adicionar_garantidos({'hemorragia_grave'})
adicionar_garantidos({'falta_ar_dispneia', 'obstrucao_via_aerea'})

# ADR-SU: factos isolados
adicionar_garantidos({'febre', 'febre_muito_alta'})
adicionar_garantidos({'febre', 'febre_grave'})
adicionar_garantidos({'febre', 'convulsao_febril'})
adicionar_garantidos({'febre', 'sinais_meningite'})
adicionar_garantidos({'falta_ar_dispneia', 'respiracao_ruidosa'})

# ADR-SU: falta de ar com agravantes
adicionar_garantidos({'falta_ar_dispneia', 'febre'})
adicionar_garantidos({'falta_ar_dispneia', 'tosse'})
adicionar_garantidos({'falta_ar_dispneia', 'outros_sintomas'})
adicionar_garantidos({'falta_ar_dispneia', 'condicao_risco'})

# ADR-SU: febre com combinacoes graves
adicionar_garantidos({'febre', 'tosse', 'outros_sintomas'})
adicionar_garantidos({'febre', 'tosse', 'condicao_risco'})
adicionar_garantidos({'febre', 'desidratacao', 'outros_sintomas'})
adicionar_garantidos({'febre', 'desidratacao', 'tosse'})
adicionar_garantidos({'febre', 'desidratacao', 'condicao_risco'})

# ADR-SU: tosse com expetoracao
adicionar_garantidos({'tosse', 'expetoracao', 'febre'})
adicionar_garantidos({'tosse', 'expetoracao', 'outros_sintomas'})
adicionar_garantidos({'tosse', 'expetoracao', 'condicao_risco'})

# ADR-SU: outros sintomas com risco
adicionar_garantidos({'outros_sintomas', 'condicao_risco', 'febre'})
adicionar_garantidos({'outros_sintomas', 'condicao_risco', 'tosse'})

# ADR-CSP
adicionar_garantidos({'falta_ar_dispneia'})
adicionar_garantidos({'febre', 'desidratacao'})
adicionar_garantidos({'febre', 'tosse'})
adicionar_garantidos({'febre', 'outros_sintomas'})
adicionar_garantidos({'febre', 'condicao_risco'})
adicionar_garantidos({'tosse', 'expetoracao'})
adicionar_garantidos({'tosse', 'outros_sintomas'})
adicionar_garantidos({'tosse', 'condicao_risco'})
adicionar_garantidos({'outros_sintomas', 'condicao_risco'})
adicionar_garantidos({'perda_olfato', 'febre'})
adicionar_garantidos({'perda_olfato', 'tosse'})
adicionar_garantidos({'perda_olfato', 'outros_sintomas'})
adicionar_garantidos({'perda_olfato', 'condicao_risco'})
adicionar_garantidos({'perda_paladar', 'febre'})
adicionar_garantidos({'perda_paladar', 'tosse'})
adicionar_garantidos({'perda_paladar', 'outros_sintomas'})
adicionar_garantidos({'perda_paladar', 'condicao_risco'})
adicionar_garantidos({'febre', 'entrou_algoritmo'})
adicionar_garantidos({'tosse', 'entrou_algoritmo'})
adicionar_garantidos({'outros_sintomas', 'entrou_algoritmo'})
adicionar_garantidos({'perda_olfato', 'entrou_algoritmo'})
adicionar_garantidos({'perda_paladar', 'entrou_algoritmo'})

# TRANSFERENCIA SNS24
adicionar_garantidos({'covid_180_dias', 'entrou_algoritmo'})
adicionar_garantidos({'condicao_risco', 'entrou_algoritmo'})
adicionar_garantidos({'perda_olfato', 'causa_conhecida_olfato', 'entrou_algoritmo'})
adicionar_garantidos({'perda_paladar', 'causa_conhecida_paladar', 'entrou_algoritmo'})

# AUTOCUIDADO
adicionar_garantidos({'febre', 'condicoes_casa', 'entrou_algoritmo'})
adicionar_garantidos({'tosse', 'condicoes_casa', 'entrou_algoritmo'})
adicionar_garantidos({'outros_sintomas', 'condicoes_casa', 'entrou_algoritmo'})
adicionar_garantidos({'perda_olfato', 'condicoes_casa', 'entrou_algoritmo'})
adicionar_garantidos({'perda_paladar', 'condicoes_casa', 'entrou_algoritmo'})

print(f'Casos garantidos gerados: {len(casos_garantidos)}')

# ============================================================
# 2. CASOS ALEATORIOS
# Combinacoes aleatorias de sintomas com resultado determinado
# pelo motor de inferencia. Garante variabilidade real.
# ============================================================

casos_aleatorios = []
N_ALEATORIOS = 500

tentativas = 0
while len(casos_aleatorios) < N_ALEATORIOS and tentativas < N_ALEATORIOS * 20:
    tentativas += 1

    # Gera combinacao aleatoria de sintomas
    s = set()
    for sint in SINTOMAS:
        if random.random() < 0.2:  # 20% de probabilidade por sintoma
            s.add(sint)

    # Aplica restricoes de fluxo
    s = aplicar_restricoes(s)

    # Determina o resultado pelas nossas regras
    resultado = inferir(s)

    row = {sint: (1 if sint in s else 0) for sint in SINTOMAS}
    row['resultado'] = resultado
    casos_aleatorios.append(row)

print(f'Casos aleatorios gerados: {len(casos_aleatorios)}')

# ============================================================
# JUNTAR E GUARDAR
# ============================================================

todos = casos_garantidos + casos_aleatorios
df = pd.DataFrame(todos)
df = df.sample(frac=1, random_state=42).reset_index(drop=True)
df.to_csv('triagem_dados.csv', index=False)

print()
print('============================================================')
print('  BASE DE DADOS GERADA - Triagem SNS24')
print('============================================================')
print(f'  Total de casos: {len(df)}')
print(f'    Casos garantidos: {len(casos_garantidos)}')
print(f'    Casos aleatorios: {len(casos_aleatorios)}')
print(f'  Features: {len(df.columns) - 1}')
print()
print('  Distribuicao por resultado:')
for resultado, count in df['resultado'].value_counts().items():
    perc = count * 100 // len(df)
    print(f'    {resultado:<35} {count} casos ({perc}%)')
print()
print('  Ficheiro guardado: triagem_dados.csv')
print('============================================================')