mortal(Persona):-humano(Persona).
humano(socrates).
humano(alicia).
humano(ana).

habla(juan, espaniol).
habla(juan, ingles).
habla(juan, italiano).
habla(marcela, espaniol).
habla(hernan , aleman).
habla(ana, ingles).

seComunican(Persona,OtraPersona):- habla(Persona,Idioma),habla(OtraPersona,Idioma), Persona \= OtraPersona.


viveEn(nora,almagro).
viveEn(luis, caballito).
viveEn(ana ,lugano).
estaEn(lugano,campus).
estaEn(almagro, medrano).
viajaEnAuto(nora).
viajaEnAuto(matias).

llegaRapido(Persona,Lugar) :- viveEn(Persona, Barrio),estaEn(Barrio,Lugar).
llegaRapido(Persona, Lugar) :- viajaEnAuto(Persona),  lugar(Lugar).

lugar(Lugar):- estaEn(_, Lugar).


curso(julia,fisicaI).
curso(emilio , inglesII).
curso(elizabeth , quimica).
curso(pedro,economia).
aprobo(emilio , inglesII).
aprobo(elizabeth , quimica).
desaprobo(Persona, Materia):- curso(Persona, Materia), not(aprobo(Persona, Materia)).