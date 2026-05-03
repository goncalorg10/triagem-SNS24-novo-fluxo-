% ============================================================
% REGRAS GERADAS AUTOMATICAMENTE - Parte B
% Projecto 1B - Tecnicas de Inteligencia Artificial
%
% Geradas por: Decision Tree (sklearn)
% Algoritmo:   DecisionTreeClassifier sem limite de profundidade
% Precisao:    95.2% no conjunto de teste
% Regras:      66 regras de producao geradas
%
% Predicado usado: encaminhamento_ml/1
% (distinto de encaminhamento/1 das regras manuais - Parte A)
% ============================================================

:- discontiguous encaminhamento_ml/1.

% Regra 1
encaminhamento_ml(inem) :-
    sintoma(hemorragia_grave).

% Regra 2
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    sintoma(obstrucao_via_aerea).

% Regra 3
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    sintoma(inconsciente).

% Regra 4
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    sintoma(dificuldade_respiratoria_grave).

% Regra 5
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(falta_ar_dispneia).

% Regra 6
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(convulsao_febril).

% Regra 7
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    sintoma(febre_muito_alta).

% Regra 8
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    sintoma(febre_grave).

% Regra 9
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    sintoma(sinais_meningite).

% Regra 10
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    sintoma(expetoracao).

% Regra 11
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    sintoma(perda_olfato),
    sintoma(condicao_risco).

% Regra 12
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    sintoma(perda_olfato),
    \+ sintoma(condicao_risco).

% Regra 13
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    sintoma(outros_sintomas),
    sintoma(causa_conhecida_paladar).

% Regra 14
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    sintoma(outros_sintomas),
    \+ sintoma(causa_conhecida_paladar).

% Regra 15
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    \+ sintoma(outros_sintomas),
    sintoma(tosse).

% Regra 16
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    \+ sintoma(outros_sintomas),
    \+ sintoma(tosse),
    sintoma(covid_180_dias).

% Regra 17
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    \+ sintoma(outros_sintomas),
    \+ sintoma(tosse),
    \+ sintoma(covid_180_dias),
    sintoma(condicao_risco).

% Regra 18
encaminhamento_ml(autocuidado) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    sintoma(condicoes_casa),
    \+ sintoma(perda_olfato),
    \+ sintoma(outros_sintomas),
    \+ sintoma(tosse),
    \+ sintoma(covid_180_dias),
    \+ sintoma(condicao_risco).

% Regra 19
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    sintoma(desidratacao),
    sintoma(condicao_risco).

% Regra 20
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    sintoma(desidratacao),
    \+ sintoma(condicao_risco),
    sintoma(outros_sintomas).

% Regra 21
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    sintoma(desidratacao),
    \+ sintoma(condicao_risco),
    \+ sintoma(outros_sintomas).

% Regra 22
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    \+ sintoma(desidratacao),
    sintoma(tosse),
    sintoma(condicao_risco).

% Regra 23
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    \+ sintoma(desidratacao),
    sintoma(tosse),
    \+ sintoma(condicao_risco),
    sintoma(outros_sintomas).

% Regra 24
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    \+ sintoma(desidratacao),
    sintoma(tosse),
    \+ sintoma(condicao_risco),
    \+ sintoma(outros_sintomas).

% Regra 25
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    sintoma(febre),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(convulsao_febril),
    \+ sintoma(febre_muito_alta),
    \+ sintoma(febre_grave),
    \+ sintoma(sinais_meningite),
    \+ sintoma(expetoracao),
    \+ sintoma(condicoes_casa),
    \+ sintoma(desidratacao),
    \+ sintoma(tosse).

% Regra 26
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    sintoma(falta_ar_dispneia).

% Regra 27
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    sintoma(expetoracao).

% Regra 28
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao),
    sintoma(perda_olfato).

% Regra 29
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao),
    \+ sintoma(perda_olfato),
    sintoma(perda_paladar).

% Regra 30
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao),
    \+ sintoma(perda_olfato),
    \+ sintoma(perda_paladar),
    sintoma(outros_sintomas),
    sintoma(tosse).

