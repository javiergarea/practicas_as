%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Assignment #7: Test state machine (OLD STYLE).
%%% @end
%%% Created : 08 Jan 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(echo_eqc).

-include_lib("proper/include/proper.hrl").
%%-include_lib("eqc/include/eqc_statem.hrl").
-compile(export_all).

-define(TEST_MODULE, echo).
-define(SERVER_NAME, echo).

%% Initialize the state
initial_state() ->
    stopped.

%% Command generator, S is the state
command(_S) ->
    oneof([{call, ?MODULE, start, []}] ++
	  [{call, ?MODULE, print, [message()]}] ++
	  [{call, ?MODULE, stop, []}]).

message() ->
    oneof(["Hola cara de bola",
	   "No te aburres de estos mensajes absurdos?",
	   "Hasta la vista, baby!",
	   "No contaban con mi astucia...",
	   "Enough is enough"]).

%% Next state transformation, S is the current state
next_state(_S,_V,{call,?MODULE,start,[]}) ->
    started;
next_state(_S,_V,{call,?MODULE,stop,[]}) ->
    stopped;
next_state(S,_V,{call,_,_,_}) ->
    S.

%% Precondition, checked before command is added to the command sequence
precondition(_S,{call,_,_,_}) ->
    true.

%% Postcondition, checked after command has been evaluated
%% OBS: S is the state before next_state(S,_,<command>) 
postcondition(started,{call,_,start,_},Res) ->
    Res == already_started;
postcondition(stopped,{call,_,start,_},Res) ->
    Res == ok;
postcondition(started,{call,_,print,_},Res) ->
    Res == ok;
postcondition(stopped,{call,_,print,_},Res) ->
    Res == server_not_started;
postcondition(started,{call,_,stop,_},Res) ->
    Res == ok;
postcondition(stopped,{call,_,stop,_},Res) ->
    Res == already_stopped;
postcondition(_S,{call,_,_,_},_Res) ->
    true.

%% PROPERTY
prop_echoserver() ->
    ?FORALL(Cmds,commands(?MODULE),
	    begin
 		startup(),
		{_History,State,Res} = run_commands(?MODULE,Cmds),
		cleanup(State),
		Res==ok
	    end).

%% Test function wrappers
start() ->
    try	?TEST_MODULE:start() of
	ok ->
	    ok
    catch
	error:badarg ->
	    already_started
    end.

print(Message) ->
    try	?TEST_MODULE:print(Message) of
	ok ->
	    ok
    catch
	error:badarg ->
	    server_not_started
    end.

stop() ->
    try	?TEST_MODULE:stop() of
	ok ->
	    ok
    catch
	error:badarg ->
	    already_stopped
    end.


%% Private utilitary stuff
startup() ->
    ok.

cleanup(_Args) ->
    case whereis(?SERVER_NAME) of
	undefined ->
	    ok;
	_Pid ->
	    ?TEST_MODULE:stop()
    end.
