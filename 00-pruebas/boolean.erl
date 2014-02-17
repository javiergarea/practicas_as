%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Práctica #1: Simple pattern matching
%%% @end
%%% Created : 30 Oct 2012 by Laura Castro <lcastro@udc.es>
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
