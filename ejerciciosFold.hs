sumatoria lista = foldl1 (+) lista

productoria lista = foldl1 (*) lista

maximo lista = foldl1 max lista

cantidadDeElementos lista = foldl (\sem _ -> sem + 1)  0  lista

cantidadDeElementos' lista = foldr (\_ sem -> sem + 1) 0 lista

masGastador (emple:empleados) =   foldl maximoEmple  emple empleados  

maximoEmple emple otroEmple | snd emple > snd otroEmple = emple
                             | otherwise = otroEmple

masGastador' empleados = foldl1 maximoEmple empleados

masGastador'' (emple:empleados) =   foldr maximoEmple  emple empleados  

monto lista = foldl (\sem (_, gasto) -> sem + gasto)  0 lista

monto' lista = foldr (\(_, gasto) sem -> sem + gasto) 0 lista

{--foldl (\sem f -> f sem )  2 [(3+), (*2), (5+)] 
--}

{-- 
foldl ( flip ($)) 2 [(3+), (*2), (5+)]
--}


{--foldr ($)  2 [(3+), (*2), (5+)]
--}

{-- foldr (\f sem -> f sem)  2 [(3+), (*2), (5+)] --}

-- Punto 5
type Nombre  = String
type InversionInicial = Int
type Profesionales = [String]

data  Proyecto = Proy {nombre:: Nombre, inversionInicial::  InversionInicial, profesionales:: Profesionales} deriving Show

proyectos :: [Proyecto]
proyectos = [Proy "red social de arte"  20000 ["ing. en sistemas", "contador"], Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"], Proy "ventaChurros" 1000 ["cocinero"] ]


maximoSegun :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maximoSegun (proyecto:proyectos) criterio = foldl (maximoProyecto criterio)  proyecto  proyectos

maximoProyecto :: (Proyecto -> Int) -> Proyecto -> Proyecto -> Proyecto
maximoProyecto criterio proyecto otroProyecto | criterio proyecto > criterio otroProyecto = proyecto
                                               | otherwise = otroProyecto
--a
{-- *Main> maximoSegun proyectos inversionInicial
Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]} -}

--b
{- *Main> maximoSegun proyectos (length.profesionales)
Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]} -}

-- c
{-*Main> maximoSegun proyectos (length.words.nombre)
Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]} -}

maximoSegun' :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maximoSegun' proyectos criterio = foldl1 (maximoProyecto criterio) proyectos

maximoSegun'' :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maximoSegun'' [proyecto] _ = proyecto
maximoSegun'' (unProyecto:proyectos) criterio | criterio unProyecto > criterio (maximoSegun'' proyectos criterio)  = unProyecto
                                               | otherwise = maximoSegun'' proyectos criterio
