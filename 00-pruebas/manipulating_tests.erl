%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Manexo de listas (fichero de probas eUnit)
%%% @end
%%%-------------------------------------------------------------------
-module(manipulating_tests).

-include_lib("eunit/include/eunit.hrl").

%%--------------------------------------------------------------------
%% @doc Definición de caso de proba para filter/2
%% @spec filter_test() -> boolean()
%% @end
%% --------------------------------------------------------------------
filter_test() ->
    ?assert([1,2,3] == manipulating:filter([1,2,3,4,5], 3)).

%%--------------------------------------------------------------------
%% @doc Definición de caso de proba para badfilter/2
%% @spec badfilter_test() -> boolean()
%% @end
%% --------------------------------------------------------------------
badfilter_test() ->
    ?assertEqual([1,2,3], manipulating:badfilter([1,2,3,4,5], 3)).

%%--------------------------------------------------------------------
%% @doc Definición de caso de proba para reverse/1
%% @spec reverse_test() -> boolean()
%% @end
%% --------------------------------------------------------------------
reverse_test() ->
    ?assertEqual([3,2,1], manipulating:reverse([1,2,3])).

%%--------------------------------------------------------------------
%% @doc Definición de caso de proba para concatenate/1
%% @spec concatenate_test() -> boolean()
%% @end
%% --------------------------------------------------------------------
concatenate_test() ->
    ?assertMatch([_,_,_,_,five], manipulating:concatenate([[1,2,3], [], [4, five]])).

%%--------------------------------------------------------------------
%% @doc Definición de caso de proba para flatten/1
%% @spec flatten_test() -> boolean()
%% @end
%% --------------------------------------------------------------------
flatten_test() ->
    ?assertEqual([1,2,3,4,5,6], manipulating:flatten([[1,[2,[3],[]]], [[[4]]], [5,6]])).

%%--------------------------------------------------------------------
%% @doc Meta-caso de proba que agrupa a execución de todos casos de
%%      proba definidos neste módulo.
%% @spec manipulating_test_() -> boolean()
%% @end
%% --------------------------------------------------------------------
manipulating_test_() ->
    [{"Filter should filter",   fun filter_test/0},
     {"Badfilter also filters", fun badfilter_test/0},
     {"Reverse gives it upside-down", fun reverse_test/0},
     {"Concatenates joins pieces", fun concatenate_test/0},
     {"Flatten makes it flat",     fun flatten_test/0}].
