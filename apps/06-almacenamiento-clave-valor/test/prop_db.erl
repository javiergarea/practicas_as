%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2012, Laura Castro
%%% @doc Assignment #4: Test state machine.
%%% @end
%%% Created : 31 Oct 2012 by Laura Castro <lcastro@udc.es>
%%%-------------------------------------------------------------------
-module(prop_db).

-include_lib("proper/include/proper.hrl").

-compile([export_all, nowarn_export_all]).

-define(TEST_MODULE, db).

%% Initialize the state
initial_state() ->
    [].

%% Command generator, S is the state
command(S) ->
    oneof([{call, ?TEST_MODULE, new, []} || S == []]
	  ++ [{call, ?TEST_MODULE, write, [key(), element(), oneof(S)]} || S /= []]
	  ++ [{call, ?TEST_MODULE, delete, [key(), oneof(S)]} || S /= []]
	  ++ [{call, ?TEST_MODULE, read, [key(), oneof(S)]} || S /= []]
	  ++ [{call, ?TEST_MODULE, match, [element(), oneof(S)]} || S /= []]
	  ++ [{call, ?TEST_MODULE, destroy, [oneof(S)]} || S /= []]
	 ).

key() ->
    int().

element() ->
    largeint().

%% Next state transformation, S is the current state
next_state([],_V,{call,?TEST_MODULE,new,[]}) ->
    [[]];
next_state([S],_V,{call,?TEST_MODULE,write,[Key, Element, _DbRef]}) ->
    [[{Key, Element} | S]];
next_state([S],_V,{call,?TEST_MODULE,delete,[Key, DbRef]}) ->
    case lists:keysearch(Key, 1, DbRef) of
	{value, {Key, Element}} -> 
	    [S -- [{Key, Element}]];
	false ->
	    [S]
    end;
next_state([_S],_V,{call,?TEST_MODULE,destroy,[_DbRef]}) ->
    [];
next_state(S,_V,{call,_,_,_}) ->
    S.

%% Precondition, checked before command is added to the command sequence
precondition(_S,{call,_,_,_}) ->
    true.

%% Postcondition, checked after command has been evaluated
%% OBS: S is the state before next_state(S,_,<command>) 
postcondition([S],{call,?TEST_MODULE,write,[Key, Element, _DbRef]},Res) ->
    lists:sort([{Key, Element} | S]) == lists:sort(Res);
postcondition([S],{call,?TEST_MODULE,delete,[Key, _DbRef]},Res) ->
    lists:sort(lists:keydelete(Key, 1, S)) == lists:sort(Res);
postcondition([S],{call,?TEST_MODULE,read,[Key, _DbRef]},Res) ->
    case lists:keysearch(Key, 1, S) of
	{value, {Key, Element}} ->
	    Res == {ok, Element};
	false ->
	    Res == {error, instance}
    end;
postcondition([S],{call,?TEST_MODULE,match,[Element, _DbRef]},Res) ->
    Expected = [ AKey || {AKey, AnElement} <- S, AnElement == Element],
    lists:sort(Expected) == lists:sort(Res);
postcondition(_S,{call,_,_,_},_Res) ->
    true.

prop_db() ->
    ?FORALL(Cmds,commands(?MODULE),
	    begin
		{H,S,Res} = run_commands(?MODULE,Cmds),
		?WHENFAIL(
		   io:format("History: ~p\nState: ~p\nRes: ~p\n",[H,S,Res]),
		   Res == ok)
	    end).
