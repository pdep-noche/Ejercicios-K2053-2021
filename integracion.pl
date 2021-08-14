transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

tardaMucho(Persona):-transporte(Persona, camina).
tardaMucho(Persona):-transporte(Persona, auto(_,_,_)), 
        manejaLento(Persona).

viajaEnColectivo(Persona):-transporte(Persona, colectivo(_,_)).
viajaEnColectivo(Persona):-transporte(Persona, colectivo(_)).


%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).

puedeIr(Persona, Lugar, Alojamiento):-lugar(Lugar, Alojamiento),
cumpleCondiciones(Alojamiento, MontoDiario), 
puedeGastar(Persona, CantDias, Disponible),
Disponible >= MontoDiario * CantDias.

cumpleCondiciones(hotel(_, Estrellas, MontoDiario), MontoDiario):- 
                        Estrellas > 3.
cumpleCondiciones(casa(garaje, MontoDiario), MontoDiario).
cumpleCondiciones(quinta(_, pileta, MontoDiario), MontoDiario).
cumpleCondiciones(carpa(MontoDiario), MontoDiario).

% 2
puedeIrACualquierLugar(Persona):- persona(Persona), 
forall(lugar(Lugar, _), puedeIr(Persona, Lugar,_)).

persona(Persona):-puedeGastar(Persona, _, _).

%2
puedeAlojarseEnCualquierAlojamiento(Persona):-persona(Persona),
forall(lugar(_, Alojamiento), puedeIr(Persona, _, Alojamiento)).

entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 300).
costo(teatro, 500).
costo(pool, 250).
costo(parqueTematico, 800).


entretenimientos(Disponible, Sublista):- conjuntoEntretenimientos(ConjEntretenimientos),
sublista(ConjEntretenimientos, Disponible, Sublista).

conjuntoEntretenimientos(Lista):-findall(Entre, entretenimiento(Entre), Lista).

sublista([], _, []).
sublista([Entre|Cola], TotalDinero, [Entre| Resto]):-
    costo(Entre,Monto), Monto =< TotalDinero, 
    DineroRestante is TotalDinero - Monto, 
    sublista(Cola, DineroRestante, Resto).
sublista([_|Cola], Disponible, Lista):- 
    sublista(Cola, Disponible, Lista).

% Afirmativo
tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).

%1
agente(Agente):- tarea(Agente, _, _).
frecuenta(Agente, Ubicacion):- tarea(Agente, _, Ubicacion).
frecuenta(Agente, buenosAires):- agente(Agente).
frecuenta(vega, quilmes).
frecuenta(Agente, marDelPlata):-tarea(Agente, vigilar(Negocios), _), 
    member(alfajores, Negocios).
%2
inaccesible(Lugar):- ubicacion(Lugar), 
    not(frecuenta(_, Lugar)).


%3
afincado(Agente):-tarea(Agente, _, Ubicacion),
forall(tarea(Agente, _, OtraUbicacion), igual(Ubicacion, OtraUbicacion)).

igual(Lugar, Lugar).

%4
cadenaDeMando([_]).
cadenaDeMando([Jefe, Subor| Resto]):- jefe(Jefe, Subor), 
    cadenaDeMando([Subor|Resto]).

%5
agentePremiado(Agente):- puntaje(Agente, Puntos), 
    forall(puntaje(_, OtroPuntaje), Puntos >= OtroPuntaje).

puntaje(Agente, PuntajeTotal):- agente(Agente), 
    findall(Puntaje, puntajeTarea(Agente, Puntaje), ListaPuntajes),
    sumlist(ListaPuntajes,PuntajeTotal).

puntajeTarea(Agente, PuntajeTarea):- tarea(Agente, Tarea, _),
    cantPuntosPorTarea(Tarea, PuntajeTarea).


cantPuntosPorTarea(vigilar(Negocios), PuntosTotal):- 
    length(Negocios, Cantidad), 
    cantPuntosPorTarea(vigilar(Negocios), PuntosTotal):- 
    PuntosTotal is Cantidad * 5.
cantPuntosPorTarea(ingerir(_ ,Tamanio, Cantidad), PuntosTotal):-
    Unidades is Tamanio * Cantidad,  PuntosTotal is Unidades*(-10).
cantPuntosPorTarea(apresar(_, Recompensa), PuntosTotal):-
    PuntosTotal is Recompensa/2.
cantPuntosPorTarea(asuntosInternos(AgenteInvestigado), PuntosTotal):-
    puntaje(AgenteInvestigado, Puntos),
    PuntosTotal is Puntos *2.













