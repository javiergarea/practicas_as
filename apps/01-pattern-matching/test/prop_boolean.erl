%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Assignment #1: Simple pattern matching
%%% Test properties.
%%% @end
%%% Created : 19 Feb 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(prop_boolean).

-include_lib("proper/include/proper.hrl").

-compile([export_all, nowarn_export_all]).

prop_b_not() ->
    ?FORALL(A,bool(),
	    boolean:b_not(A) == not A).

prop_b_and() ->
    ?FORALL({A, B}, {bool(), bool()},
	    boolean:b_and(A, B) == (A and B)).

prop_b_or() ->
    ?FORALL({A, B},{bool(), bool()},
	    boolean:b_or(A, B) == (A or B)).
