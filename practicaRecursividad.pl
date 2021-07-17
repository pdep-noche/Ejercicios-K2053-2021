
progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro,Descendiente):- progenitor(Progenitor, Descendiente),
ancestro(Ancestro, Progenitor).


encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola],[Cab|Resto]):- encolar(Elem, Cola, Resto).

maximo(Lista, Max):-member(Max, Lista), 
    forall((member(Elem, Lista), Elem \= Max), Max > Elem).

maximo(Lista, Max):-member(Max, Lista), 
    forall(member(Elem, Lista), Max >= Elem).

interseccion(Lista, OtraLista, Interseccion):-
    findall(Elem, (member(Elem, Lista), member(Elem, OtraLista)), Interseccion).

esCreciente([_]).
esCreciente([Elem, OtroElem | Lista]):- Elem < OtroElem, esCreciente([OtroElem| Lista]).

sublistaMayoresA([], _, []).
sublistaMayoresA([Cab|Resto], Elem , [Cab| Lista]):- Elem < Cab, 
                   sublistaMayoresA(Resto, Elem, Lista).
sublistaMayoresA([_| Resto], Elem, NuevaLista):- 
                   sublistaMayoresA(Resto,Elem,NuevaLista).

% Ejercicio Películas
genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).
gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculaDeGenero(Persona, Genero):-persona(Persona), generoPelicula(Genero),
    forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).

persona(Persona):-gusta(Persona, _).
generoPelicula(Genero):- genero(_, Genero).

peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas):-
    persona(Persona), generoPelicula(Genero),
    findall(Pelicula, gustaPeliculaGenero(Persona, Genero, Pelicula),Peliculas).

gustaPeliculaGenero(Persona, Genero, Pelicula):- gusta(Persona, Pelicula),
    genero(Pelicula, Genero).

% Ejercicio Teg
continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)). 

% Relaciona jugador, continente y cantidad de paises.
/* Este predicado NO DEBERIA estar hecho con hechos, deberia deducirse de los anteriores. Pero para hacerlo correctamente todavía no tenemos los conceptos (mas adelante se veran), asi que por ahora los dejamos asi */
cuantosPaisesOcupaEn(amarillo, americaDelSur, 1).
cuantosPaisesOcupaEn(amarillo, americaDelNorte, 4).
cuantosPaisesOcupaEn(amarillo, asia, 3).
cuantosPaisesOcupaEn(amarillo, oceania, 0).
cuantosPaisesOcupaEn(magenta, americaDelSur, 2).
cuantosPaisesOcupaEn(magenta, americaDelNorte, 0).
cuantosPaisesOcupaEn(magenta, asia, 0).
cuantosPaisesOcupaEn(magenta, oceania, 0).
cuantosPaisesOcupaEn(negro, americaDelSur, 1).
cuantosPaisesOcupaEn(negro, americaDelNorte, 0).
cuantosPaisesOcupaEn(negro, asia, 1).
cuantosPaisesOcupaEn(negro, oceania, 4).

% 1
loLiquidaron(Jugador):-jugador(Jugador),
    not(ocupa(_, Jugador, _)).

%2
ocupaContinente(Jugador, Continente):- jugador(Jugador),
    continente(Continente),
    forall(estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).

ocupaContinenteConNot(Jugador, Continente):- jugador(Jugador),
     continente(Continente),
     not((estaEn(Continente, Pais), not(ocupa(Pais, Jugador, _)))).
%3
seAtrinchero(Jugador):- ocupa(_, Jugador, _), continente(Continente),
    forall(ocupa(Pais, Jugador, _), estaEn(Continente, Pais)).

seAtrincheroNot(Jugador):- ocupa(_, Jugador, _), continente(Continente),
    not((ocupa(Pais, Jugador, _), not(estaEn(Continente, Pais)))).

%4
elQueTieneMasEjercitos(Jugador, Pais):- ocupa(Pais, Jugador, CantEjercitos),
forall(ocupa(_, _, Ejercitos), CantEjercitos >= Ejercitos).

%5
puedeConquistar(Jugador, Continente):- jugador(Jugador), continente(Continente), 
        not(ocupaContinente(Jugador, Continente)),
        forall((estaEn(Continente, Pais), not(ocupa(Pais, Jugador, _))), 
               limitrofeNoAliado(Pais, Jugador)).

limitrofeNoAliado(Pais, Jugador):- limitrofes(Pais, OtroPais), ocupa(OtroPais, Jugador, _),
ocupa(Pais, OtroJugador, _), not(aliados(Jugador, OtroJugador)).

% Parte 2  
% 2
cumpleObjetivos(Jugador):- jugador(Jugador), 
forall(objetivo(Jugador, Objetivo), puedeCumplir(Jugador, Objetivo)).

puedeCumplir(Jugador, ocuparContinente(Continente)):-ocupaContinente(Jugador, Continente).
puedeCumplir(Jugador, ocuparPaises(CantidadObjetivo, Continente)):- cuantosPaisesOcupaEn(Jugador, Continente, CantidadQueOcupa), 
    CantidadQueOcupa >= CantidadObjetivo.
puedeCumplir(_, destruirJugador(Jugador)):- loLiquidaron(Jugador).


leInteresa(Jugador, Continente):- objetivo(Jugador, Objetivo), 
    interesaContinente(Continente, Objetivo).

interesaContinente(Continente, ocupaContinente(Continente)).
interesaContinente(Continente, ocuparPaises(_, Continente)).
interesaContinente(Continente, destruirJugador(JugadorADestruir)):-
    cuantosPaisesOcupaEn(JugadorADestruir, Continente, Cantidad), 
    Cantidad > 0.

