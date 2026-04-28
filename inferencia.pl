% ============================================================
% SISTEMA DE INFERENCIA - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
%
% Contem:
%   1. Motor de inferencia principal
%   2. Sistema de explicacao (P1MAX)
%      - Dicionario de factos (texto legivel)
%      - Regras com justificacao clinica
%   3. Predicado de limpeza de sessao
%
% Carrega automaticamente:
%   base_conhecimento.pl
%   base_dados.pl
% ============================================================

:- consult('base_conhecimento.pl').
:- consult('base_dados.pl').
:- consult('certeza.pl').
:- consult('regras_geradas.pl').

% ============================================================
% INFERENCIA PRINCIPAL
% ============================================================

inferir(Resultado) :-
    encaminhamento(Resultado), !.

inferir(sem_resultado).

% ============================================================
% INFERENCIA ML - Parte B
%
% Usa as regras geradas automaticamente pela Decision Tree.
% Permite comparar com as regras manuais via comparar_todos/0.
% ============================================================

inferir_ml(Resultado) :-
    encaminhamento_ml(Resultado), !.

inferir_ml(sem_resultado).

% ============================================================
% INFERENCIA COM CERTEZA - P1MAX
%
% Devolve o resultado e o grau de certeza associado.
% Uso: inferir_com_certeza(Resultado, CF)
% ============================================================

inferir_com_certeza(Resultado, CF) :-
    encaminhamento(Resultado), !,
    calcular_certeza(Resultado, CF).

inferir_com_certeza(sem_resultado, 0.0).

% ============================================================
% LIMPAR SESSAO
% ============================================================

limpar :-
    retractall(sintoma(_)).

% ============================================================
% EXPLICACAO - P1MAX
%
% Mostra:
%   1. Factos clinicos recolhidos durante a triagem
%   2. A regra especifica que foi aplicada
%   3. Justificacao clinica do encaminhamento
% ============================================================

explicar(Resultado) :-
    nl,
    write('+------------------------------------------+'), nl,
    write('|         EXPLICACAO DO RESULTADO          |'), nl,
    write('+------------------------------------------+'), nl, nl,
    write('Factos recolhidos durante a triagem:'), nl,
    findall(S, sintoma(S), Sintomas),
    maplist(mostrar_facto, Sintomas),
    nl,
    mostrar_regra(Resultado),
    nl,
    mostrar_justificacao(Resultado),
    nl.

% ============================================================
% DICIONARIO DE FACTOS
%
% Factos de controlo interno nao sao mostrados ao utilizador.
% ============================================================

facto_interno(entrou_algoritmo).
facto_interno(tem_sintoma_entrada).

descricao_facto(inconsciente,
    'O utente esta inconsciente ou nao responde').
descricao_facto(dificuldade_respiratoria_grave,
    'Tem dificuldade respiratoria grave').
descricao_facto(hemorragia_grave,
    'Tem hemorragia grave').
descricao_facto(covid_180_dias,
    'Teve COVID-19 nos ultimos 180 dias').
descricao_facto(febre,
    'Tem febre acima de 38 graus').
descricao_facto(febre_muito_alta,
    'Tem febre muito alta (axilar >= 40C ou retal >= 41C)').
descricao_facto(febre_grave,
    'A febre dura mais de 48h ou nao melhora com medicacao').
descricao_facto(convulsao_febril,
    'Tem historico de convulsoes febreis').
descricao_facto(desidratacao,
    'Tem sinais de desidratacao (urina escura, boca seca, olhos encovados)').
descricao_facto(sinais_meningite,
    'Tem sinais de meningite (cefaleia, rigidez do pescoco, fotofobia ou manchas)').
descricao_facto(falta_ar_dispneia,
    'Tem falta de ar ou dificuldade em respirar (dispneia)').
descricao_facto(obstrucao_via_aerea,
    'Sente a garganta a fechar ou a lingua inchada').
descricao_facto(respiracao_ruidosa,
    'Tem respiracao ruidosa, retracoes no peito ou pieira').
descricao_facto(tosse,
    'Tem tosse nova, piorada ou persistente').
descricao_facto(expetoracao,
    'Tem expetoracao ou outros sintomas associados a tosse').
descricao_facto(outros_sintomas,
    'Tem outros sintomas (mialgias, dor abdominal, ardor ao urinar ou manchas)').
