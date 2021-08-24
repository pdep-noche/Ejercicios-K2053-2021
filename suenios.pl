%creeEn(Persona, Personaje)
creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

%suenio(Persona, Suenio).
suenio(gabriel, ganarLoteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

%2
esAmbiciosa(Persona):-persona(Persona), sumaTotalDificultades(Persona, Total), 
        Total > 20.

persona(Persona):- creeEn(Persona, _).
sumaTotalDificultades(Persona, Total):- 
    findall(Dificultad, dificultad(Persona, Dificultad), ListaDificultades),
    sumlist(ListaDificultades, Total).

dificultad(Persona, NivelDificultad):- suenio(Persona, Suenio), 
                nivelDificultad(Suenio, NivelDificultad).

nivelDificultad(cantante(CantDiscos), 6):- CantDiscos > 500000.
nivelDificultad(cantante(CantDiscos), 4):- CantDiscos =< 500000.
nivelDificultad(ganarLoteria(Numeros), Dificultad):- length(Numeros, CantNumeros), 
                Dificultad is CantNumeros * 10.
nivelDificultad(futbolista(EquipoChico), 3):- equipoChico(EquipoChico).
nivelDificultad(futbolista(Equipo), 16):- not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%3
tieneQuimica(Personaje, Persona):-creeEn(Persona, Personaje), 
                        cumpleCondiciones(Personaje, Persona).

cumpleCondiciones(campanita, Persona):-dificultad(Persona, NivelDificultad), 
    NivelDificultad < 5.
cumpleCondiciones(Personaje, Persona):- Personaje \= campanita, 
    todosLosSueniosPuros(Persona), 
    not(esAmbiciosa(Persona)).

todosLosSueniosPuros(Persona):- forall(suenio(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(CantDiscos)):- CantDiscos < 200000.

alegraA(Personaje, Persona):-suenio(Persona, _),
            tieneQuimica(Personaje, Persona), 
            puedeAlegrar(Personaje).

puedeAlegrar(Personaje):- not(estaEnfermo(Personaje)).
puedeAlegrar(Personaje):-backup(Personaje, PersonajeBackup),     
                    puedeAlegrar(PersonajeBackup).

backup(Personaje, OtroPersonaje):- amigo(Personaje, OtroPersonaje).
backup(Personaje, OtroPersonaje):- amigo(Personaje, OtroAmigo), 
                backup(OtroAmigo, OtroPersonaje).
            
personaje(Personaje):- creeEn(_,Personaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenaghi).
