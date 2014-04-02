%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Práctica #9:O anel de procesos cruzado.
%%% @end
%%%-------------------------------------------------------------------
-module(crossring).

%% PUBLIC API
-export([start/3]).

-define(CROSSRING, crossring).

%%--------------------------------------------------------------------
%% @doc Starts the ring
%% @spec start(nat(), nat(), any()) -> ok
%% @end
%%--------------------------------------------------------------------
start(ProcNum, MsgNum, Message) when (ProcNum > 0), (MsgNum > 0) ->
    true = register(?CROSSRING, spawn(fun() -> init_master(ProcNum-1, MsgNum, Message) end)),
    ok.


% Funcións internas
init_master(0, MsgNum, Message) ->
    whereis(?CROSSRING) ! {MsgNum-1, Message, any},
    loop(whereis(?CROSSRING));
init_master(ProcNum, MsgNum, Message) ->
    Half = ProcNum div 2,
    Rest = ProcNum rem 2,
    case {Half > 0, Half+Rest > 0} of
        {true, true} ->
            Left = spawn(fun() -> init(Half-1) end),
            Right = spawn(fun() -> init(Half+Rest-1) end),
            % poderiamos escoller por donde enviar a primeira mensaxe doutro xeito (p.ex. aleatoriamente, alternadamente...)
            Left ! {MsgNum-1, Message, left},
            loop_master(Left, Right);
        {false, true} ->
            Right = spawn(fun() -> init(Half+Rest-1) end),
            Right ! {MsgNum-1, Message, any},
            loop(Right)
        % outras opcións non poden darse
    end.

init(0) ->
    loop(whereis(?CROSSRING));
init(ProcNum) ->
    Next = spawn(fun() -> init(ProcNum-1) end),
    loop(Next).


loop_master(Left, Right) ->
    receive
        {0, _Message, _From} ->
            %io:format("[~p] Received '~p', initiating stop message chain~n", [self(), Message]),
            Left ! stop,
            Right ! stop,
            unregister(?CROSSRING),
            ok;
        {MsgNum, Message, right} ->
            %io:format("[~p] Received '~p', from [~p], resending to [~p]...~n", [self(), Message, Right, Left]),
            Left ! {MsgNum-1, Message, left},
            loop_master(Left, Right);
        {MsgNum, Message, left} ->
            %io:format("[~p] Received '~p', from [~p], resending to [~p]...~n", [self(), Message, Left, Right]),
            Right ! {MsgNum-1, Message, right},
            loop_master(Left, Right);
        stop ->
            %io:format("[~p] Received stop, initiating stop message chain~n", [self(), Message]),
            Left ! stop,
            Right ! stop,
            unregister(?CROSSRING),
            ok;
        _Other ->
            % flush unexpected messages
            loop_master(Left, Right)
    end.

loop(Next) ->
    receive
        {0, _Message, _From} ->
            %io:format("[~p] Received '~p'~n", [self(), Message]),
            Next ! stop,
            ok;
        {MsgNum, Message, From} ->
            %io:format("[~p] Received '~p', resending to [~p]...~n", [self(), Message, Next]),
            Next ! {MsgNum-1, Message, From},
            loop(Next);
        stop ->
            %io:format("[~p] Received stop, stopping & resending to [~p]~n", [self(), Next]),
            catch Next ! stop,
            ok;
        _Other ->
            % flush unexpected messages
            loop(Next)
    end.
	    
