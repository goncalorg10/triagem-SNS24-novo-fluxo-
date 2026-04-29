% ============================================================
% REGRAS GERADAS AUTOMATICAMENTE - Parte B
% Projecto 1B - Tecnicas de Inteligencia Artificial
%
% Geradas por: Decision Tree (sklearn)
% Algoritmo:   DecisionTreeClassifier sem limite de profundidade
% Precisao:    100.0% no conjunto de teste
% Regras:      42 regras de producao geradas
%
% Predicado usado: encaminhamento_ml/1
% (distinto de encaminhamento/1 das regras manuais - Parte A)
% ============================================================

:- discontiguous encaminhamento_ml/1.

% Regra 1
encaminhamento_ml(autocuidado) :-
    sintoma(condicoes_casa).

% Regra 2
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    sintoma(perda_paladar).

% Regra 3
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    sintoma(perda_olfato).

% Regra 4
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    sintoma(febre_muito_alta).

% Regra 5
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    sintoma(febre_grave).

% Regra 6
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    sintoma(falta_ar_dispneia).

% Regra 7
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    sintoma(outros_sintomas).

% Regra 8
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(condicao_risco).

% Regra 9
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco),
    sintoma(desidratacao).

% Regra 10
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco),
    \+ sintoma(desidratacao),
    sintoma(expetoracao).

% Regra 11
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco),
    \+ sintoma(desidratacao),
    \+ sintoma(expetoracao).

% Regra 12
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    sintoma(sinais_meningite).

% Regra 13
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    sintoma(convulsao_febril).

% Regra 14
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    sintoma(outros_sintomas),
    sintoma(desidratacao).

% Regra 15
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    sintoma(outros_sintomas),
    \+ sintoma(desidratacao),
    sintoma(condicao_risco).

% Regra 16
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    sintoma(outros_sintomas),
    \+ sintoma(desidratacao),
    \+ sintoma(condicao_risco).

% Regra 17
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    \+ sintoma(outros_sintomas),
    sintoma(desidratacao),
    sintoma(condicao_risco).

% Regra 18
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    \+ sintoma(outros_sintomas),
    sintoma(desidratacao),
    \+ sintoma(condicao_risco).

% Regra 19
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    sintoma(febre),
    \+ sintoma(perda_paladar),
    \+ sintoma(perda_olfato),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(sinais_meningite),
    \+ sintoma(convulsao_febril),
    \+ sintoma(outros_sintomas),
    \+ sintoma(desidratacao).

% Regra 20
encaminhamento_ml(inem) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    sintoma(obstrucao_via_aerea).

% Regra 21
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    \+ sintoma(obstrucao_via_aerea),
    sintoma(condicao_risco).

% Regra 22
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(condicao_risco),
    sintoma(outros_sintomas).

% Regra 23
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    sintoma(tosse).

% Regra 24
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    \+ sintoma(tosse),
    sintoma(respiracao_ruidosa).

% Regra 25
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    sintoma(falta_ar_dispneia),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    \+ sintoma(tosse),
    \+ sintoma(respiracao_ruidosa).

% Regra 26
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    sintoma(covid_180_dias).

% Regra 27
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    sintoma(causa_conhecida_olfato).

% Regra 28
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    sintoma(causa_conhecida_paladar).

% Regra 29
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(expetoracao),
    sintoma(outros_sintomas).

% Regra 30
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(expetoracao),
    \+ sintoma(outros_sintomas),
    sintoma(condicao_risco).

% Regra 31
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(expetoracao),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).

% Regra 32
encaminhamento_ml(adr_su) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    sintoma(outros_sintomas),
    sintoma(tosse).

% Regra 33
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    sintoma(outros_sintomas),
    \+ sintoma(tosse).

% Regra 34
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    sintoma(perda_olfato).

% Regra 35
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    \+ sintoma(perda_olfato),
    sintoma(tosse).

% Regra 36
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    \+ sintoma(perda_olfato),
    \+ sintoma(tosse),
    sintoma(perda_paladar).

% Regra 37
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco),
    \+ sintoma(outros_sintomas),
    \+ sintoma(perda_olfato),
    \+ sintoma(tosse),
    \+ sintoma(perda_paladar).

% Regra 38
encaminhamento_ml(adr_csp) :-
    \+ sintoma(condicoes_casa),
    sintoma(entrou_algoritmo),
    \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao),
    \+ sintoma(condicao_risco).

% Regra 39
encaminhamento_ml(inem) :-
    \+ sintoma(condicoes_casa),
    \+ sintoma(entrou_algoritmo),
    sintoma(inconsciente).

% Regra 40
encaminhamento_ml(inem) :-
    \+ sintoma(condicoes_casa),
    \+ sintoma(entrou_algoritmo),
    \+ sintoma(inconsciente),
    sintoma(dificuldade_respiratoria_grave).

% Regra 41
encaminhamento_ml(inem) :-
    \+ sintoma(condicoes_casa),
    \+ sintoma(entrou_algoritmo),
    \+ sintoma(inconsciente),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(hemorragia_grave).

% Regra 42
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(condicoes_casa),
    \+ sintoma(entrou_algoritmo),
    \+ sintoma(inconsciente),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(hemorragia_grave).

