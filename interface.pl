% ============================================================
% INTERFACE - Sistema de Triagem SNS24
% Projecto 1A - Tecnicas de Inteligencia Artificial
%
% Segue o fluxo completo do Protocolo Altitude (Sintomaticos).
% So para a meio do fluxo em dois casos:
%   - Pre-triagem: emergencia ABC (INEM imediato)
%   - Q1: COVID-19 nos ultimos 180 dias (transferencia imediata)
% Em todos os outros casos, segue sempre ate Q19.
%
% Para iniciar: ?- iniciar.
% ============================================================

:- consult('inferencia.pl').

% ============================================================
% PONTO DE ENTRADA
% ============================================================

iniciar :-
    limpar,
    cabecalho,
    pre_triagem.

cabecalho :-
    nl,
    write('+------------------------------------------+'), nl,
    write('|       SISTEMA DE TRIAGEM SNS24           |'), nl,
    write('|   Protocolo Altitude - Sintomaticos      |'), nl,
    write('+------------------------------------------+'), nl, nl,
    write('  Responda a cada pergunta com:'), nl,
    write('    sim.   para confirmar'), nl,
    write('    nao.   para negar'), nl, nl,
    write('------------------------------------------'), nl, nl.

% ============================================================
% PRE-TRIAGEM - Compromisso ABC (Q0.1, Q0.2, Q0.3)
% ============================================================

pre_triagem :-
    nl, write('[ PRE-TRIAGEM - Compromisso ABC ]'), nl, nl,
    pergunta(inconsciente,
        'Q0.1: O utente esta inconsciente ou nao responde?'),
    ( sintoma(inconsciente) ->
        dar_resultado
    ;
        pergunta(dificuldade_respiratoria_grave,
            'Q0.2: Tem dificuldade respiratoria grave?'),
        ( sintoma(dificuldade_respiratoria_grave) ->
            dar_resultado
        ;
            pergunta(hemorragia_grave,
                'Q0.3: Tem hemorragia grave?'),
            ( sintoma(hemorragia_grave) ->
                dar_resultado
            ;
                nl,
                write('  Pre-triagem concluida sem emergencia.'), nl, nl,
                sintomas_entrada
            )
        )
    ).

% ============================================================
% SINTOMAS DE ENTRADA
% ============================================================

sintomas_entrada :-
    write('[ SINTOMAS DE ENTRADA ]'), nl, nl,
    write('Tem pelo menos um dos seguintes sintomas?'), nl,
    write('  - Tosse'), nl,
    write('  - Febre'), nl,
    write('  - Falta de ar ou dispneia'), nl,
    write('  - Alteracao de olfato'), nl,
    write('  - Alteracao de paladar'), nl, nl,
    pergunta(tem_sintoma_entrada, ''),
    ( sintoma(tem_sintoma_entrada) ->
        assertz(sintoma(entrou_algoritmo)),
        nl,
        write('[ ALGORITMO DE TRIAGEM CLINICA ]'), nl, nl,
        questao_1
    ;
        dar_resultado
    ).

% ============================================================
% Q1 - COVID-19 nos ultimos 180 dias
% ============================================================

questao_1 :-
    pergunta(covid_180_dias,
        'Q1: Teve COVID-19 nos ultimos 180 dias?'),
    ( sintoma(covid_180_dias) ->
        dar_resultado
    ;
        questao_2
    ).

% ============================================================
% BLOCO DA FEBRE - Q2 a Q7
% ============================================================

questao_2 :-
    nl, write('[ BLOCO DA FEBRE ]'), nl, nl,
    pergunta(febre,
        'Q2: Tem febre acima de 38C?'),
    ( sintoma(febre) ->
        questao_3
    ;
        questao_8
    ).

questao_3 :-
    pergunta(febre_muito_alta,
        'Q3: A febre e muito alta? (axilar >= 40C ou retal >= 41C)'),
    questao_4.

questao_4 :-
    pergunta(febre_grave,
        'Q4: A febre dura mais de 48h ou nao melhora com medicacao?'),
    questao_5.

questao_5 :-
    pergunta(convulsao_febril,
        'Q5: Ja teve convulsao febril anteriormente?'),
    questao_6.

questao_6 :-
    write('Q6: Tem sinais de desidratacao?'), nl,
    write('    (urina escura, boca seca, olhos encovados, pouca urina)'), nl,
    pergunta(desidratacao, ''),
    questao_7.

