%%% -*- coding: utf-8 -*-
-module(boolean).

% Public API
-export([b_not/1, b_and/2, b_or/2]).

%%--------------------------------------------------------------------
%% @doc Operator 'not'.
%% @spec b_not(Value :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_not(_Value) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Operator 'and'.
%% @spec b_and(Value1 :: boolean(),
%%             Value2 :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_and(_Value1, _Value2) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Operator 'or'.
%% @spec b_or(Value1 :: boolean(),
%%            Value2 :: boolean()) -> boolean()
%% @end
%%--------------------------------------------------------------------
b_or(_Value1, _Value2) ->
    erlang:throw(not_implemented).
