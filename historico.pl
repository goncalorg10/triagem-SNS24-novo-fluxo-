% ============================================================
% HISTORICO - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
%
% Registo persistente de todas as triagens realizadas.
% Cada triagem e guardada com timestamp, sintomas e resultado.
%
% Predicados disponiveis:
%   ver_historico/0       - lista todas as triagens
%   estatisticas/0        - contagem por resultado
%   limpar_historico/0    - apaga todo o historico
% ============================================================

:- dynamic triagem/3.

% Ficheiro onde o historico e guardado
ficheiro_historico('base_dados.pl').

% ============================================================
% CARREGAR HISTORICO
%
% Carrega o historico do ficheiro ao iniciar.
% Se o ficheiro nao existir, comeca com historico vazio.
% ============================================================

:- ( ficheiro_historico(F), exists_file(F) ->
       consult(F)
   ;
       true
   ).

% ============================================================
% REGISTAR TRIAGEM
%
% Chamado automaticamente pela interface no fim de cada triagem.
% Guarda o timestamp, lista de sintomas e resultado.
% ============================================================

registar_triagem(Sintomas, Resultado) :-
    get_time(Timestamp),
    assertz(triagem(Timestamp, Sintomas, Resultado)),
    guardar_historico.

% ============================================================
% GUARDAR HISTORICO NO FICHEIRO
%
% Escreve todos os factos triagem/3 no ficheiro de historico.
% Sobrescreve o ficheiro anterior com o estado atual.
% ============================================================

guardar_historico :-
    ficheiro_historico(F),
    open(F, write, Stream),
    write(Stream, '% Historico de Triagens - gerado automaticamente\n'),
    write(Stream, ':- dynamic triagem/3.\n\n'),
    forall(
        triagem(T, S, R),
        format(Stream, 'triagem(~w, ~w, ~w).~n', [T, S, R])
    ),
    close(Stream).

% ============================================================
% VER HISTORICO
%
% Lista todas as triagens registadas com data/hora formatada.
% ============================================================

ver_historico :-
    nl,
    write('+------------------------------------------+'), nl,
    write('|         HISTORICO DE TRIAGENS            |'), nl,
    write('+------------------------------------------+'), nl, nl,
    ( \+ triagem(_, _, _) ->
        write('  Nao ha triagens registadas.'), nl
    ;
        forall(
            triagem(Timestamp, Sintomas, Resultado),
            ( format_time(atom(Data), '%d/%m/%Y %H:%M:%S', Timestamp),
              format('  Data:      ~w~n', [Data]),
              format('  Resultado: ~w~n', [Resultado]),
              format('  Sintomas:  ~w~n', [Sintomas]),
              nl
            )
        )
    ), nl.

% ============================================================
% ESTATISTICAS
%
% Mostra contagem de triagens por resultado.
% ============================================================

estatisticas :-
    nl,
    write('+------------------------------------------+'), nl,
    write('|         ESTATISTICAS DE TRIAGENS         |'), nl,
    write('+------------------------------------------+'), nl, nl,
    aggregate_all(count, triagem(_, _, _), Total),
    format('  Total de triagens: ~w~n~n', [Total]),
    ( Total =:= 0 ->
        write('  Nao ha triagens registadas.')
    ;
        forall(
            member(R, [inem, adr_su, adr_csp, transferencia_sns24, autocuidado]),
            ( aggregate_all(count, triagem(_, _, R), N),
              Perc is round(N * 100 / Total),
              format('  ~w: ~w (~w%)~n', [R, N, Perc])
            )
        )
    ), nl.

% ============================================================
% LIMPAR HISTORICO
%
% Remove todos os registos de triagem da memoria e do ficheiro.
% ============================================================

limpar_historico :-
    retractall(triagem(_, _, _)),
    guardar_historico,
    write('  Historico limpo com sucesso.'), nl.