descricao_facto(condicao_risco,
    'Tem uma condicao de risco (gravidez, oncologia, imunodeficiencia, dialise, etc.)').
descricao_facto(perda_olfato,
    'Tem perda subita de olfato nos ultimos 7 dias').
descricao_facto(causa_conhecida_olfato,
    'A perda de olfato tem causa conhecida (quimioterapia, cirurgia ou traumatismo)').
descricao_facto(perda_paladar,
    'Tem perda ou alteracao subita do paladar nos ultimos 7 dias').
descricao_facto(causa_conhecida_paladar,
    'A perda de paladar tem causa conhecida (quimioterapia, cirurgia ou traumatismo)').
descricao_facto(condicoes_casa,
    'Tem condicoes para ficar em casa (telefone e apoio disponivel)').

mostrar_facto(S) :-
    ( facto_interno(S) ->
        true
    ; descricao_facto(S, Desc) ->
        format('  - ~w~n', [Desc])
    ;
        format('  - ~w~n', [S])
    ).

% ============================================================
% DICIONARIO DE REGRAS
%
% Mostra a regra especifica que foi aplicada com base
% nos factos presentes em memoria.
% ============================================================

mostrar_regra(inem) :-
    write('Regra aplicada:'), nl,
    ( sintoma(inconsciente) ->
        write('  Inconsciente ou sem resposta -> INEM')
    ; sintoma(dificuldade_respiratoria_grave) ->
        write('  Dificuldade respiratoria grave -> INEM')
    ; sintoma(hemorragia_grave) ->
        write('  Hemorragia grave -> INEM')
    ; sintoma(obstrucao_via_aerea) ->
        write('  Obstrucao da via aerea -> INEM')
    ;
        write('  Emergencia absoluta -> INEM')
    ), nl.

mostrar_regra(adr_su) :-
    write('Regra aplicada:'), nl,
    ( sintoma(febre_muito_alta) ->
        write('  Febre muito alta (>= 40C) -> ADR-SU')
    ; sintoma(febre_grave) ->
        write('  Febre persistente (> 48h ou sem melhoria) -> ADR-SU')
    ; sintoma(convulsao_febril) ->
        write('  Febre com historico de convulsoes febreis -> ADR-SU')
    ; sintoma(sinais_meningite) ->
        write('  Sinais de meningite -> ADR-SU')
    ; sintoma(respiracao_ruidosa) ->
        write('  Respiracao ruidosa ou retracoes no peito -> ADR-SU')
    ; sintoma(falta_ar_dispneia), sintoma(febre) ->
        write('  Falta de ar + Febre -> ADR-SU')
    ; sintoma(falta_ar_dispneia), sintoma(tosse) ->
        write('  Falta de ar + Tosse -> ADR-SU')
    ; sintoma(falta_ar_dispneia), sintoma(outros_sintomas) ->
        write('  Falta de ar + Outros sintomas -> ADR-SU')
    ; sintoma(falta_ar_dispneia), sintoma(condicao_risco) ->
        write('  Falta de ar + Condicao de risco -> ADR-SU')
    ; sintoma(febre), sintoma(tosse), sintoma(outros_sintomas) ->
        write('  Febre + Tosse + Outros sintomas -> ADR-SU')
    ; sintoma(febre), sintoma(tosse), sintoma(condicao_risco) ->
        write('  Febre + Tosse + Condicao de risco -> ADR-SU')
    ; sintoma(febre), sintoma(desidratacao), sintoma(outros_sintomas) ->
        write('  Febre + Desidratacao + Outros sintomas -> ADR-SU')
    ; sintoma(febre), sintoma(desidratacao), sintoma(condicao_risco) ->
        write('  Febre + Desidratacao + Condicao de risco -> ADR-SU')
    ; sintoma(tosse), sintoma(expetoracao), sintoma(febre) ->
        write('  Tosse + Expetoracao + Febre -> ADR-SU')
    ; sintoma(tosse), sintoma(expetoracao), sintoma(falta_ar_dispneia) ->
        write('  Tosse + Expetoracao + Falta de ar -> ADR-SU')
    ; sintoma(tosse), sintoma(expetoracao), sintoma(outros_sintomas) ->
        write('  Tosse + Expetoracao + Outros sintomas -> ADR-SU')
    ; sintoma(tosse), sintoma(expetoracao), sintoma(condicao_risco) ->
        write('  Tosse + Expetoracao + Condicao de risco -> ADR-SU')
    ; sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(febre) ->
        write('  Outros sintomas + Condicao de risco + Febre -> ADR-SU')
    ; sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(tosse) ->
        write('  Outros sintomas + Condicao de risco + Tosse -> ADR-SU')
    ;
        write('  Combinacao de sintomas graves -> ADR-SU')
    ), nl.

