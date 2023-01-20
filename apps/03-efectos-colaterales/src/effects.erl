-module(effects).

% Public API
-export([print/1, even_print/1]).

%%--------------------------------------------------------------------
%% @doc Print function.
%% @spec print(N :: pos_integer()) -> ok
%% @end
%%--------------------------------------------------------------------
print(_N) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Even print function.
%% @spec even_print(N :: pos_integer()) -> ok
%% @end
%%--------------------------------------------------------------------
even_print(_N) ->
    erlang:throw(not_implemented).
