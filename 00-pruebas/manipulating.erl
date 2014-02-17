%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2014, Laura Castro
%%% @doc Manexo de listas
%%%
%%% filter/2
%%% Exemplo: filter([1,2,3,4,5], 3) ⇒ [1,2,3].
%%%
%%% reverse/1
%%% Exemplo: reverse([1,2,3]) ⇒ [3,2,1].
%%%
%%% concatenate/1
%%% Examplo: concatenate([[1,2,3], [], [4, five]]) ⇒ [1,2,3,4,five].
%%% 
%%% flatten/1
%%% Example: flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]) ⇒ [1,2,3,4,5,6].
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(manipulating).

%% PUBLIC API
-export([filter/2, badfilter/2, reverse/1, concatenate/1, flatten/1]).

%%--------------------------------------------------------------------
%% @doc Dada unha lista de enteiros e un enteiro, devolve unha
%%      sublista con todos os enteiros menores ou iguais que o dado.
%% @spec filter(List :: [integer()], I :: integer()) -> [integer()]
%% @end
%% --------------------------------------------------------------------
filter(List, I) ->
    acc_filter(List, I, []).

acc_filter([], _I, Acc) ->
    Acc;
acc_filter([H | T], I, Acc) when H =< I ->
    acc_filter(T, I, Acc ++ [H]);
acc_filter([_H | T], I, Acc) ->
    acc_filter(T, I, Acc).

%%--------------------------------------------------------------------
%% @doc Dada unha lista de enteiros e un enteiro, devolve unha
%%      sublista con todos os enteiros menores ou iguais que o dado.
%%      Esta implementación do filtro resulta demasiado imperativa.
%% @spec badfilter(List :: [integer()], I :: integer()) -> [integer()]
%% @end
%% --------------------------------------------------------------------
badfilter(List, I) ->
		case List of
				[] ->
						[];
				[H | T] when H =< I ->
						[H] ++ badfilter(T, I);
				[_H | T] ->
						badfilter(T, I)
		end.

%%--------------------------------------------------------------------
%% @doc Dada unha lista de enteiros, devolve unha lista cos mesmos
%%      elementos na orde inversa.
%% @spec reverse(List :: [integer()]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
reverse(List) ->
    acc_reverse(List, []).

acc_reverse([], Rev) ->
    Rev;
acc_reverse([H | T], Rev) ->
    acc_reverse(T, [H | Rev]).

%%--------------------------------------------------------------------
%% @doc Dada unha lista de listas, devolve todas concatenadas.
%% @spec concatenate(ListOfLists :: [list()]) -> list()
%% @end
%%--------------------------------------------------------------------
concatenate(ListOfLists) ->
    acc_concatenate(ListOfLists, []).

acc_concatenate([], Acc) ->
    Acc;
acc_concatenate([H | T], Acc) when is_list(H) ->
    acc_concatenate(T, Acc ++ H).

%%--------------------------------------------------------------------
%% @doc Dada unha lista de listas de calquera profundidade, devolve a
%%      lista aplanada.
%% @spec flatten(ListOfNestedLists :: [lists()]) -> list()
%% @end
%%--------------------------------------------------------------------
flatten(ListOfNestedLists) ->
    acc_flatten(ListOfNestedLists, []).

acc_flatten([], Acc) ->
    Acc;
acc_flatten([H | T], Acc) when is_list(H) ->
    acc_flatten(H ++ T, Acc);
acc_flatten([H | T], Acc) ->
    acc_flatten(T, Acc ++ [H]).

