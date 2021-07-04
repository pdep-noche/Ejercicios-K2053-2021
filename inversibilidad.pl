mayor(Mayor, Menor):-numero(Mayor), numero(Menor), Mayor >Menor.

numero(Numero):-between(1,10,Numero).

programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).
programaEn(caro, javascript).
programaEn(Persona, c):-persona(Persona).

persona(nahuel).
persona(juan).
persona(caro).

irremplazable(Persona):-programaEn(Persona, Lenguaje),not((programaEn(Alguien, Lenguaje), Alguien \= Persona)).

quiere(juan, playa).
quiere(juan , wifi).
quiere(juan , teatro).
quiere(ana, sierra).
quiere(ana, playa).

lugar(mardel ,playa).
lugar(mardel , wifi).
lugar(mardel , teatro).
lugar(mardel ,casino).
lugar(tandil , sierra).
lugar(tandil , teatro).
lugarVeraneo(Lugar):-lugar(Lugar, _).
quiereVeranear(Persona):- quiere(Persona, _).

tieneTodoParaVeranear(Lugar, Persona):-lugarVeraneo(Lugar), quiereVeranear(Persona),forall(quiere(Persona, Algo),lugar(Lugar, Algo)).

practica(ana, natacion([pecho, espalda, mariposa], 1200, 10)).
practica(juan, natacion([mariposa], 900, 0)).
practica(julia, futbol(2, 15, 5)).
practica(fede, futbol(1, 10 , 3)).
practica(ana, gimnasiaArtistica([vueltaPajarito, flicFlac],3)).
practica(laura, gimnasiaArtistica([saltoDeCaballo],2)).

buenDeportista(Alguien):- practica(Alguien, Deporte), esBueno(Deporte).
esBueno(natacion(Estilos, _, _)):-
 length(Estilos, CantidadEstilos), CantidadEstilos > 2.
esBueno(natacion(_, Kms, _)):-Kms > 1000.
esBueno(futbol(_, Goles, Expulsiones)):-
  Valor is Goles - Expulsiones, Valor > 5.
esBueno(gimnasiaArtistica(Habilidades, CantMedallas)):- 
 member(vueltaPajarito, Habilidades), CantMedallas > 1.

materia(algoritmos, 1).
materia(analisisI, 1).
materia(pdp, 2).
materia(proba, 2).
materia(sintaxis, 2).
nota(alicia, pdp, 10).
nota(alicia, proba, 7).
nota(alicia, sintaxis, 8).
nota(malena, pdp, 6).
nota(malena, proba, 2).
nota(raul, pdp, 9).
aprobo(Alumno, Materia):-
  nota(Alumno, Materia, Nota), 
  Nota >= 6. 

terminoAnio(Alumno, Anio):- alumno(Alumno), anio(Anio),
	forall(materia(Materia, Anio), aprobo(Alumno, Materia)).

alumno(Alumno):-nota(Alumno, _, _).
anio(Anio):- materia(_, Anio).