questao_7 :-
    write('Q7: Tem cefaleia intensa, rigidez do pescoco,'), nl,
    write('    fotofobia ou manchas na pele? (sinais de meningite)'), nl,
    pergunta(sinais_meningite, ''),
    questao_8.

% ============================================================
% BLOCO RESPIRATORIO - Q8 a Q10
% ============================================================

questao_8 :-
    nl, write('[ BLOCO RESPIRATORIO ]'), nl, nl,
    pergunta(falta_ar_dispneia,
        'Q8: Tem falta de ar ou dificuldade em respirar? (dispneia)'),
    ( sintoma(falta_ar_dispneia) ->
        questao_9
    ;
        questao_11
    ).

questao_9 :-
    pergunta(obstrucao_via_aerea,
        'Q9: Sente a garganta a fechar ou a lingua inchada?'),
    questao_10.

questao_10 :-
    pergunta(respiracao_ruidosa,
        'Q10: Tem respiracao ruidosa, retracoes no peito ou pieira?'),
    questao_11.

% ============================================================
% BLOCO DA TOSSE - Q11 a Q12
% ============================================================

questao_11 :-
    nl, write('[ BLOCO DA TOSSE ]'), nl, nl,
    pergunta(tosse,
        'Q11: Tem tosse nova, piorada ou persistente?'),
    ( sintoma(tosse) ->
        questao_12
    ;
        questao_13
    ).

questao_12 :-
    pergunta(expetoracao,
        'Q12: Tem expetoracao ou outros sintomas associados a tosse?'),
    questao_13.

% ============================================================
% BLOCO OUTROS SINTOMAS E CONDICOES DE RISCO - Q13 a Q14
% ============================================================

questao_13 :-
    nl, write('[ OUTROS SINTOMAS E CONDICOES DE RISCO ]'), nl, nl,
    write('Q13: Tem algum destes sintomas?'), nl,
    write('     (mialgias, dor abdominal, ardor ao urinar, manchas na pele)'), nl,
    pergunta(outros_sintomas, ''),
    questao_14.

questao_14 :-
    write('Q14: Tem alguma condicao de risco?'), nl,
    write('     (oncologia em tratamento, imunodeficiencia, dialise renal,'), nl,
    write('      gravidez, menor de 1 ano, hemoptises,'), nl,
    write('      mais de 65 anos, doenca cronica grave)'), nl,
    pergunta(condicao_risco, ''),
    questao_15.

% ============================================================
% BLOCO OLFATO E PALADAR - Q15 a Q18
% ============================================================

questao_15 :-
    nl, write('[ OLFATO E PALADAR ]'), nl, nl,
    pergunta(perda_olfato,
        'Q15: Tem perda subita de olfato nos ultimos 7 dias?'),
    ( sintoma(perda_olfato) ->
        questao_16
    ;
        questao_17
    ).

questao_16 :-
    pergunta(causa_conhecida_olfato,
        'Q16: A perda de olfato surgiu apos quimioterapia, cirurgia ou traumatismo?'),
    questao_17.

questao_17 :-
    pergunta(perda_paladar,
        'Q17: Tem perda ou alteracao subita do paladar nos ultimos 7 dias?'),
    ( sintoma(perda_paladar) ->
        questao_18
    ;
        questao_19
    ).

questao_18 :-
    pergunta(causa_conhecida_paladar,
        'Q18: A perda de paladar surgiu apos quimioterapia, cirurgia ou traumatismo?'),
    questao_19.

% ============================================================
% CONDICOES SOCIAIS - Q19
% ============================================================

questao_19 :-
    nl, write('[ CONDICOES SOCIAIS ]'), nl, nl,
    write('Q19: Tem condicoes para ficar em casa com seguranca?'), nl,
    write('     (consegue usar o telefone e tem apoio de alguem)'), nl,
    pergunta(condicoes_casa, ''),
    dar_resultado.

% ============================================================
% PREDICADO PERGUNTA
% ============================================================

pergunta(Facto, Texto) :-
    ( Texto \= '' ->
        write(Texto), nl
    ;
        true
    ),
    write('  > '),
    read(Resposta),
    ( Resposta = sim ->
        assertz(sintoma(Facto))
    ; Resposta = nao ->
        true
    ;
        write('  Resposta invalida. Responda com sim. ou nao.'), nl,
        pergunta(Facto, Texto)
    ).