% Regra 31
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao),
    \+ sintoma(perda_olfato),
    \+ sintoma(perda_paladar),
    sintoma(outros_sintomas),
    \+ sintoma(tosse).

% Regra 32
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    sintoma(condicao_risco),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao),
    \+ sintoma(perda_olfato),
    \+ sintoma(perda_paladar),
    \+ sintoma(outros_sintomas).

% Regra 33
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    sintoma(covid_180_dias),
    sintoma(respiracao_ruidosa).

% Regra 34
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    sintoma(covid_180_dias),
    \+ sintoma(respiracao_ruidosa),
    sintoma(dificuldade_respiratoria_grave).

% Regra 35
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    sintoma(covid_180_dias),
    \+ sintoma(respiracao_ruidosa),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(tosse).

% Regra 36
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    sintoma(covid_180_dias),
    \+ sintoma(respiracao_ruidosa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(tosse).

% Regra 37
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    sintoma(causa_conhecida_olfato),
    sintoma(falta_ar_dispneia).

% Regra 38
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    sintoma(expetoracao).

% Regra 39
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao).

% Regra 40
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    sintoma(falta_ar_dispneia),
    sintoma(expetoracao).

% Regra 41
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    sintoma(falta_ar_dispneia),
    \+ sintoma(expetoracao).

% Regra 42
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    sintoma(causa_conhecida_paladar),
    sintoma(expetoracao).

% Regra 43
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    sintoma(causa_conhecida_paladar),
    \+ sintoma(expetoracao).

% Regra 44
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(entrou_algoritmo),
    sintoma(tosse),
    sintoma(perda_paladar).

% Regra 45
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(entrou_algoritmo),
    sintoma(tosse),
    \+ sintoma(perda_paladar),
    sintoma(outros_sintomas).

% Regra 46
encaminhamento_ml(autocuidado) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(entrou_algoritmo),
    sintoma(tosse),
    \+ sintoma(perda_paladar),
    \+ sintoma(outros_sintomas).

% Regra 47
encaminhamento_ml(autocuidado) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(causa_conhecida_paladar),
    sintoma(entrou_algoritmo),
    \+ sintoma(tosse).

% Regra 48
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    sintoma(condicoes_casa),
    \+ sintoma(condicao_risco),
    \+ sintoma(covid_180_dias),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(entrou_algoritmo).

% Regra 49
encaminhamento_ml(inem) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    sintoma(dificuldade_respiratoria_grave).

% Regra 50
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(falta_ar_dispneia),
    sintoma(tosse).

% Regra 51
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    sintoma(outros_sintomas).

% Regra 52
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(respiracao_ruidosa).

% Regra 53
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(respiracao_ruidosa).

% Regra 54
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    sintoma(outros_sintomas),
    sintoma(expetoracao).

% Regra 55
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    sintoma(outros_sintomas),
    \+ sintoma(expetoracao),
    sintoma(condicao_risco).

% Regra 56
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    sintoma(outros_sintomas),
    \+ sintoma(expetoracao),
    \+ sintoma(condicao_risco).

% Regra 57
encaminhamento_ml(adr_su) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(condicao_risco),
    sintoma(expetoracao).

% Regra 58
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(condicao_risco),
    \+ sintoma(expetoracao).

% Regra 59
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).

% Regra 60
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    sintoma(outros_sintomas).

% Regra 61
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(causa_conhecida_olfato),
    sintoma(condicao_risco).

% Regra 62
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    sintoma(causa_conhecida_olfato),
    \+ sintoma(condicao_risco).

% Regra 63
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(causa_conhecida_olfato),
    sintoma(perda_olfato).

% Regra 64
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(perda_olfato),
    sintoma(perda_paladar),
    sintoma(causa_conhecida_paladar).

% Regra 65
encaminhamento_ml(adr_csp) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(perda_olfato),
    sintoma(perda_paladar),
    \+ sintoma(causa_conhecida_paladar).

% Regra 66
encaminhamento_ml(transferencia_sns24) :-
    \+ sintoma(hemorragia_grave),
    \+ sintoma(obstrucao_via_aerea),
    \+ sintoma(inconsciente),
    \+ sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(dificuldade_respiratoria_grave),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(perda_olfato),
    \+ sintoma(perda_paladar).

