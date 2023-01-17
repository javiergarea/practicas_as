%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2013
%%% @doc Práctica #1: Simple pattern matching
%%%      Test properties.
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
-module(boolean_props).

-include_lib("proper/include/proper.hrl").
-compile(export_all).

%%--------------------------------------------------------------------
%% @doc Test property for operator 'not'.
%% @spec prop_b_not() -> boolean()
%% @end
%%--------------------------------------------------------------------
prop_b_not() ->
    ?FORALL(A,bool(),
	    boolean:b_not(A) == not A).

%%--------------------------------------------------------------------
%% @doc Test property for operator 'and'.
%% @spec prop_b_and() -> boolean()
%% @end
%%--------------------------------------------------------------------
prop_b_and() ->
    ?FORALL(A, bool(),
			?FORALL(B, bool(),
					boolean:b_and(A, B) == (A and B))).

%%--------------------------------------------------------------------
%% @doc Test property for operator 'or'.
%% @spec prop_b_or() -> boolean()
%% @end
%%--------------------------------------------------------------------
prop_b_or() ->
    ?FORALL({A, B},{bool(), bool()},
	    boolean:b_or(A, B) == (A or B)).
