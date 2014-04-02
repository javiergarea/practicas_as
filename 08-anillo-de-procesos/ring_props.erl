%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Práctica #8: O anel de procesos.
%%% @end
%%%-------------------------------------------------------------------
-module(ring_props).

-include_lib("proper/include/proper.hrl").
-compile(export_all).

%% Módulo de implementación que imos probar
-define(TEST_MODULE, ring).


% Xeradores de datos
nprocs() ->
    integer(1, inf). % xerar números > 0 -> probas positivas

nmsgs() ->
    integer(1, inf). % xerar números > 0 -> probas positivas

message() ->
    oneof(["Hola cara de bola",
	       "No te aburres de estos mensajes absurdos?",
	       "Hasta la vista, baby!",
	       "No contaban con mi astucia...",
	       "Enough is enough"]).


%% Propiedade xeral
prop_ring() ->
    ?FORALL({NProcs, NMsgs, Msg}, {nprocs(), nmsgs(), message()},
            begin
                Tracer = start_tracing(),
                ok = ?TEST_MODULE:start(NProcs, NMsgs, Msg),
                timer:sleep(NProcs * NMsgs * 10), % agardamos algo de tempo para que o anel transmita as mensaxes
                                                  % e rematar de recoller as trazas
                Trazas = stop_tracing(Tracer),
                ?WHENFAIL(io:format("NProcs: ~p; NMsgs: ~p; Msg: ~p~nTrazas: ~p~n", [NProcs, NMsgs, Msg, Trazas]),
                          conjunction([{creacion_de_procesos,     creacion(NProcs, Trazas)},
                                       {envio_de_mensaxes,        envio(NMsgs, Msg, Trazas)},
                                       {recepcion_de_mensaxes,    recepcion(NMsgs, Msg, Trazas)},
                                       {desaparicion_de_procesos, destruccion(NProcs, Trazas)}]))
            end).


%% Sub-propiedades
% (1) Comprobamos que se crean tantos procesos como se indica
creacion(NProcs, Trazas) ->
    ParentsAndChildren = [{Parent, Child} || {trace, Parent, spawn, Child, _Fun} <- Trazas],
    length(ParentsAndChildren) == NProcs.

% (2) Comprobamos que se envía a mensaxe o número de veces axeitado
envio(NMsgs, Msg, Trazas) ->
    SendersAndReceivers = [{From, To} || {trace, From, send, {_, What}, To} <- Trazas, What == Msg],
    length(SendersAndReceivers) == NMsgs.

% (3) Comprobamos que se recibe a mensaxe o número de veces axeitado
recepcion(NMsgs, Msg, Trazas) ->
    Receivers = [{Who, What} || {trace, Who, 'receive', {_, What}} <- Trazas, What == Msg],
    length(Receivers) == NMsgs.

% (4) Comprobamos que se destrúen os procesos
destruccion(NProcs, Trazas) ->
    Stoppers = [{From, To} || {trace, From, send, stop, To} <- Trazas],
    Stopped =  [Who || {trace, Who, 'receive', stop} <- Trazas],
    Exited =  [Who || {trace, Who, exit, normal} <- Trazas],
    (length(Stoppers) == length(Stopped)) andalso (length(Exited) == NProcs).

% Outras posibles sub-propiedades:
% (5) as parellas envío-recepción son correctas (circulares)
% ...


%% Funcionalidades internas
start_tracing() ->
    Tracer = spawn(fun tracer/0),
    erlang:trace(all, true, [procs, send, 'receive', {tracer, Tracer}]),
    Tracer.

stop_tracing(Tracer) ->
    erlang:trace(all, false, [all]), % desabilitamos as trazas
    Tracer ! {collect, self()}, % recollemos as trazas do proceso Tracer
    receive {Trazas, Tracer} -> Trazas end.


tracer() ->
    tracer([]).

tracer(TraceList) ->
    receive
        {collect, From} ->
            From ! {lists:reverse(TraceList), self()};
        Other -> 
            tracer([Other|TraceList])
    end.

