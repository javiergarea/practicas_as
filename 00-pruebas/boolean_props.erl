%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Práctica #1: Simple pattern matching
%%%      Test properties.
%%% @end
%%% Created : 19 Feb 2013 by Laura Castro <lcastro@udc.es>
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
    ?FORALL({A, B}, {bool(), bool()},
	    boolean:b_and(A, B) == (A and B)).

%%--------------------------------------------------------------------
%% @doc Test property for operator 'or'.
%% @spec prop_b_or() -> boolean()
%% @end
%%--------------------------------------------------------------------
prop_b_or() ->
    ?FORALL({A, B},{bool(), bool()},
	    boolean:b_or(A, B) == (A or B)).
