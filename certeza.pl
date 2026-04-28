% ============================================================
% CERTEZA - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
% P1MAX - Sistema de Inferencia com Incerteza
%
% Calcula o grau de certeza (CF) do encaminhamento determinado.
%
% Logica:
%   1. Identifica qual a regra especifica que disparou
%      (mesma ordem da base_conhecimento.pl)
%   2. Vai buscar o CF base dessa regra
%   3. Soma incrementos por cada sintoma adicional presente
%      que nao faz parte da regra que disparou
%   4. Limita o CF maximo a 1.0
%
% Uso: calcular_certeza(Resultado, CF)
% ============================================================

% ============================================================
% REGRA APLICADA
%
% Identifica qual a regra especifica que disparou,
% seguindo a mesma ordem da base_conhecimento.pl.
% O ! garante que so devolve a primeira que unifica.
% ============================================================

regra_aplicada(Resultado, Regra) :-
    regra_match(Resultado, Regra), !.

% --- INEM ---
regra_match(inem, inconsciente) :-
    sintoma(inconsciente).
regra_match(inem, dificuldade_respiratoria_grave) :-
    sintoma(dificuldade_respiratoria_grave).
regra_match(inem, hemorragia_grave) :-
    sintoma(hemorragia_grave).
regra_match(inem, obstrucao_via_aerea) :-
    sintoma(obstrucao_via_aerea).

% --- ADR-SU: factos isolados ---
regra_match(adr_su, febre_muito_alta) :-
    sintoma(febre_muito_alta).
regra_match(adr_su, febre_grave) :-
    sintoma(febre_grave).
regra_match(adr_su, convulsao_febril) :-
    sintoma(convulsao_febril).
regra_match(adr_su, sinais_meningite) :-
    sintoma(sinais_meningite).
regra_match(adr_su, respiracao_ruidosa) :-
    sintoma(respiracao_ruidosa).

% --- ADR-SU: falta de ar com agravantes ---
regra_match(adr_su, falta_ar_dispneia_febre) :-
    sintoma(falta_ar_dispneia), sintoma(febre).
regra_match(adr_su, falta_ar_dispneia_tosse) :-
    sintoma(falta_ar_dispneia), sintoma(tosse).
regra_match(adr_su, falta_ar_dispneia_outros) :-
    sintoma(falta_ar_dispneia), sintoma(outros_sintomas).
regra_match(adr_su, falta_ar_dispneia_risco) :-
    sintoma(falta_ar_dispneia), sintoma(condicao_risco).

% --- ADR-SU: febre com combinacoes graves ---
regra_match(adr_su, febre_tosse_outros) :-
    sintoma(febre), sintoma(tosse), sintoma(outros_sintomas).
regra_match(adr_su, febre_tosse_risco) :-
    sintoma(febre), sintoma(tosse), sintoma(condicao_risco).
regra_match(adr_su, febre_desidratacao_outros) :-
    sintoma(febre), sintoma(desidratacao), sintoma(outros_sintomas).
regra_match(adr_su, febre_desidratacao_tosse) :-
    sintoma(febre), sintoma(desidratacao), sintoma(tosse).
regra_match(adr_su, febre_desidratacao_risco) :-
    sintoma(febre), sintoma(desidratacao), sintoma(condicao_risco).

% --- ADR-SU: tosse com expetoracao e agravantes ---
regra_match(adr_su, tosse_expetoracao_febre) :-
    sintoma(tosse), sintoma(expetoracao), sintoma(febre).
regra_match(adr_su, tosse_expetoracao_outros) :-
    sintoma(tosse), sintoma(expetoracao), sintoma(outros_sintomas).
regra_match(adr_su, tosse_expetoracao_risco) :-
    sintoma(tosse), sintoma(expetoracao), sintoma(condicao_risco).

% --- ADR-SU: outros sintomas com condicao de risco ---
regra_match(adr_su, outros_risco_febre) :-
    sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(febre).
regra_match(adr_su, outros_risco_tosse) :-
    sintoma(outros_sintomas), sintoma(condicao_risco), sintoma(tosse).

