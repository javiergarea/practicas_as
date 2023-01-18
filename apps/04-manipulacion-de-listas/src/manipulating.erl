-module(manipulating).

% Public API
-export([filter/2, reverse/1, concatenate/1, flatten/1]).

%%--------------------------------------------------------------------
%% @doc Filter function.
%% @spec filter(List :: [integer()], N :: integer()) -> [integer()]
%% @end
%%--------------------------------------------------------------------
filter(_List, _N) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Reverse function.
%% @spec reverse(List :: [integer()]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
reverse(_List) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Concatenate function.
%% @spec concatenate(ListOfLists :: [[integer()]]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
concatenate(_ListOfLists) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Flatten function.
%% @spec flatten(DeepList :: [integer() | list()]) -> [integer()]
%% @end
%%--------------------------------------------------------------------
flatten(_DeepList) ->
    erlang:throw(not_implemented).