mostrar_regra(adr_csp) :-
    write('Regra aplicada:'), nl,
    ( sintoma(falta_ar_dispneia), \+ sintoma(febre), \+ sintoma(tosse),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Falta de ar sem agravantes -> ADR-CSP')
    ; sintoma(febre), sintoma(desidratacao),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Febre + Desidratacao -> ADR-CSP')
    ; sintoma(febre), sintoma(tosse),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Febre + Tosse -> ADR-CSP')
    ; sintoma(febre), sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Febre + Outros sintomas -> ADR-CSP')
    ; sintoma(febre), sintoma(condicao_risco),
      \+ sintoma(tosse), \+ sintoma(outros_sintomas) ->
        write('  Febre + Condicao de risco -> ADR-CSP')
    ; sintoma(tosse), sintoma(expetoracao),
      \+ sintoma(febre), \+ sintoma(falta_ar_dispneia),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Tosse + Expetoracao -> ADR-CSP')
    ; sintoma(tosse), sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Tosse + Outros sintomas -> ADR-CSP')
    ; sintoma(tosse), sintoma(condicao_risco), \+ sintoma(outros_sintomas) ->
        write('  Tosse + Condicao de risco -> ADR-CSP')
    ; sintoma(outros_sintomas), sintoma(condicao_risco),
      \+ sintoma(febre), \+ sintoma(tosse) ->
        write('  Outros sintomas + Condicao de risco -> ADR-CSP')
    ; sintoma(perda_olfato), sintoma(febre) ->
        write('  Perda de olfato + Febre -> ADR-CSP')
    ; sintoma(perda_olfato), sintoma(tosse) ->
        write('  Perda de olfato + Tosse -> ADR-CSP')
    ; sintoma(perda_olfato), sintoma(outros_sintomas) ->
        write('  Perda de olfato + Outros sintomas -> ADR-CSP')
    ; sintoma(perda_olfato), sintoma(condicao_risco) ->
        write('  Perda de olfato + Condicao de risco -> ADR-CSP')
    ; sintoma(perda_paladar), sintoma(febre) ->
        write('  Perda de paladar + Febre -> ADR-CSP')
    ; sintoma(perda_paladar), sintoma(tosse) ->
        write('  Perda de paladar + Tosse -> ADR-CSP')
    ; sintoma(perda_paladar), sintoma(outros_sintomas) ->
        write('  Perda de paladar + Outros sintomas -> ADR-CSP')
    ; sintoma(perda_paladar), sintoma(condicao_risco) ->
        write('  Perda de paladar + Condicao de risco -> ADR-CSP')
    ; sintoma(febre), \+ sintoma(condicoes_casa) ->
        write('  Febre sem condicoes para ficar em casa -> ADR-CSP')
    ; sintoma(tosse), \+ sintoma(condicoes_casa) ->
        write('  Tosse sem condicoes para ficar em casa -> ADR-CSP')
    ; sintoma(outros_sintomas), \+ sintoma(condicoes_casa) ->
        write('  Outros sintomas sem condicoes para ficar em casa -> ADR-CSP')
    ; sintoma(perda_olfato), \+ sintoma(condicoes_casa) ->
        write('  Perda de olfato sem condicoes para ficar em casa -> ADR-CSP')
    ; sintoma(perda_paladar), \+ sintoma(condicoes_casa) ->
        write('  Perda de paladar sem condicoes para ficar em casa -> ADR-CSP')
    ; sintoma(entrou_algoritmo) ->
        write('  Sem sintomas especificos identificados (fallback) -> ADR-CSP')
    ;
        write('  Sintomas que requerem observacao medica -> ADR-CSP')
    ), nl.

