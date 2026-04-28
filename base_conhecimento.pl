% ============================================================
% BASE DE CONHECIMENTO - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
%
% Contem todas as regras de producao do sistema.
% Cada regra le-se:
%   "o encaminhamento e X se existirem estes factos"
%
% Os factos sao criados dinamicamente pela interface
% consoante as respostas do utente.
%
% ORDEM DAS REGRAS (prioridade decrescente):
%   1. INEM 112
%   2. ADR-SU
%   3. ADR-CSP
%   4. Transferencia SNS24
%   5. Autocuidado
% ============================================================

:- discontiguous encaminhamento/1.

% ------------------------------------------------------------
% 1. PRE-TRIAGEM - INEM 112
% ------------------------------------------------------------

encaminhamento(inem) :- sintoma(inconsciente).
encaminhamento(inem) :- sintoma(dificuldade_respiratoria_grave).
encaminhamento(inem) :- sintoma(hemorragia_grave).
encaminhamento(inem) :- sintoma(obstrucao_via_aerea).

% ------------------------------------------------------------
% 2. ADR-SU - Urgencia Hospitalar
% ------------------------------------------------------------

% 2a. Factos isolados de gravidade imediata
encaminhamento(adr_su) :- sintoma(febre_muito_alta).
encaminhamento(adr_su) :- sintoma(febre_grave).
encaminhamento(adr_su) :- sintoma(convulsao_febril).
encaminhamento(adr_su) :- sintoma(sinais_meningite).
encaminhamento(adr_su) :- sintoma(respiracao_ruidosa).

% 2b. Falta de ar com agravantes
encaminhamento(adr_su) :- sintoma(falta_ar_dispneia), sintoma(febre).
encaminhamento(adr_su) :- sintoma(falta_ar_dispneia), sintoma(tosse).
encaminhamento(adr_su) :- sintoma(falta_ar_dispneia), sintoma(outros_sintomas).
encaminhamento(adr_su) :- sintoma(falta_ar_dispneia), sintoma(condicao_risco).

% 2c. Febre com combinacoes graves
encaminhamento(adr_su) :- sintoma(febre), sintoma(tosse), sintoma(outros_sintomas).
encaminhamento(adr_su) :- sintoma(febre), sintoma(tosse), sintoma(condicao_risco).
encaminhamento(adr_su) :- sintoma(febre), sintoma(desidratacao), sintoma(outros_sintomas).
encaminhamento(adr_su) :- sintoma(febre), sintoma(desidratacao), sintoma(tosse).
encaminhamento(adr_su) :- sintoma(febre), sintoma(desidratacao), sintoma(condicao_risco).

% 2d. Tosse com expetoracao e agravantes
encaminhamento(adr_su) :- sintoma(tosse), sintoma(expetoracao), sintoma(febre).
encaminhamento(adr_su) :- sintoma(tosse), sintoma(expetoracao), sintoma(outros_sintomas).
encaminhamento(adr_su) :- sintoma(tosse), sintoma(expetoracao), sintoma(condicao_risco).

% 2e. Outros sintomas com condicao de risco e agravantes
encaminhamento(adr_su) :- sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(febre).
encaminhamento(adr_su) :- sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(tosse).

% ------------------------------------------------------------
% 3. ADR-CSP - Centro de Saude
% ------------------------------------------------------------

% 3a. Falta de ar sozinha
encaminhamento(adr_csp) :-
    sintoma(falta_ar_dispneia),
    \+ sintoma(febre),
    \+ sintoma(tosse),
    \+ sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).

% 3b. Febre com agravantes moderados
encaminhamento(adr_csp) :-
    sintoma(febre), sintoma(desidratacao),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

encaminhamento(adr_csp) :-
    sintoma(febre), sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

encaminhamento(adr_csp) :-
    sintoma(febre), sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).

encaminhamento(adr_csp) :-
    sintoma(febre), sintoma(condicao_risco),
    \+ sintoma(tosse), \+ sintoma(outros_sintomas).

% 3c. Tosse com agravantes moderados
encaminhamento(adr_csp) :-
    sintoma(tosse), sintoma(expetoracao),
    \+ sintoma(febre), \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

encaminhamento(adr_csp) :-
    sintoma(tosse), sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).

encaminhamento(adr_csp) :-
    sintoma(tosse), sintoma(condicao_risco),
    \+ sintoma(outros_sintomas).

