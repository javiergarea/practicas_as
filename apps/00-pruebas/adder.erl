%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2013
%%% @doc Sinxelo servidor con estado para sumar
%%%
%%% This program is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU General Public License as published by
%%% the Free Software Foundation, either version 3 of the License, or
%%% (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU General Public License for more details.
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
			ok;
        _Other ->
            % flush unwanted messages
            server(AccTotal)
    end.

%%% ----------------------- %%%
