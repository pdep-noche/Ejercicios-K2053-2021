viveEn(remy, gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).

sabeCocinar(linguini, ratatouille, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

estaEnElMenu(Comida, Restaurante):-trabajaEn(Persona, Restaurante), 
        sabeCocinar(Persona, Comida, _).

%2
cocinaBien(Persona ,Plato):-sabeCocinar(Persona, Plato, Experiencia), 
    Experiencia > 7.
cocinaBien(Persona, Plato):-sabeCocinar(Persona, Plato,_), 
    tieneTutor(Persona, Tutor), 
    cocinaBien(Tutor,Plato).
cocinaBien(remy, Plato):-sabeCocinar(_, Plato, _).

tieneTutor(linguini, Rata):- viveEn(Rata, Lugar), 
    trabajaEn(linguini, Lugar).
tieneTutor(skinner, amelie).

%3
esChef(Cocinero, Restaurante):- trabajaEn(Cocinero, Restaurante), 
        cumpleCondicionesChef(Cocinero, Restaurante).

cumpleCondicionesChef(Cocinero, Restaurante):-
    forall(estaEnElMenu(Plato, Restaurante), cocinaBien(Cocinero, Plato)).
cumpleCondicionesChef(Cocinero, _):- 
    totalExperiencia(Cocinero, Total), Total > 20.

totalExperiencia(Cocinero, Total):-
    findall(Experiencia,sabeCocinar(Cocinero, _, Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).

%4
encargada(Persona, Plato, Restaurante):- experienciaCocinero(Persona, Plato,  Restaurante, Experiencia),
    forall(experienciaCocinero(_, Plato, Restaurante, OtraExperiencia), Experiencia >= OtraExperiencia).

experienciaCocinero(Persona, Plato, Restaurante, Experiencia):-
    trabajaEn(Persona, Restaurante),
    sabeCocinar(Persona, Plato, Experiencia).
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).
plato(ensaladaDeFrutas, postre(50)).

%5
esSaludable(Comida):-plato(Comida, TipoComida), 
    calorias(TipoComida, Calorias), Calorias < 75.

calorias(entrada(ListaIngredientes), Calorias):-
    length(ListaIngredientes, CantidadCalorias),
    Calorias is CantidadCalorias * 15.
calorias(principal(Guarnicion, Minutos), Calorias):-
    caloriasGuarnicion(Guarnicion, CaleriasGuarnicion), 
    Calorias is (Minutos * 5) + CaleriasGuarnicion.
calorias(postre(Calorias), Calorias).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

%6
reseniaPositiva(Critico, Restaurante):-restaurante(Restaurante),
    not(viveEn(_, Restaurante)),
    criterioCritico(Criterio, Restaurante).

restaurante(Restaurante):- trabajaEn(_, Restaurante).

criterioCritico(antonEgo, Restaurante):- esEspecialista(Restaurante, ratatouille).
criterioCritico(cormillot, Restaurante):- forall(experienciaCocinero(_, Plato, Restaurante, _), esSaludable(Plato)).
criterioCritico(martiniano,Restaurante):- esChef(Cocinero, Restaurante), 
    not((esChef(OtroCocinero, Restaurante), Cocinero \= OtroCocinero)).

esEspecialista(Restaurante, Comida):- 
    forall(esChef(Cocinero, Restaurante),cocinaBien(Cocinero,Comida)).



    












