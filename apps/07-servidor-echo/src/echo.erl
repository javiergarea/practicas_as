-module(echo).

% Public API
-export([start/0, stop/0, print/1]).

%%--------------------------------------------------------------------
%% @doc Start function.
%% @spec start() -> ok
%% @end
%%--------------------------------------------------------------------
start() ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Stop function.
%% @spec stop() -> ok
%% @end
%%--------------------------------------------------------------------
stop() ->
    erlang:throw(not_implemented).

%%--------------------------------------------------------------------
%% @doc Print function.
%% @spec print(Term :: term()) -> ok
%% @end
%%--------------------------------------------------------------------
print(_Term) ->
    erlang:throw(not_implemented).
