-module(db).

% Public API
-export([new/0, write/3, delete/2, read/2, match/2, destroy/1]).

%%--------------------------------------------------------------------
%% @doc New function.
%% @spec new() -> term()
%% @end
%%--------------------------------------------------------------------
new() ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Write function.
%% @spec write(Key :: integer, Element :: term(), DbRef :: term()) -> term()
%% @end
%%--------------------------------------------------------------------
write(_Key, _Element, _DbRef) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Delete function.
%% @spec delete(Key :: integer, DbRef :: term()) -> term()
%% @end
%%--------------------------------------------------------------------
delete(_Key, _DbRef) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Read function.
%% @spec read(Key :: integer(), DbRef :: term()) -> {ok, Element}
%% | {error, instance}
%% @end
%%--------------------------------------------------------------------
read(_Key, _DbRef) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Match function.
%% @spec match(Element :: term(), DbRef :: term()) -> [integer()]
%% @end
%%--------------------------------------------------------------------
match(_Key, _DbRef) ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Destroy function.
%% @spec destroy(DbRef :: term()) -> ok
%% @end
%%--------------------------------------------------------------------
destroy(_DbRef) ->
    erlang:throw(not_implemented).
