%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Assignment #7: Test state machine (OLD STYLE)
%%%%                                       (POSITIVE TESTING).
%%% @end
%%% Created : 08 Jan 2013 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(echo_positive_eqc).

-include_lib("proper/include/proper.hrl").
%%-include_lib("eqc/include/eqc_statem.hrl").
-compile(export_all).

-define(TEST_MODULE, echo).
-define(SERVER_NAME, echo).

%% Initialize the state
initial_state() ->
    stopped.

%% Command generator, S is the state
command(S) ->
    oneof([{call, ?TEST_MODULE, start, []} || S == stopped] ++
	  [{call, ?TEST_MODULE, print, [message()]} || S == started] ++
	  [{call, ?TEST_MODULE, stop, []} || S == started]).

message() ->
    oneof(["Hola cara de bola",
	   "No te aburres de estos mensajes absurdos?",
	   "Hasta la vista, baby!",
	   "No contaban con mi astucia...",
	   "Enough is enough"]).

%% Next state transformation, S is the current state
next_state(stopped,_V,{call,?TEST_MODULE,start,[]}) ->
    started;
next_state(started,_V,{call,?TEST_MODULE,stop,[]}) ->
    stopped;
next_state(S,_V,{call,_,_,_}) ->
    S.

%% Precondition, checked before command is added to the command sequence
precondition(started,{call,?TEST_MODULE,start,[]}) ->
    false;
precondition(stopped,{call,?TEST_MODULE,print,[_Message]}) ->
    false;
precondition(stopped,{call,?TEST_MODULE,stop,[]}) ->
    false;
precondition(_S,{call,_,_,_}) ->
    true.

%% Postcondition, checked after command has been evaluated
%% OBS: S is the state before next_state(S,_,<command>) 
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