mostrar_regra(transferencia_sns24) :-
    write('Regra aplicada:'), nl,
    ( \+ sintoma(entrou_algoritmo) ->
        write('  Sem sintomas de entrada no algoritmo -> Transferencia SNS24')
    ; sintoma(covid_180_dias) ->
        write('  COVID-19 nos ultimos 180 dias -> Transferencia SNS24')
    ; sintoma(condicao_risco),
      \+ sintoma(febre), \+ sintoma(tosse),
      \+ sintoma(falta_ar_dispneia), \+ sintoma(outros_sintomas),
      \+ sintoma(perda_olfato), \+ sintoma(perda_paladar) ->
        write('  Condicao de risco sem sintomas de entrada -> Transferencia SNS24')
    ; sintoma(perda_olfato), sintoma(causa_conhecida_olfato) ->
        write('  Perda de olfato com causa conhecida -> Transferencia SNS24')
    ; sintoma(perda_paladar), sintoma(causa_conhecida_paladar) ->
        write('  Perda de paladar com causa conhecida -> Transferencia SNS24')
    ;
        write('  Situacao requer outro fluxo SNS24 -> Transferencia SNS24')
    ), nl.

mostrar_regra(autocuidado) :-
    write('Regra aplicada:'), nl,
    ( sintoma(febre), sintoma(condicoes_casa) ->
        write('  Febre leve + Condicoes em casa -> Autocuidado')
    ; sintoma(tosse), sintoma(condicoes_casa) ->
        write('  Tosse + Condicoes em casa -> Autocuidado')
    ; sintoma(outros_sintomas), sintoma(condicoes_casa) ->
        write('  Outros sintomas + Condicoes em casa -> Autocuidado')
    ; sintoma(perda_olfato), sintoma(condicoes_casa) ->
        write('  Perda de olfato sem causa conhecida + Condicoes em casa -> Autocuidado')
    ; sintoma(perda_paladar), sintoma(condicoes_casa) ->
        write('  Perda de paladar sem causa conhecida + Condicoes em casa -> Autocuidado')
    ;
        write('  Sintomas leves com condicoes em casa -> Autocuidado')
    ), nl.

mostrar_regra(sem_resultado) :-
    write('Regra aplicada:'), nl,
    write('  Nao foi possivel determinar uma regra aplicavel.'), nl.

% ============================================================
% JUSTIFICACOES CLINICAS
%
% Explica em linguagem natural o raciocinio clinico
% por tras do encaminhamento determinado.
% ============================================================

mostrar_justificacao(inem) :-
    write('Justificacao:'), nl,
    ( sintoma(inconsciente) ->
        write('  Um utente inconsciente ou sem resposta pode estar em'), nl,
        write('  paragem cardiorespiratoria ou choque grave. Requer'), nl,
        write('  intervencao de emergencia imediata pelo INEM.')
    ; sintoma(dificuldade_respiratoria_grave) ->
        write('  Dificuldade respiratoria grave indica compromisso'), nl,
        write('  imediato da via aerea ou funcao pulmonar. Sem'), nl,
        write('  intervencao rapida pode ser fatal.')
    ; sintoma(hemorragia_grave) ->
        write('  Hemorragia grave pode causar choque hipovolemico'), nl,
        write('  rapidamente. Requer controlo imediato e suporte'), nl,
        write('  avancado de vida pelo INEM.')
    ; sintoma(obstrucao_via_aerea) ->
        write('  Sensacao de garganta a fechar ou lingua inchada'), nl,
        write('  indica obstrucao da via aerea, possivelmente por'), nl,
        write('  reacao alergica grave (anafilaxia). Situacao fatal'), nl,
        write('  sem intervencao imediata.')
    ;
        write('  Situacao de emergencia com risco de vida imediato.')
    ), nl.

