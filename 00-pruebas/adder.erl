%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Sinxelo servidor con estado para sumar
%%% @end
%%%-------------------------------------------------------------------
-module(adder).

%% PUBLIC API
-export([start/0, stop/0, add/1]).

%%--------------------------------------------------------------------
%% @doc Lanza o servidor (ou falla se xa existe).
%% @spec start() -> started | exception
%% @end
%% --------------------------------------------------------------------
start() ->
    register(adder, spawn(fun server/0)),
    started.

%%--------------------------------------------------------------------
%% @doc Para o servidor (ou falla se non estaba arrincado).
%% @spec stop() -> stopped | exception
%% @end
%% --------------------------------------------------------------------
stop() ->
    Pid = whereis(adder),
	unregister(adder),
    Pid ! stop,
    stopped.

%%--------------------------------------------------------------------
%% @doc Manda un enteiro ao servidor para que acumule a cantidade.
%% @spec add(N :: integer()) -> integer()
%% @end
%% --------------------------------------------------------------------
add(N) ->
    adder ! {add, N, self()},
    Pid = whereis(adder),
    receive
	{result, M, Pid} -> M
    end.



%%% Internal implementation %%%

server() ->
    server(0).

server(AccTotal) ->
    receive
		{add, N, From} ->
			From ! {result, N+AccTotal, self()},
			server(N+AccTotal);
		stop ->
			ok
    end.

%%% ----------------------- %%%
