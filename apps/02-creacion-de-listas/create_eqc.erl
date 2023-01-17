%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Assignment #2: Creating lists
%%% Test properties.
%%% @end
%%% Created : 26 Feb 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(create_eqc).

-include_lib("proper/include/proper.hrl").
-compile(export_all).

prop_create() ->
    ?FORALL(I, positive(),
	    create:create(I) == lists:seq(1, I)).

prop_reverse_create() ->
    ?FORALL(I, positive(),
	    create:reverse_create(I) == lists:reverse(lists:seq(1, I))).


% Generators
positive() ->
    ?SUCHTHAT(I, nat(), I > 0).
