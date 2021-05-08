length' [] = 0
length' (_:xs) = 1 + length' xs


map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] =[]
filter' f (x:xs) | f x = x : filter' f xs
                 | otherwise = filter' f xs

type Nombre = String
type Notas = [Int]  
data Persona = Alumno {nombre :: Nombre, notas :: Notas}

promediosAlumnos :: [Persona] -> [(Nombre, Int)]
promediosAlumnos alumnos = map (\unAlumno -> (nombre unAlumno, promedio . notas $ unAlumno )) alumnos

promedio :: Notas -> Int
promedio notas = sum notas `div` length notas

alumnos = [(Alumno "juan" [8,6]), (Alumno "maria" [7,9,4]), (Alumno "ana" [6,2,4])]

promediosSinAplazos :: [Notas] -> Notas
promediosSinAplazos listaNotas = map (promedio.filter (>=6)) listaNotas


aprobo :: Persona -> Bool
aprobo alumno = all (>=6).notas $ alumno


aprobaron :: [Persona] -> [Nombre]
aprobaron alumnos =  map nombre . filter aprobo $ alumnos

productos :: [String] -> [Integer] -> [(String, Integer)]
productos nombres precios = zip nombres precios

productos' :: [String] -> [Integer] -> [(String, Integer)]
productos' nombres precios = zipWith (\nom prec -> (nom, prec))  nombres precios

data Flor= Flor{nombreFlor :: String, aplicacion:: String, cantidadDeDemanda:: Int } deriving Show

rosa = Flor "rosa" "decorativo" 120
jazmin =  Flor "jazmin" "aromatizante" 100
violeta=  Flor "violeta" "infusión" 110
orquidea =  Flor "orquidea" "decorativo" 90
flores = [orquidea, rosa,violeta, jazmin]

maximoSegun :: [Flor] -> (Flor -> Int) -> String
maximoSegun flores criterio = nombreFlor . maximaFlorSegun criterio $ flores

maximaFlorSegun :: (Flor -> Int) -> [Flor] -> Flor
maximaFlorSegun _ [flor] = flor
maximaFlorSegun criterio (flor:flores) | criterio flor >= criterio (maximaFlorSegun criterio flores)  = flor
                                       | otherwise = maximaFlorSegun criterio flores

{-*Main> maximoSegun flores cantidadDeDemanda
"rosa" -}

{-*Main> maximoSegun flores (length.nombreFlor)
"orquidea" -}

{-*Main> maximoSegun flores ((`mod` 4). cantidadDeDemanda)
"orquidea" -}

estanOrdenadas :: [Flor] -> Bool
estanOrdenadas [_] = True
estanOrdenadas (flor:otraFlor:flores) = cantidadDeDemanda flor > cantidadDeDemanda otraFlor && estanOrdenadas (otraFlor:flores)

{-*Main> estanOrdenadas flores
False
*Main> estanOrdenadas [rosa, violeta, jazmin, orquidea]
True -}


f1 :: [String] -> [(String, (Int, Int))]
f1 comidas = map (\comida -> (comida, (cantConsonantes comida, cantVocales comida))). filter (\comida -> cantConsonantes comida > cantVocales comida ) $ comidas

cantVocales comida = cantidad esVocal comida
    
cantidad f comida =  length. filter f $ comida

esVocal :: Char -> Bool
esVocal letra = elem letra vocales  
vocales = "aeiou"++"AEIOU"

cantConsonantes comida = cantidad esConsonante comida
esConsonante :: Char -> Bool
esConsonante letra  = any (letra == ) consonantes  

consonantes = [letra | letra <- ['a'..'z']++['A'..'Z'], (not.esVocal) letra]