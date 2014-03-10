%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2013
%%% @doc Práctica #1: Simple pattern matching
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
-module(boolean).

% Public API
-export([b_not/1, b_and/2, b_or/2]).

%%--------------------------------------------------------------------
%% @doc Operator 'not'.
%% @spec b_not(Value :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_not(true) ->
    false;
b_not(false) ->
    true.

%%--------------------------------------------------------------------
%% @doc Operator 'and'.
%% @spec b_and(Value1 :: boolean(),
%%             Value2 :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_and(true, true) ->
    true;
b_and(Other, Another) when is_atom(Other), is_atom(Another) ->
    false.

%%--------------------------------------------------------------------
%% @doc Operator 'or'.
%% @spec b_or(Value1 :: boolean(),
%%            Value2 :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_or(false, false) ->
    false;
b_or(Other, Another) when is_atom(Other), is_atom(Another)->
    true.
