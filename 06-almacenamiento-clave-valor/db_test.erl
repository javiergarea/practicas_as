%%% @author Laura M. Castro
%%% @doc
%%% Unit test module for db.erl using EUnit
%%% @end
%%% Created :  5 Mar 2013 by Laura M. Castro

-module(db_test).

-include_lib("eunit/include/eunit.hrl").

escenariosdb_test_() ->
    {setup,
     fun db:new/0,     % prepara el entorno para la ejecución de la prueba: crea la BD
     fun db:destroy/1, % limpia el entorno después de la ejecución de la prueba: destruye la BD
     fun(DbRef) ->
	     {inparallel, [escenario0(DbRef),
			   escenario1(DbRef),
			   escenario2(DbRef),
			   escenario3(DbRef),
			   escenario4(DbRef),
			   escenario5(DbRef),
			   escenario6(DbRef),
			   escenario7(DbRef),
			   escenario8(DbRef),
			   escenario9(DbRef)]}
     end}.

% Buscar un elemento que no está en una BD vacía
escenario0(DbRef) ->
    [?_assertEqual({error,instance}, db:read(0,DbRef))].

% Buscar un elemento que no está en una BD no vacía
escenario1(DbRef) ->
    [?_assertEqual({error,instance}, db:read(0,db:write(5,"Elemento",DbRef)))].

% Buscar un elemento que sí está en una BD no vacía
escenario2(DbRef) ->
    [?_assertEqual({ok, "Elemento"}, db:read(5,db:write(5,"Elemento",DbRef)))].

% Recuperar claves para un mismo elemento en una BD vacía
escenario3(DbRef) ->
    [?_assertEqual([], db:match("Elemento",DbRef))].

% Recuperar claves para un mismo elemento inexistente en una BD no vacía
escenario4(DbRef) ->
    [?_assertEqual([], db:match("Elemento2",db:write(5,"Elemento",DbRef)))].

% Recuperar claves para un mismo elemento único en una BD no vacía
escenario5(DbRef) ->
    [?_assertEqual([5], db:match("Elemento",db:write(5,"Elemento",DbRef)))].

% Recuperar claves para un mismo elemento repetido en una BD no vacía
escenario6(DbRef) ->
    [?_assertEqual([5, 15], lists:sort(db:match("Elemento",db:write(15,"Elemento",db:write(5,"Elemento",DbRef)))))].

% Buscar un elemento eliminado de una BD (que queda vacía)
escenario7(DbRef) ->
    [?_assertEqual({error,instance}, db:read(5,db:delete(5,db:write(5,"Elemento",DbRef))))].

% Buscar un elemento eliminado de una BD (que no queda vacía)
escenario8(DbRef) ->
    [?_assertEqual({error,instance}, db:read(5,db:write(15,"Elemento",db:delete(5,db:write(5,"Elemento",DbRef)))))].

% Buscar un elemento actualizado en una BD
escenario9(DbRef) ->
    [?_assertEqual({ok, "Elemento2"}, db:read(5,db:write(5,"Elemento2",db:write(5,"Elemento",DbRef))))].
