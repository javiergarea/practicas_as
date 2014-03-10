%%% -*- coding: utf-8 -*-
%%%-------------------------------------------------------------------
%%% @author Laura Castro <lcastro@udc.es>
%%% @copyright (C) 2013
%%% @doc Sinxelo servidor con estado para sumar (ficheiro de probas EUnit).
%%%
%%% This program is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU General Public License as published by
%%% the Free Software Foundation, either version 3 of the License, or
%%% (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU General Public License for more details.
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

