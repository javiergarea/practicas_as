%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Práctica #8: O anel de procesos (versión sen stop e na que o
%%% MsgNum é global ao anel).
%%% @end
%%%-------------------------------------------------------------------
-module(ring).

%% PUBLIC API
-export([start/3]).

-define(RING, ring).

%%--------------------------------------------------------------------
%% @doc Starts the ring
%% @spec start(nat(), nat(), any()) -> ok
%% @end
%%--------------------------------------------------------------------
start(ProcNum, MsgNum, Message) when (ProcNum > 0), (MsgNum > 0) ->
    true = register(?RING, spawn(fun() -> init(ProcNum-1, MsgNum, Message) end)),
    ok.

% Funcións internas

init(0, MsgNum, Message) ->
    whereis(?RING) ! {MsgNum-1, Message},
    loop(whereis(?RING));
init(ProcNum, MsgNum, Message) ->
    Next = spawn(fun() -> init(ProcNum-1, MsgNum, Message) end),
    loop(Next).

loop(Next) ->
    receive
        {0, _Message} ->
            %io:format("[~p] Received last message '~p', stopping now~n", [self(), Message]),
            Next ! stop,
            case {whereis(?RING), self()} of
                {Pid, Pid} -> unregister(?RING);
                _Other     -> ok
            end,
            ok;
        {MsgNum, Message} ->
            %io:format("[~p] Received '~p', resending to [~p]...~n", [self(), Message, Next]),
            Next ! {MsgNum-1, Message},
            loop(Next);
        stop ->
            %io:format("[~p] Received stop, stopping & resending to [~p]~n", [self(), Next]),
            Next ! stop,
            ok;
        _Other ->
	        % flush unexpected messages
            loop(Next)
    end.