% --- ADR-CSP ---
regra_match(adr_csp, falta_ar_sozinha) :-
    sintoma(falta_ar_dispneia),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, febre_desidratacao) :-
    sintoma(febre), sintoma(desidratacao),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, febre_tosse) :-
    sintoma(febre), sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, febre_outros) :-
    sintoma(febre), sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).
regra_match(adr_csp, febre_risco) :-
    sintoma(febre), sintoma(condicao_risco),
    \+ sintoma(tosse), \+ sintoma(outros_sintomas).
regra_match(adr_csp, tosse_expetoracao) :-
    sintoma(tosse), sintoma(expetoracao),
    \+ sintoma(febre), \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, tosse_outros) :-
    sintoma(tosse), sintoma(outros_sintomas),
    \+ sintoma(condicao_risco).
regra_match(adr_csp, tosse_risco) :-
    sintoma(tosse), sintoma(condicao_risco),
    \+ sintoma(outros_sintomas).
regra_match(adr_csp, outros_risco) :-
    sintoma(outros_sintomas), sintoma(condicao_risco),
    \+ sintoma(febre), \+ sintoma(tosse).
regra_match(adr_csp, olfato_febre) :-
    sintoma(perda_olfato), sintoma(febre).
regra_match(adr_csp, olfato_tosse) :-
    sintoma(perda_olfato), sintoma(tosse).
regra_match(adr_csp, olfato_outros) :-
    sintoma(perda_olfato), sintoma(outros_sintomas).
regra_match(adr_csp, olfato_risco) :-
    sintoma(perda_olfato), sintoma(condicao_risco).
regra_match(adr_csp, paladar_febre) :-
    sintoma(perda_paladar), sintoma(febre).
regra_match(adr_csp, paladar_tosse) :-
    sintoma(perda_paladar), sintoma(tosse).
regra_match(adr_csp, paladar_outros) :-
    sintoma(perda_paladar), sintoma(outros_sintomas).
regra_match(adr_csp, paladar_risco) :-
    sintoma(perda_paladar), sintoma(condicao_risco).
regra_match(adr_csp, febre_sem_casa) :-
    sintoma(febre), \+ sintoma(condicoes_casa),
    \+ sintoma(tosse), \+ sintoma(desidratacao),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, tosse_sem_casa) :-
    sintoma(tosse), \+ sintoma(condicoes_casa),
    \+ sintoma(expetoracao), \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, outros_sem_casa) :-
    sintoma(outros_sintomas), \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(condicao_risco).
regra_match(adr_csp, olfato_sem_casa) :-
    sintoma(perda_olfato), \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(adr_csp, paladar_sem_casa) :-
    sintoma(perda_paladar), \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% --- TRANSFERENCIA ---
regra_match(transferencia_sns24, sem_sintomas_entrada) :-
    \+ sintoma(entrou_algoritmo).
regra_match(transferencia_sns24, covid_180_dias) :-
    sintoma(covid_180_dias).
regra_match(transferencia_sns24, condicao_risco_sem_sintomas) :-
    sintoma(condicao_risco),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(outros_sintomas),
    \+ sintoma(perda_olfato), \+ sintoma(perda_paladar).
regra_match(transferencia_sns24, olfato_causa_conhecida) :-
    sintoma(perda_olfato), sintoma(causa_conhecida_olfato).
regra_match(transferencia_sns24, paladar_causa_conhecida) :-
    sintoma(perda_paladar), sintoma(causa_conhecida_paladar).

% --- ADR-CSP: fallback ---
regra_match(adr_csp, fallback) :-
    sintoma(entrou_algoritmo).

% --- AUTOCUIDADO ---
regra_match(autocuidado, febre_casa) :-
    sintoma(febre), sintoma(condicoes_casa),
    \+ sintoma(tosse), \+ sintoma(desidratacao),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(autocuidado, tosse_casa) :-
    sintoma(tosse), sintoma(condicoes_casa),
    \+ sintoma(expetoracao), \+ sintoma(febre),
    \+ sintoma(falta_ar_dispneia),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(autocuidado, outros_casa) :-
    sintoma(outros_sintomas), sintoma(condicoes_casa),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(falta_ar_dispneia), \+ sintoma(condicao_risco).
