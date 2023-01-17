%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura M. Castro <lcastro@udc.es>
%%% @copyright (C) 2013
%%% @doc
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
-module(delete_props).

-export([delete/2, list_and_element/0]).

-include_lib("proper/include/proper.hrl").

%==============================================================================
%% Our test subject: a faulty implementation of lists:delete/2, it will fail if
%% the list contains duplicates.

delete(X, L) ->
    delete(X, L, []).

delete(_, [], Acc) ->
    lists:reverse(Acc);
delete(X, [X|Rest], Acc) ->
    lists:reverse(Acc) ++ Rest;
delete(X, [Y|Rest], Acc) ->
    delete(X, Rest, [Y|Acc]).

%==============================================================================
%% Properties for delete.
%% Test each property with proper:quickcheck(delete_prop:property_name()), or
%% all of them at once with proper:module(delete_prop).

prop_delete() ->
    ?FORALL({I,L}, {integer(),list(integer())},
			not lists:member(I, delete(I,L))).

%---------------------------------------

prop_delete_more() ->
    numtests(1000,
			 ?FORALL({I,L}, {integer(),list(integer())},
					 not lists:member(I, delete(I,L)))).

%---------------------------------------

prop_delete_with_stats() ->
    ?FORALL({I,L}, {integer(),list(integer())},
			collect({I,L},
					not lists:member(I, delete(I,L)))).

%---------------------------------------

prop_delete_with_stats2() ->
    ?FORALL({I,L}, {integer(),list(integer())},
			collect(lists:member(I,L),
					not lists:member(I, delete(I,L)))).

%---------------------------------------

prop_delete_with_stats3() ->
    ?FORALL({I,L}, {integer(),list(integer())},
			collect(ocurrences(I,L),
					not lists:member(I, delete(I,L)))).

%---------------------------------------

prop_delete_only_interesting_testcases() ->
    ?FORALL({I,L}, {integer(),list(integer())},
			?IMPLIES(lists:member(I,L),
					 not lists:member(I, delete(I,L)))).

%---------------------------------------

ocurrences(_X, []) ->
	0;
ocurrences(X, [X|T]) ->
	1 + ocurrences(X, T);
ocurrences(X, [_H|T]) ->
	ocurrences(X, T).

prop_delete_at_least_one() ->
	fails(?FORALL({I, L}, {integer(), list(integer())},
				  ?IMPLIES(ocurrences(I, L) > 1,
						   not lists:member(I, lists:delete(I,L))))).

%---------------------------------------

list_and_element() ->
    ?SUCHTHAT({I,L}, {integer(),list(integer())},
			  lists:member(I,L)).

prop_delete_only_interesting_testcases2() ->
    ?FORALL({I,L}, list_and_element(),
			not lists:member(I, delete(I,L))).

%---------------------------------------

list_and_element2() ->
    ?LET(L, non_empty(list(integer())),
		 {oneof(L),L}).

prop_delete_only_interesting_testcases3() ->
    ?FORALL({I,L}, list_and_element2(),
			not lists:member(I, delete(I,L))).

%---------------------------------------

list_and_element3() ->
    ?LET({I, L}, {integer(), list(integer())},
         {I, [I | L]}).

prop_delete_only_interesting_testcases4() ->
	?FORALL({I, L}, list_and_element3(),
			not lists:member(I, lists:delete(I,L))).

%---------------------------------------

list_and_element4() ->
	?SUCHTHAT({I, L}, list_and_element3(),
			  ocurrences(I, L) < 2).

prop_delete_only_interesting_testcases5() ->
	?FORALL({I, L}, list_and_element4(),
			not lists:member(I, lists:delete(I,L))).