mostrar_justificacao(adr_su) :-
    write('Justificacao:'), nl,
    ( sintoma(febre_muito_alta) ->
        write('  Febre muito alta (>= 40C) pode causar convulsoes,'), nl,
        write('  lesao cerebral e falencia de orgaos. Requer avaliacao'), nl,
        write('  e tratamento hospitalar urgente.')
    ; sintoma(febre_grave) ->
        write('  Febre persistente ha mais de 48h ou que nao responde'), nl,
        write('  a medicacao pode indicar infecao grave ou sepsis,'), nl,
        write('  requerendo avaliacao hospitalar urgente.')
    ; sintoma(convulsao_febril) ->
        write('  Historico de convulsoes febreis com febre activa'), nl,
        write('  aumenta o risco de nova convulsao. Requer vigilancia'), nl,
        write('  e avaliacao hospitalar urgente.')
    ; sintoma(sinais_meningite) ->
        write('  Cefaleia intensa, rigidez do pescoco e fotofobia'), nl,
        write('  sao sinais classicos de meningite, doenca grave que'), nl,
        write('  requer antibioterapia hospitalar imediata.')
    ; sintoma(respiracao_ruidosa) ->
        write('  Respiracao ruidosa, retracoes ou pieira indicam'), nl,
        write('  obstrucao significativa das vias aereas. Requer'), nl,
        write('  avaliacao e tratamento hospitalar urgente.')
    ; sintoma(falta_ar_dispneia) ->
        write('  Falta de ar combinada com outros sintomas agravantes'), nl,
        write('  indica compromisso respiratorio significativo com'), nl,
        write('  risco elevado de deterioracao rapida.')
    ; sintoma(febre), sintoma(desidratacao) ->
        write('  Febre com desidratacao e sintomas adicionais indica'), nl,
        write('  doenca sistemica grave com risco de complicacoes'), nl,
        write('  serias, especialmente em grupos de risco.')
    ; sintoma(tosse), sintoma(expetoracao) ->
        write('  Tosse com expetoracao e sintomas agravantes pode'), nl,
        write('  indicar pneumonia ou infecao respiratoria grave,'), nl,
        write('  requerendo avaliacao hospitalar.')
    ; sintoma(outros_sintomas), sintoma(condicao_risco) ->
        write('  A presenca de uma condicao de risco (ex: oncologia,'), nl,
        write('  gravidez, imunodeficiencia) agrava significativamente'), nl,
        write('  qualquer infecao, requerendo avaliacao hospitalar urgente.')
    ;
        write('  A combinacao de sintomas presentes indica situacao'), nl,
        write('  de gravidade elevada que requer avaliacao hospitalar urgente.')
    ), nl.

mostrar_justificacao(adr_csp) :-
    write('Justificacao:'), nl,
    ( sintoma(falta_ar_dispneia),
      \+ sintoma(febre), \+ sintoma(tosse),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Falta de ar isolada, sem outros agravantes, requer'), nl,
        write('  avaliacao medica para identificar a causa, mas nao'), nl,
        write('  constitui emergencia hospitalar imediata.')
    ; sintoma(febre), sintoma(desidratacao),
      \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco) ->
        write('  Febre com sinais de desidratacao requer observacao'), nl,
        write('  medica para reidratacao e avaliacao da causa,'), nl,
        write('  sem gravidade suficiente para urgencia hospitalar.')
    ; sintoma(febre), sintoma(condicao_risco) ->
        write('  A presenca de uma condicao de risco exige que mesmo'), nl,
        write('  uma febre simples seja avaliada por um medico, dada'), nl,
        write('  a maior vulnerabilidade do utente a complicacoes.')
    ; sintoma(perda_olfato), \+ sintoma(condicoes_casa) ->
        write('  Perda subita de olfato sem condicoes para ficar em'), nl,
        write('  casa requer observacao no centro de saude para'), nl,
        write('  garantir acompanhamento adequado.')
    ; sintoma(perda_olfato) ->
        write('  Perda subita de olfato com sintomas associados pode'), nl,
        write('  indicar infecao respiratoria que requer avaliacao'), nl,
        write('  medica presencial.')
    ; sintoma(perda_paladar), \+ sintoma(condicoes_casa) ->
        write('  Perda subita de paladar sem condicoes para ficar em'), nl,
        write('  casa requer observacao no centro de saude para'), nl,
        write('  garantir acompanhamento adequado.')
    ; sintoma(perda_paladar) ->
        write('  Perda subita de paladar com sintomas associados pode'), nl,
        write('  indicar infecao respiratoria que requer avaliacao'), nl,
        write('  medica presencial.')
    ; \+ sintoma(condicoes_casa) ->
        write('  Sem condicoes para ficar em casa com seguranca,'), nl,
        write('  o utente deve ser observado no centro de saude'), nl,
        write('  para garantir acompanhamento adequado.')
    ; sintoma(entrou_algoritmo) ->
        write('  O utente indicou ter sintomas de entrada mas nao'), nl,
        write('  foi possivel identificar sintomas especificos durante'), nl,
        write('  a triagem. Por precaucao, recomenda-se observacao'), nl,
        write('  no centro de saude.')
    ;
        write('  Os sintomas presentes requerem avaliacao medica'), nl,
        write('  mas nao constituem emergencia hospitalar. O centro'), nl,
        write('  de saude e o local adequado para esta situacao.')
    ), nl.

