# Documentación de módulos Erlang: EDOC

## Instalación
Esta herramienta forma parte de las librerías OTP

## Uso

	edoc:files(['boolean.erl','manipulating.erl','adder.erl'],[{dir, 'doc'}]).



# Definición de casos de prueba (nivel de unidad): EUNIT

## Instalación
Esta herramienta forma parte de las librerías OTP

## Uso

	-include_lib("eunit/include/eunit.hrl").

	eunit:test({inparallel,manipulating_tests}).
	eunit:test(adder_tests).

## Convenciones
Los nombres de las funciones de definición de casos de prueba deben llevar el sufijo _test().

Los nombres de los ficheros que contengan únicamente pruebas suelen llevar el sufijo _tests.



# Generación automática de casos de prueba basados en propiedades: PROPER
## Instalación
Descarga del repositorio:

	git clone git@github.com:manopapad/proper.git

Compilación:

	dialyzer --build_plt --apps erts kernel stdlib [requiere varios minutos]
	make all

Arranque de la máquina virtual:

	erl -pa $DIRECTORIO_LOCAL_PROPER/ebin

## Uso

	c(boolean).
	c(boolean_props).
	proper:module(boolean_props).
	proper:module(delete_props).

## Convenciones
Los nombres de las funciones de definición de propiedades deben llevar el prefijo prop_.

Los nombres de los ficheros que contengan únicamente pruebas suelen llevar el sufijo _props.



# Análisis de cobertura (LOC): COVER

## Instalación
Esta herramienta forma parte de las librerías OTP

## Uso

	cover:start().
	cover:compile(manipulating).
	c(manipulating_tests).
	eunit:test(manipulating).
	cover:analyse_to_file(manipulating,[html]).



# Análisis de cobertura (ramas y decisión): SMOTHER
## Instalación
Descarga del repositorio:

	git clone git@github.com:ramsay-t/Smother.git

Compilación:

	make

Arranque de la máquina virtual:

	erl -pa $DIRECTORIO_LOCAL_SMOTHER/ebin

## Uso

	smother:compile("manipulating.erl").
	c(manipulating_tests).
	eunit:test(manipulating).
	smother:analyse_to_file(manipulating).



# Análisis estático de código: DIALYZER
## Inicialización

	dialyzer --build_plt --apps erts kernel stdlib


Actualización de la tabla de símbolos:

	dialyzer --add_to_plt --apps eunit

## Uso

Compilación del código con soporte de debug:

	erlc +debug_info -o ebin src/*.erl 

Análisis de los binarios:

	dialyzer *.beam

O, si se usan carpetas estándar:

	dialyzer ./ebin

Algunas opciones habituales son:

	dialyzer ./ebin -Wunmatched_returns -Werror_handling -Wrace_conditions -Wunderspecs

También se puede hacer uso de la interfaz gráfica, que se arranca desde el shell Erlang con:

	dialyzer:gui().


# Otros comentarios
En lugar de arrancar la máquina virtual de erlang con varios paths adicionales, por ejemplo,

	erl -pa $DIRECTORIO_LOCAL_PROPER/ebin -pa $DIRECTORIO_LOCAL_SMOTHER/ebin

Se puede añadir al fichero ~/.erlang:

	code:load_abs("/path/absoluto/hasta/proper").
	code:load_abs("/path/absoluto/hasta/smother").

# Otras herramientas
Erlang dispone de un debugger que se arranca desde la shell Erlang con:

	debugger:start().

También dispone de un monitor de recursos que se arranca desde la shell Erlang con:

	observer:start().