regra_match(autocuidado, olfato_casa) :-
    sintoma(perda_olfato), sintoma(condicoes_casa),
    \+ sintoma(causa_conhecida_olfato),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).
regra_match(autocuidado, paladar_casa) :-
    sintoma(perda_paladar), sintoma(condicoes_casa),
    \+ sintoma(causa_conhecida_paladar),
    \+ sintoma(febre), \+ sintoma(tosse),
    \+ sintoma(outros_sintomas), \+ sintoma(condicao_risco).

% ============================================================
% CF BASE POR REGRA ESPECIFICA
%
% Quanto mais grave e especifica a regra, maior o CF base.
% ============================================================

% --- INEM: sempre 1.0 ---
certeza_base(inem, inconsciente,                    1.00).
certeza_base(inem, dificuldade_respiratoria_grave,  1.00).
certeza_base(inem, hemorragia_grave,                1.00).
certeza_base(inem, obstrucao_via_aerea,             0.80).

% --- ADR-SU: factos isolados de gravidade imediata ---
certeza_base(adr_su, febre_muito_alta,              0.95).
certeza_base(adr_su, sinais_meningite,              0.94).
certeza_base(adr_su, febre_grave,                   0.90).
certeza_base(adr_su, convulsao_febril,              0.88).
certeza_base(adr_su, respiracao_ruidosa,            0.87).

% --- ADR-SU: combinacoes com falta de ar ---
certeza_base(adr_su, falta_ar_dispneia_risco,       0.86).
certeza_base(adr_su, falta_ar_dispneia_febre,       0.85).
certeza_base(adr_su, falta_ar_dispneia_outros,      0.84).
certeza_base(adr_su, falta_ar_dispneia_tosse,       0.83).

% --- ADR-SU: combinacoes com febre ---
certeza_base(adr_su, febre_tosse_risco,             0.87).
certeza_base(adr_su, febre_tosse_outros,            0.85).
certeza_base(adr_su, febre_desidratacao_risco,      0.86).
certeza_base(adr_su, febre_desidratacao_outros,     0.84).
certeza_base(adr_su, febre_desidratacao_tosse,      0.83).

% --- ADR-SU: tosse com expetoracao ---
certeza_base(adr_su, tosse_expetoracao_febre,       0.85).
certeza_base(adr_su, tosse_expetoracao_risco,       0.84).
certeza_base(adr_su, tosse_expetoracao_outros,      0.82).

% --- ADR-SU: outros sintomas com risco ---
certeza_base(adr_su, outros_risco_febre,            0.86).
certeza_base(adr_su, outros_risco_tosse,            0.84).

% --- ADR-CSP ---
certeza_base(adr_csp, febre_risco,                  0.80).
certeza_base(adr_csp, tosse_risco,                  0.78).
certeza_base(adr_csp, outros_risco,                 0.78).
certeza_base(adr_csp, febre_outros,                 0.76).
certeza_base(adr_csp, tosse_outros,                 0.75).
certeza_base(adr_csp, febre_desidratacao,           0.75).
certeza_base(adr_csp, febre_tosse,                  0.74).
certeza_base(adr_csp, tosse_expetoracao,            0.73).
certeza_base(adr_csp, olfato_risco,                 0.72).
certeza_base(adr_csp, paladar_risco,                0.72).
certeza_base(adr_csp, olfato_febre,                 0.71).
certeza_base(adr_csp, paladar_febre,                0.71).
certeza_base(adr_csp, olfato_tosse,                 0.70).
certeza_base(adr_csp, paladar_tosse,                0.70).
certeza_base(adr_csp, olfato_outros,                0.70).
certeza_base(adr_csp, paladar_outros,               0.70).
certeza_base(adr_csp, falta_ar_sozinha,             0.70).
certeza_base(adr_csp, febre_sem_casa,               0.65).
certeza_base(adr_csp, tosse_sem_casa,               0.65).
certeza_base(adr_csp, outros_sem_casa,              0.65).
certeza_base(adr_csp, olfato_sem_casa,              0.63).
certeza_base(adr_csp, paladar_sem_casa,             0.63).
certeza_base(adr_csp, fallback,                     0.60).