mostrar_justificacao(transferencia_sns24) :-
    write('Justificacao:'), nl,
    ( \+ sintoma(entrou_algoritmo) ->
        write('  O utente nao apresenta nenhum dos sintomas de entrada'), nl,
        write('  do algoritmo de triagem respiratoria. A sua situacao'), nl,
        write('  requer avaliacao noutro fluxo de atendimento SNS24.')
    ; sintoma(covid_180_dias) ->
        write('  Ter tido COVID-19 nos ultimos 180 dias pode alterar'), nl,
        write('  a apresentacao clinica dos sintomas. O utente deve'), nl,
        write('  ser avaliado num fluxo especifico para esta situacao.')
    ; sintoma(perda_olfato), sintoma(causa_conhecida_olfato) ->
        write('  A perda de olfato tem causa conhecida (quimioterapia,'), nl,
        write('  cirurgia ou traumatismo), nao relacionada com infecao'), nl,
        write('  respiratoria. O utente deve ser encaminhado para o'), nl,
        write('  especialista adequado (ex: otorrinolaringologista).')
    ; sintoma(perda_paladar), sintoma(causa_conhecida_paladar) ->
        write('  A perda de paladar tem causa conhecida (quimioterapia,'), nl,
        write('  cirurgia ou traumatismo), nao relacionada com infecao'), nl,
        write('  respiratoria. O utente deve ser encaminhado para o'), nl,
        write('  especialista adequado.')
    ; sintoma(condicao_risco) ->
        write('  A condicao de risco sem sintomas respiratorios activos'), nl,
        write('  requer acompanhamento especifico no fluxo adequado,'), nl,
        write('  nao sendo aplicavel o algoritmo de triagem respiratoria.')
    ;
        write('  A situacao do utente nao se enquadra neste algoritmo'), nl,
        write('  e requer avaliacao noutro fluxo de atendimento SNS24.')
    ), nl.

mostrar_justificacao(autocuidado) :-
    write('Justificacao:'), nl,
    ( sintoma(febre) ->
        write('  Febre leve sem agravantes, em utente com condicoes'), nl,
        write('  para ficar em casa, pode ser gerida com repouso,'), nl,
        write('  hidratacao e antipireticos. Deve contactar o SNS24'), nl,
        write('  se a febre subir ou surgirem novos sintomas.')
    ; sintoma(tosse) ->
        write('  Tosse sem expetoracao nem agravantes, em utente com'), nl,
        write('  condicoes em casa, pode ser gerida com repouso e'), nl,
        write('  hidratacao. Deve contactar o SNS24 se piorar.')
    ; sintoma(perda_olfato) ->
        write('  Perda de olfato sem causa conhecida e sem outros'), nl,
        write('  sintomas, com condicoes em casa, sugere possivel'), nl,
        write('  infecao leve. Deve manter isolamento e contactar'), nl,
        write('  o SNS24 se surgirem novos sintomas.')
    ; sintoma(perda_paladar) ->
        write('  Perda de paladar sem causa conhecida e sem outros'), nl,
        write('  sintomas, com condicoes em casa, sugere possivel'), nl,
        write('  infecao leve. Deve manter isolamento e contactar'), nl,
        write('  o SNS24 se surgirem novos sintomas.')
    ;
        write('  Os sintomas sao leves e o utente tem condicoes para'), nl,
        write('  se tratar em casa em seguranca. Deve contactar o'), nl,
        write('  SNS24 (808 24 24 24) se os sintomas agravarem.')
    ), nl.

mostrar_justificacao(sem_resultado) :-
    write('Justificacao:'), nl,
    write('  Nao foi possivel determinar um encaminhamento com base'), nl,
    write('  nos sintomas registados. Contacte o SNS24 para assistencia.'), nl.