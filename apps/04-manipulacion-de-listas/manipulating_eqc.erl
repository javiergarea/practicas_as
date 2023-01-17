%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Test properties.
%%% @end
%%% Created : 5 Mar 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(manipulating_eqc).

-include_lib("proper/include/proper.hrl").
-compile(export_all).

prop_filter() ->
    ?FORALL({L, I}, {list(int()), int()},
	    manipulating:filter(L, I) == [ X || X <- L, X =< I]).

prop_reverse() ->
    ?FORALL(L, list(int()),
	    manipulating:reverse(L) == lists:reverse(L)).

prop_concatenate() ->
    ?FORALL(L, list(list(int())),
            manipulating:concatenate(L) == lists:append(L)).

prop_flatten() ->
    ?FORALL(L, nestedList(),
	    manipulating:flatten(L) == lists:flatten(L)).

% not the best generator in the world
nestedList() ->
    list(oneof([int(), list(int()), list(list(int()))])).
