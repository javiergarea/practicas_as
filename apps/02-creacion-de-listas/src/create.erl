-module(create).

% Public API
-export([create/1, reverse_create/1]).

%%--------------------------------------------------------------------
%% @doc Create function.
%% @spec create(Value :: pos_integer()) -> list()
%% @end
%%--------------------------------------------------------------------
create(_Value) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Reverse create function.
%% @spec reverse_create(Value :: pos_integer()) -> list()
%% @end
%%--------------------------------------------------------------------
reverse_create(_Value) ->
    erlang:throw(not_implemented).
