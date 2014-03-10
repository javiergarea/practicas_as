%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura M. Castro <lcastro@udc.es>
%%% @copyright (C) 2014
%%% @doc Especificación de probas PROPER (máquina de estados finitos)
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
-module(adder_positive_statem).
-behaviour(proper_statem).

-include_lib("proper/include/proper.hrl").

%% CALLBACKS from proper_statem
-export([initial_state/0, command/1, precondition/2, postcondition/3, next_state/3]).

%%--------------------------------------------------------------------
%% @doc Returns the state in which each test case starts.
%% @spec initial_state() -> proper_statem:symbolic_state()
%% @end
%%--------------------------------------------------------------------
initial_state() ->
	{stopped, 0}.

%%--------------------------------------------------------------------
%% @doc Command generator, S is the current state.
%% @spec command(S :: proper_statem:symbolic_state())
%%                 -> proper_statem:symb_call()
%% @end
%%--------------------------------------------------------------------
command(_S) ->
	frequency([{20, {call, adder, start, []}},
			   {20, {call, adder, stop,  []}},
			   {60, {call, adder, add,   [int()]}}]).

%%--------------------------------------------------------------------
%% @doc Next state transformation, S is the current state. Returns
%%      next state.
%% @spec next_state(S :: proper_statem:symbolic_state(),
%%                  V :: proper_symb:var_id(), 
%%                  C :: proper_statem:symb_call())
%%                    -> proper_statem:symbolic_state()
%% @end
%%--------------------------------------------------------------------
next_state({stopped, _S}, _V, {call, adder, start, []}) ->
	{started, 0};
next_state({started, _S}, _V, {call, adder,  stop, []}) ->
	{stopped, 0};
next_state({started,  S}, _V, {call, adder,   add, [N]}) ->
	{started, S+N};
next_state(S, _V, {call, _, _, _}) ->
	S.

%%--------------------------------------------------------------------
%% @doc Precondition, checked before command is added to the command
%%      sequence. 
%% @spec precondition(S :: proper_statem:symbolic_state(),
%%                    C :: proper_statem:symb_call()) -> boolean().
%% @end
%%--------------------------------------------------------------------
precondition({stopped, _S}, {call, adder, start, []}) ->
	true;
precondition({started, _S}, {call, adder,  stop, []}) ->
	true;
precondition({started, _S}, {call, adder,   add, [_N]}) ->
	true;
precondition(_S, {call, _, _, _}) ->
	false.

%%--------------------------------------------------------------------
%% @doc Postcondition, checked after command has been evaluated
%%      Note: S is the state before next_state(S,_,C) 
%% @spec postcondition(S :: proper_statem:symbolic_state(),
%%                     C :: proper_statem:call(), 
%%                     Res :: term()) -> boolean()
%% @end
%%--------------------------------------------------------------------
postcondition({stopped, _S}, {call, adder, start, []},   Res) ->
	Res == started;
postcondition({started, _S}, {call, adder, stop,  []},   Res) ->
	Res == stopped;
postcondition({started,  S}, {call, adder,  add,  [N]},  Res) ->
	Res == (S+N);
postcondition(_S, {call, _, _, _}, _Res) ->
	false.



%%--------------------------------------------------------------------
%% @doc Default property
%% @spec prop_adder() -> proper:test()
%% @end
%%--------------------------------------------------------------------
prop_adder() ->
	?FORALL(Cmds, commands(?MODULE),
			begin
				{H, S, Res} = run_commands(?MODULE,Cmds),
				cleanup(),
				?WHENFAIL(io:format("History: ~p\nState: ~p\nRed: ~p\n", [H, S, Res]),
						  aggregate(command_names(Cmds), Res == ok))
			end).

%%--------------------------------------------------------------------
%% @doc Default property (parallel version)
%% @spec prop_parallel_adder() -> proper:test()
%% @end
%%--------------------------------------------------------------------
prop_parallel_adder() ->
	?FORALL(Cmds, parallel_commands(?MODULE),
			begin
				{_Sequential, _Parallel, Res} = run_parallel_commands(?MODULE,Cmds),
				cleanup(),
				Res == ok
			end).



%%--------------------------------------------------------------------
%% Internal wrappers and auxiliary functions
%%--------------------------------------------------------------------
cleanup() ->
	catch adder:stop().
