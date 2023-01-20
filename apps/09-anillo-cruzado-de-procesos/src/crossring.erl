-module(crossring).

% Public API
-export([start/3]).

%%--------------------------------------------------------------------
%% @doc Start function.
%% @spec start(ProcNum :: pos_integer(), MsgNum :: pos_integer(), Message :: term()) -> ok
%% @end
%%--------------------------------------------------------------------
start(_ProcNum, _MsgNum, _Message) ->
    erlang:throw(not_implemented).
