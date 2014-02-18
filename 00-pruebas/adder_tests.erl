%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @doc Sinxelo servidor con estado para sumar (ficheiro de probas EUnit).
%%% @end
%%%-------------------------------------------------------------------
-module(adder_tests).

-include_lib("eunit/include/eunit.hrl").

%%--------------------------------------------------------------------
%% @doc Meta-caso de proba que encadena varias operación nun mesmo
%%      escenario (interesante para compoñentes con estado).
%% @spec adder_test_() -> boolean()
%% @end
%% --------------------------------------------------------------------
adder_test_() ->
    {setup,
     fun()  -> adder:start() end, % preparar el entorno
     fun(_) -> adder:stop()  end,  % limpiar tras la ejecución
     fun(_) ->
	     {inorder,
 	      [?_assertEqual(  0,  adder:add(0)),
 	       ?_assertEqual(  1,  adder:add(1)),
 	       ?_assertEqual( 11,  adder:add(10)),
 	       ?_assertEqual(  6,  adder:add(-5)),
 	       ?_assertEqual( -5,  adder:add(-11)),
 	       ?_assertEqual(-10,  adder:add(adder:add(0)))]}
     end}.

