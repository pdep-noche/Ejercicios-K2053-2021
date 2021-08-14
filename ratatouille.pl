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






