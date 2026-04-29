% ============================================================
% BASE DE DADOS - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
%
% Contem:
%   1. Declaracao dinamica do predicado sintoma/1
%   2. Casos de teste para validacao do sistema
%   3. Predicados de teste (testar/1 e testar_todos/0)
%
% Para testar: ?- testar(N).   ou   ?- testar_todos.
% ============================================================

:- dynamic sintoma/1.

% ============================================================
% CASOS DE TESTE
% Formato: caso(N, ListaDeFactos, ResultadoEsperado)
%
% Nota: entrou_algoritmo e registado pela interface quando
% o utente confirma ter pelo menos um sintoma de entrada.
% ============================================================

% --- PRE-TRIAGEM - INEM ---
% No fluxo real a pre-triagem e feita antes de entrar no algoritmo
caso(1,  [inconsciente],                   inem).
caso(2,  [dificuldade_respiratoria_grave], inem).
caso(3,  [hemorragia_grave],              inem).
% obstrucao_via_aerea e detetada no Q9, dentro do algoritmo
caso(4,  [entrou_algoritmo, falta_ar_dispneia, obstrucao_via_aerea], inem).

% --- SEM SINTOMAS DE ENTRADA - TRANSFERENCIA ---
caso(5,  [], transferencia_sns24).

% --- Q1: COVID 180 DIAS - TRANSFERENCIA ---
caso(6,  [entrou_algoritmo, covid_180_dias], transferencia_sns24).

% --- ADR-SU: factos isolados ---
% febre_muito_alta, febre_grave, convulsao_febril, sinais_meningite
% so sao registados se o utente respondeu sim ao Q2 (febre)
caso(7,  [entrou_algoritmo, febre, febre_muito_alta],  adr_su).
caso(8,  [entrou_algoritmo, febre, febre_grave],       adr_su).
caso(9,  [entrou_algoritmo, febre, convulsao_febril],  adr_su).
caso(10, [entrou_algoritmo, febre, sinais_meningite],  adr_su).
caso(11, [entrou_algoritmo, falta_ar_dispneia, respiracao_ruidosa], adr_su).

% --- ADR-SU: falta de ar com agravantes ---
caso(12, [entrou_algoritmo, falta_ar_dispneia, febre],         adr_su).
caso(13, [entrou_algoritmo, falta_ar_dispneia, tosse],         adr_su).
caso(14, [entrou_algoritmo, falta_ar_dispneia, outros_sintomas], adr_su).
caso(15, [entrou_algoritmo, falta_ar_dispneia, condicao_risco], adr_su).

% --- ADR-SU: febre com combinacoes graves ---
caso(16, [entrou_algoritmo, febre, tosse, outros_sintomas],        adr_su).
caso(17, [entrou_algoritmo, febre, tosse, condicao_risco],         adr_su).
caso(18, [entrou_algoritmo, febre, desidratacao, outros_sintomas], adr_su).
caso(19, [entrou_algoritmo, febre, desidratacao, condicao_risco],  adr_su).

% --- ADR-SU: tosse com expetoracao e agravantes ---
caso(20, [entrou_algoritmo, tosse, expetoracao, febre],           adr_su).
caso(21, [entrou_algoritmo, tosse, expetoracao, falta_ar_dispneia], adr_su).
caso(22, [entrou_algoritmo, tosse, expetoracao, outros_sintomas], adr_su).
caso(23, [entrou_algoritmo, tosse, expetoracao, condicao_risco],  adr_su).

% --- ADR-SU: outros sintomas com condicao de risco e agravantes ---
caso(24, [entrou_algoritmo, outros_sintomas, condicao_risco, febre], adr_su).
caso(25, [entrou_algoritmo, outros_sintomas, condicao_risco, tosse], adr_su).

% --- ADR-CSP: falta de ar sozinha ---
caso(26, [entrou_algoritmo, falta_ar_dispneia], adr_csp).

% --- ADR-CSP: febre com agravantes moderados ---
caso(27, [entrou_algoritmo, febre, desidratacao],    adr_csp).
caso(28, [entrou_algoritmo, febre, tosse],           adr_csp).
caso(29, [entrou_algoritmo, febre, outros_sintomas], adr_csp).
caso(30, [entrou_algoritmo, febre, condicao_risco],  adr_csp).

% --- ADR-CSP: tosse com agravantes moderados ---
caso(31, [entrou_algoritmo, tosse, expetoracao],     adr_csp).
caso(32, [entrou_algoritmo, tosse, outros_sintomas], adr_csp).
caso(33, [entrou_algoritmo, tosse, condicao_risco],  adr_csp).

% --- ADR-CSP: outros sintomas com condicao de risco sem febre nem tosse ---
caso(34, [entrou_algoritmo, outros_sintomas, condicao_risco], adr_csp).

