-module(sorting).

% Public API
-export([quicksort/1, mergesort/1]).

%%--------------------------------------------------------------------
%% @doc Quicksort function.
%% @spec quicksort(List :: [integer()]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
quicksort(_List) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Mergesort function.
%% @spec mergesort(List :: [integer()]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
mergesort(_List) ->
    erlang:throw(not_implemented).