% --- TRANSFERENCIA ---
certeza_base(transferencia_sns24, covid_180_dias,           0.95).
certeza_base(transferencia_sns24, sem_sintomas_entrada,     0.90).
certeza_base(transferencia_sns24, olfato_causa_conhecida,   0.88).
certeza_base(transferencia_sns24, paladar_causa_conhecida,  0.88).
certeza_base(transferencia_sns24, condicao_risco_sem_sintomas, 0.85).

% --- AUTOCUIDADO ---
certeza_base(autocuidado, febre_casa,               0.70).
certeza_base(autocuidado, tosse_casa,               0.70).
certeza_base(autocuidado, outros_casa,              0.68).
certeza_base(autocuidado, olfato_casa,              0.65).
certeza_base(autocuidado, paladar_casa,             0.65).

% ============================================================
% INCREMENTOS POR SINTOMAS ADICIONAIS
%
% Sintomas presentes que nao fazem parte da regra que disparou
% aumentam a certeza do encaminhamento.
% ============================================================

incremento(condicao_risco,      0.05).
incremento(sinais_meningite,    0.05).
incremento(febre_muito_alta,    0.04).
incremento(febre_grave,         0.04).
incremento(convulsao_febril,    0.04).
incremento(desidratacao,        0.03).
incremento(falta_ar_dispneia,   0.03).
incremento(respiracao_ruidosa,  0.03).
incremento(obstrucao_via_aerea, 0.03).
incremento(outros_sintomas,     0.02).
incremento(expetoracao,         0.02).
incremento(febre,               0.02).
incremento(tosse,               0.01).
incremento(perda_olfato,        0.01).
incremento(perda_paladar,       0.01).

% ============================================================
% CALCULO DO CF FINAL
%
% CF = min(1.0, certeza_base + soma dos incrementos
%              dos sintomas adicionais presentes)
%
% "Sintomas adicionais" = sintomas presentes que nao sao
% o identificador da regra que disparou (esse ja esta
% contabilizado no CF base).
% ============================================================

% ============================================================
% SINTOMAS DE CADA REGRA
%
% Lista os sintomas que compoem cada regra especifica.
% Estes nao sao contabilizados nos incrementos pois ja
% estao refletidos no CF base da regra.
% ============================================================

% --- INEM ---
sintomas_regra(inconsciente,                    [inconsciente]).
sintomas_regra(dificuldade_respiratoria_grave,  [dificuldade_respiratoria_grave]).
sintomas_regra(hemorragia_grave,                [hemorragia_grave]).
sintomas_regra(obstrucao_via_aerea,             [obstrucao_via_aerea]).

% --- ADR-SU: factos isolados ---
sintomas_regra(febre_muito_alta,                [febre_muito_alta]).
sintomas_regra(febre_grave,                     [febre_grave]).
sintomas_regra(convulsao_febril,                [convulsao_febril]).
sintomas_regra(sinais_meningite,                [sinais_meningite]).
sintomas_regra(respiracao_ruidosa,              [respiracao_ruidosa]).

% --- ADR-SU: falta de ar com agravantes ---
sintomas_regra(falta_ar_dispneia_febre,         [falta_ar_dispneia, febre]).
sintomas_regra(falta_ar_dispneia_tosse,         [falta_ar_dispneia, tosse]).
sintomas_regra(falta_ar_dispneia_outros,        [falta_ar_dispneia, outros_sintomas]).
sintomas_regra(falta_ar_dispneia_risco,         [falta_ar_dispneia, condicao_risco]).

% --- ADR-SU: febre com combinacoes graves ---
sintomas_regra(febre_tosse_outros,              [febre, tosse, outros_sintomas]).
sintomas_regra(febre_tosse_risco,               [febre, tosse, condicao_risco]).
sintomas_regra(febre_desidratacao_outros,       [febre, desidratacao, outros_sintomas]).
sintomas_regra(febre_desidratacao_tosse,        [febre, desidratacao, tosse]).
sintomas_regra(febre_desidratacao_risco,        [febre, desidratacao, condicao_risco]).

