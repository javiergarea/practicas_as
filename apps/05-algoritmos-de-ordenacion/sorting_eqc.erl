%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Test properties.
%%% @end
%%% Created : 5 Mar 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(sorting_eqc).

-include_lib("proper/include/proper.hrl").
-compile(export_all).

prop_quicksort() ->
    ?FORALL(L, list(int()),
	    sorting:quicksort(L) == lists:sort(L)).

prop_mergesort() ->
    ?FORALL(L, list(int()),
	    sorting:mergesort(L) == lists:sort(L)).

