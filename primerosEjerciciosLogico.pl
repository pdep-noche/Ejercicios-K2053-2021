contador(roque).
joven(roque).
honesto(roque).
ingeniero(ana).
ingeniero(julia).
trabajoEn(roque,acme).
trabajoEn(julia,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(santiago,omni).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
habla(roque,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(Persona):- contador(Persona), joven(Persona).
ambicioso(santiago).
tieneExperiencia(Persona):-trabajoEn(Persona, _).
profesional(Persona):-contador(Persona).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).
puedeAndar(Persona, comercioExterior):-ambicioso(Persona).
puedeAndar(Persona, contaduria):- contador(Persona), honesto(Persona).
puedeAndar(Persona, ventas):- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(lucia, ventas).
puedeAndar(Persona, proyectos):- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(Persona, proyectos):- abogado(Persona), joven(Persona).
puedeAndar(Persona, logistica):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):-joven(Persona).
cumpleCondiciones(Persona):-trabajoEn(Persona, omni).

madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(Hermano, OtroHermano):- mismaMadre(Hermano, OtroHermano), mismoPadre(Hermano,OtroHermano).
mismaMadre(Hermano, OtroHermano):-madre(Madre, Hermano), madre(Madre, OtroHermano), Hermano \= OtroHermano.
mismoPadre(Hermano, OtroHermano):- padre(Padre, Hermano), padre(Padre, OtroHermano), Hermano \= OtroHermano.

medioHermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona), not(mismoPadre(Persona, OtraPersona)).
medioHermano(Persona, OtraPersona):- mismoPadre(Persona, OtraPersona), not(mismaMadre(Persona, OtraPersona)).

hijoUnico(Persona):-hijo(Persona,_),not(hermano(Persona, _)).

hijo(Persona, Progenitor):-madre(Progenitor, Persona).
hijo(Persona, Progenitor):-padre(Progenitor, Persona).

tio(Tio, Sobrino):- hijo(Sobrino, Progenitor), medioHermano(Progenitor,Tio).
tio(Tio, Sobrino):- hijo(Sobrino, Progenitor), hermano(Progenitor,Tio).