% --- ADR-SU: tosse com expetoracao ---
sintomas_regra(tosse_expetoracao_febre,         [tosse, expetoracao, febre]).
sintomas_regra(tosse_expetoracao_outros,        [tosse, expetoracao, outros_sintomas]).
sintomas_regra(tosse_expetoracao_risco,         [tosse, expetoracao, condicao_risco]).

% --- ADR-SU: outros sintomas com risco ---
sintomas_regra(outros_risco_febre,              [outros_sintomas, condicao_risco, febre]).
sintomas_regra(outros_risco_tosse,              [outros_sintomas, condicao_risco, tosse]).

% --- ADR-CSP ---
sintomas_regra(fallback,                        [entrou_algoritmo]).
sintomas_regra(falta_ar_sozinha,                [falta_ar_dispneia]).
sintomas_regra(febre_desidratacao,              [febre, desidratacao]).
sintomas_regra(febre_tosse,                     [febre, tosse]).
sintomas_regra(febre_outros,                    [febre, outros_sintomas]).
sintomas_regra(febre_risco,                     [febre, condicao_risco]).
sintomas_regra(tosse_expetoracao,               [tosse, expetoracao]).
sintomas_regra(tosse_outros,                    [tosse, outros_sintomas]).
sintomas_regra(tosse_risco,                     [tosse, condicao_risco]).
sintomas_regra(outros_risco,                    [outros_sintomas, condicao_risco]).
sintomas_regra(olfato_febre,                    [perda_olfato, febre]).
sintomas_regra(olfato_tosse,                    [perda_olfato, tosse]).
sintomas_regra(olfato_outros,                   [perda_olfato, outros_sintomas]).
sintomas_regra(olfato_risco,                    [perda_olfato, condicao_risco]).
sintomas_regra(paladar_febre,                   [perda_paladar, febre]).
sintomas_regra(paladar_tosse,                   [perda_paladar, tosse]).
sintomas_regra(paladar_outros,                  [perda_paladar, outros_sintomas]).
sintomas_regra(paladar_risco,                   [perda_paladar, condicao_risco]).
sintomas_regra(febre_sem_casa,                  [febre]).
sintomas_regra(tosse_sem_casa,                  [tosse]).
sintomas_regra(outros_sem_casa,                 [outros_sintomas]).
sintomas_regra(olfato_sem_casa,                 [perda_olfato]).
sintomas_regra(paladar_sem_casa,                [perda_paladar]).

% --- TRANSFERENCIA ---
sintomas_regra(sem_sintomas_entrada,            []).
sintomas_regra(covid_180_dias,                  [covid_180_dias]).
sintomas_regra(condicao_risco_sem_sintomas,     [condicao_risco]).
sintomas_regra(olfato_causa_conhecida,          [perda_olfato, causa_conhecida_olfato]).
sintomas_regra(paladar_causa_conhecida,         [perda_paladar, causa_conhecida_paladar]).

% --- AUTOCUIDADO ---
sintomas_regra(febre_casa,                      [febre, condicoes_casa]).
sintomas_regra(tosse_casa,                      [tosse, condicoes_casa]).
sintomas_regra(outros_casa,                     [outros_sintomas, condicoes_casa]).
sintomas_regra(olfato_casa,                     [perda_olfato, condicoes_casa]).
sintomas_regra(paladar_casa,                    [perda_paladar, condicoes_casa]).

% ============================================================
% CALCULO DO CF FINAL
%
% CF = min(1.0, certeza_base + soma dos incrementos
%              dos sintomas adicionais presentes)
%
% Sintomas adicionais = sintomas presentes que NAO fazem
% parte da regra que disparou (ja contabilizados no CF base).
% ============================================================

calcular_certeza(Resultado, CF) :-
    regra_aplicada(Resultado, Regra),
    certeza_base(Resultado, Regra, Base),
    sintomas_regra(Regra, SintomasRegra),
    findall(Inc,
        ( incremento(S, Inc),
          sintoma(S),
          \+ member(S, SintomasRegra) ),
        Incs),
    sumlist(Incs, Total),
    CF is min(1.0, Base + Total).