% --- ADR-CSP: perda olfato com agravantes ---
caso(35, [entrou_algoritmo, perda_olfato, febre],          adr_csp).
caso(36, [entrou_algoritmo, perda_olfato, tosse],          adr_csp).
caso(37, [entrou_algoritmo, perda_olfato, outros_sintomas], adr_csp).
caso(38, [entrou_algoritmo, perda_olfato, condicao_risco], adr_csp).

% --- ADR-CSP: perda paladar com agravantes ---
caso(39, [entrou_algoritmo, perda_paladar, febre],          adr_csp).
caso(40, [entrou_algoritmo, perda_paladar, tosse],          adr_csp).
caso(41, [entrou_algoritmo, perda_paladar, outros_sintomas], adr_csp).
caso(42, [entrou_algoritmo, perda_paladar, condicao_risco], adr_csp).

% --- ADR-CSP: febre/tosse/outros sozinhos SEM condicoes em casa ---
caso(43, [entrou_algoritmo, febre],          adr_csp).
caso(44, [entrou_algoritmo, tosse],          adr_csp).
caso(45, [entrou_algoritmo, outros_sintomas], adr_csp).

% --- ADR-CSP: perda olfato/paladar sem causa conhecida, SEM condicoes em casa ---
caso(46, [entrou_algoritmo, perda_olfato],  adr_csp).
caso(47, [entrou_algoritmo, perda_paladar], adr_csp).

% --- TRANSFERENCIA: condicao de risco sem sintomas de entrada ---
caso(48, [entrou_algoritmo, condicao_risco], transferencia_sns24).

% --- TRANSFERENCIA: perda olfato/paladar com causa conhecida ---
caso(49, [entrou_algoritmo, perda_olfato, causa_conhecida_olfato],   transferencia_sns24).
caso(50, [entrou_algoritmo, perda_paladar, causa_conhecida_paladar], transferencia_sns24).

% --- AUTOCUIDADO: sintomas sozinhos COM condicoes em casa ---
caso(51, [entrou_algoritmo, febre, condicoes_casa],          autocuidado).
caso(52, [entrou_algoritmo, tosse, condicoes_casa],          autocuidado).
caso(53, [entrou_algoritmo, outros_sintomas, condicoes_casa], autocuidado).
caso(54, [entrou_algoritmo, perda_olfato, condicoes_casa],   autocuidado).
caso(55, [entrou_algoritmo, perda_paladar, condicoes_casa],  autocuidado).

% ============================================================
% PREDICADOS DE TESTE
% ============================================================

testar(N) :-
    caso(N, Sintomas, Esperado),
    retractall(sintoma(_)),
    maplist([S]>>(assertz(sintoma(S))), Sintomas),
    ( inferir(Obtido) -> true ; Obtido = sem_resultado ),
    ( Obtido == Esperado ->
        format('Caso ~`0t~w~3|: OK        (~w)~n', [N, Obtido])
    ;
        format('Caso ~`0t~w~3|: FALHOU    esperado=~w  obtido=~w~n',
               [N, Esperado, Obtido])
    ).

testar_todos :-
    nl,
    write('=== A testar todas as regras (Parte A) ==='), nl, nl,
    forall(caso(N, _, _), testar(N)),
    nl,
    aggregate_all(count, (caso(N,_,E), retractall(sintoma(_)),
        caso(N,S,_), maplist([X]>>(assertz(sintoma(X))),S),
        inferir(O), O == E), OK),
    aggregate_all(count, caso(_,_,_), Total),
    format('Resultado: ~w/~w testes passaram.~n', [OK, Total]),
    nl.

% ============================================================
% COMPARACAO MANUAL vs ML
%
% Para cada caso de teste, corre os dois motores de inferencia
% e compara os resultados.
%
% Para usar: ?- comparar_todos.
% ============================================================

comparar(N) :-
    caso(N, Sintomas, Esperado),
    retractall(sintoma(_)),
    maplist([S]>>(assertz(sintoma(S))), Sintomas),
    ( inferir(Manual)    -> true ; Manual = sem_resultado ),
    ( inferir_ml(ML)     -> true ; ML     = sem_resultado ),
    ( Manual == ML ->
        format('Caso ~`0t~w~3|: CONCORDAM  (~w)~n', [N, Manual])
    ;
        format('Caso ~`0t~w~3|: DIVERGEM   manual=~w  ml=~w  esperado=~w~n',
               [N, Manual, ML, Esperado])
    ).

comparar_todos :-
    nl,
    write('=== Comparacao: Regras Manuais vs Regras ML ==='), nl, nl,
    forall(caso(N, _, _), comparar(N)),
    nl,
    aggregate_all(count, (
        caso(N, S, _),
        retractall(sintoma(_)),
        maplist([X]>>(assertz(sintoma(X))), S),
        inferir(Manual),
        inferir_ml(ML),
        Manual == ML
    ), Concordam),
    aggregate_all(count, caso(_, _, _), Total),
    Divergem is Total - Concordam,
    format('Concordam: ~w/~w casos~n', [Concordam, Total]),
    format('Divergem:  ~w/~w casos~n', [Divergem, Total]),
    nl.