% ============================================================
% DAR RESULTADO
% ============================================================

dar_resultado :-
    nl,
    write('=========================================='), nl,
    inferir(R),
    mostrar_resultado(R),
    nl,
    write('=========================================='), nl, nl,
    % Registar triagem no historico
    findall(S, sintoma(S), Sintomas),
    registar_triagem(Sintomas, R),
    perguntar_explicacao(R).

% ============================================================
% EXPLICACAO OPCIONAL
% ============================================================

perguntar_explicacao(sem_resultado) :- !.
perguntar_explicacao(R) :-
    write('  Deseja ver a explicacao do resultado? (sim./nao.)'), nl,
    write('  > '),
    read(Resp),
    ( Resp = sim ->
        explicar(R)
    ; Resp = nao ->
        nl
    ;
        write('  Resposta invalida. Responda com sim. ou nao.'), nl,
        perguntar_explicacao(R)
    ),
    perguntar_certeza(R).

% ============================================================
% CERTEZA OPCIONAL
% ============================================================

perguntar_certeza(sem_resultado) :- !.
perguntar_certeza(R) :-
    write('  Deseja ver o grau de certeza do resultado? (sim./nao.)'), nl,
    write('  > '),
    read(Resp),
    ( Resp = sim ->
        mostrar_certeza(R)
    ; Resp = nao ->
        nl
    ;
        write('  Resposta invalida. Responda com sim. ou nao.'), nl,
        perguntar_certeza(R)
    ).

mostrar_certeza(R) :-
    inferir_com_certeza(R, CF),
    Percentagem is round(CF * 100),
    nl,
    write('+------------------------------------------+'), nl,
    write('|          GRAU DE CERTEZA                 |'), nl,
    write('+------------------------------------------+'), nl, nl,
    format('  Encaminhamento: ~w~n', [R]),
    format('  Grau de certeza: ~w%~n', [Percentagem]),
    nl,
    mostrar_nivel_certeza(CF),
    nl.

mostrar_nivel_certeza(CF) :-
    ( CF >= 0.95 ->
        write('  Nivel: MUITO ALTO - Encaminhamento praticamente certo.')
    ; CF >= 0.85 ->
        write('  Nivel: ALTO - Encaminhamento muito provavel.')
    ; CF >= 0.75 ->
        write('  Nivel: MODERADO - Encaminhamento provavel.')
    ; CF >= 0.65 ->
        write('  Nivel: BAIXO - Encaminhamento sugerido mas com alguma incerteza.')
    ;
        write('  Nivel: MUITO BAIXO - Recomenda-se confirmacao adicional.')
    ), nl.

% ============================================================
% MOSTRAR RESULTADO
% ============================================================

mostrar_resultado(inem) :-
    write('  RESULTADO: EMERGENCIA - Ligue 112 (INEM)'), nl, nl,
    write('  ACCAO IMEDIATA:'), nl,
    write('    1. Ligue imediatamente para o 112'), nl,
    write('    2. Recolha a morada e telefone do utente'), nl,
    write('    3. Nao desligue ate o INEM atender'), nl.

mostrar_resultado(adr_su) :-
    write('  RESULTADO: ADR-SU - Urgencia Hospitalar'), nl, nl,
    write('  Dirija-se urgentemente ao servico de urgencia'), nl,
    write('  hospitalar mais proximo.'), nl.

mostrar_resultado(adr_csp) :-
    write('  RESULTADO: ADR-CSP - Centro de Saude'), nl, nl,
    write('  Contacte o seu medico assistente ou'), nl,
    write('  dirija-se ao centro de saude.'), nl.

mostrar_resultado(transferencia_sns24) :-
    write('  RESULTADO: Transferencia SNS24'), nl, nl,
    write('  A sua situacao requer outro fluxo de atendimento.'), nl,
    write('  Sera transferido para um enfermeiro senior.'), nl.

mostrar_resultado(autocuidado) :-
    write('  RESULTADO: Autocuidado com isolamento'), nl, nl,
    write('  Pode ficar em casa em isolamento.'), nl,
    write('  Se os sintomas piorarem contacte:'), nl,
    write('    SNS24: 808 24 24 24'), nl.

mostrar_resultado(sem_resultado) :-
    write('  RESULTADO: Nao determinado'), nl, nl,
    write('  Nao foi possivel determinar um encaminhamento.'), nl,
    write('  Contacte o SNS24: 808 24 24 24'), nl.