% 3d. Outros sintomas com condicao de risco sem febre nem tosse
encaminhamento(adr_csp) :-
    sintoma(outros_sintomas), sintoma(condicao_risco),
    \+ sintoma(febre), \+ sintoma(tosse).

% 3e. Perda de olfato com agravantes
encaminhamento(adr_csp) :- sintoma(perda_olfato), sintoma(febre).
encaminhamento(adr_csp) :- sintoma(perda_olfato), sintoma(tosse).
encaminhamento(adr_csp) :- sintoma(perda_olfato), sintoma(outros_sintomas).
encaminhamento(adr_csp) :- sintoma(perda_olfato), sintoma(condicao_risco).

% 3f. Perda de paladar com agravantes
encaminhamento(adr_csp) :- sintoma(perda_paladar), sintoma(febre).
encaminhamento(adr_csp) :- sintoma(perda_paladar), sintoma(tosse).
encaminhamento(adr_csp) :- sintoma(perda_paladar), sintoma(outros_sintomas).
encaminhamento(adr_csp) :- sintoma(perda_paladar), sintoma(condicao_risco).

% 3g. Febre sozinha sem condicoes em casa
encaminhamento(adr_csp) :-
    sintoma(febre),
    \+ sintoma(condicoes_casa),
    \+ sintoma(tosse), \+ sintoma(desidratacao),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% 3h. Tosse sozinha sem condicoes em casa
encaminhamento(adr_csp) :-
    sintoma(tosse),
    \+ sintoma(condicoes_casa),
    \+ sintoma(expetoracao), \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% 3i. Outros sintomas sozinhos sem condicoes em casa
encaminhamento(adr_csp) :-
    sintoma(outros_sintomas),
    \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(condicao_risco).

% 3j. Perda olfato sem causa conhecida, sem agravantes, sem condicoes em casa
encaminhamento(adr_csp) :-
    sintoma(perda_olfato),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% 3k. Perda paladar sem causa conhecida, sem agravantes, sem condicoes em casa
encaminhamento(adr_csp) :-
    sintoma(perda_paladar),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% ------------------------------------------------------------
% 4. TRANSFERENCIA PARA OUTRO FLUXO SNS24
% ------------------------------------------------------------

% Sem sintomas de entrada
encaminhamento(transferencia_sns24) :-
    \+ sintoma(entrou_algoritmo).

% COVID-19 nos ultimos 180 dias
encaminhamento(transferencia_sns24) :-
    sintoma(covid_180_dias).

% Condicao de risco sem nenhum sintoma de entrada
encaminhamento(transferencia_sns24) :-
    sintoma(condicao_risco),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(outros_sintomas),
    \+ sintoma(perda_olfato), \+ sintoma(perda_paladar).

% Perda de olfato com causa conhecida
encaminhamento(transferencia_sns24) :-
    sintoma(perda_olfato), sintoma(causa_conhecida_olfato).

% Perda de paladar com causa conhecida
encaminhamento(transferencia_sns24) :-
    sintoma(perda_paladar), sintoma(causa_conhecida_paladar).

% ------------------------------------------------------------
% 5. AUTOCUIDADO - Fica em casa (so com condicoes_casa)
% ------------------------------------------------------------

% Febre sozinha com condicoes em casa
encaminhamento(autocuidado) :-
    sintoma(febre), sintoma(condicoes_casa),
    \+ sintoma(tosse), \+ sintoma(desidratacao),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% Tosse sozinha com condicoes em casa
encaminhamento(autocuidado) :-
    sintoma(tosse), sintoma(condicoes_casa),
    \+ sintoma(expetoracao), \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% Outros sintomas sozinhos com condicoes em casa
encaminhamento(autocuidado) :-
    sintoma(outros_sintomas), sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(condicao_risco).

% Perda de olfato sem causa conhecida, sem agravantes, com condicoes em casa
encaminhamento(autocuidado) :-
    sintoma(perda_olfato), sintoma(condicoes_casa),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% Perda de paladar sem causa conhecida, sem agravantes, com condicoes em casa
encaminhamento(autocuidado) :-
    sintoma(perda_paladar), sintoma(condicoes_casa),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% ------------------------------------------------------------
% FALLBACK - Rede de seguranca final
%
% Se o utente entrou no algoritmo mas nenhuma regra disparou
% (respondeu nao a todos os sintomas especificos),
% encaminha para centro de saude por seguranca.
% ------------------------------------------------------------

encaminhamento(adr_csp) :-
    sintoma(entrou_algoritmo).