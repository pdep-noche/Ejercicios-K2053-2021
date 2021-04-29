import Text.Show.Functions

siguiente :: Integer -> Integer
siguiente nro = nro + 1

calcular :: Integer -> Integer
calcular nro | even nro = siguiente nro
              | otherwise = doble nro


doble nro = 2 * nro

aproboAlumno :: Integer -> Bool
aproboAlumno nota = nota >= 6

mes :: (Integer, Integer, Integer)-> Integer
mes (_, unMes, _) = unMes


calcular' :: (Integer, Integer) -> (Integer, Integer)
calcular' (primero, segundo) = (calcularPrimero primero, calcularSegundo segundo)

calcularPrimero primero | even primero = doble primero
                        | otherwise = primero

calcularSegundo segundo | odd segundo = siguiente segundo
                        | otherwise = segundo

and' :: Bool -> Bool ->Bool
and' unBool otroBool | not unBool = False
                     | otherwise = otroBool

and'' :: Bool -> Bool -> Bool
and'' True otroBool = otroBool
and'' _   _ = False

or' :: Bool -> Bool -> Bool
or' False False = False
or'  _ _ = True

or'' :: Bool -> Bool -> Bool
or'' True _ = True
or'' _ unBool = unBool

type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)

notaMaxima :: Alumno -> Nota
notaMaxima (_, nota1, nota2, nota3) = nota1 `max` (nota2 `max` nota3)

cuadruple :: Integer -> Integer
cuadruple nro = doble (doble nro)

cuadruple' :: Integer -> Integer
cuadruple' nro = (doble . doble) nro

esMayorA :: Integer -> Bool
esMayorA nro =  10 < (doble.siguiente)(nro + 2)

suma :: Integer -> Integer -> Integer
suma x y = x + y

suma' :: (Integer, Integer) -> Integer
suma' (x, y)  = x + y


esParSiguiente :: Integer -> Bool
esParSiguiente nro = even . siguiente $  nro

esImparSigSumaSiete :: Integer -> Bool
esImparSigSumaSiete nro = odd.siguiente.suma 7 $ nro

esMayorA' :: Integer -> Bool
esMayorA' nro = ((>10).doble.siguiente.suma 2) nro

triple :: Integer -> Integer
triple  = (\nro -> 3 * nro)

siguiente' :: Integer -> Integer
siguiente' = (\nro -> nro + 1)

suma'' :: Integer -> Integer -> Integer
suma'' = (\nro otroNum -> nro + otroNum)

sumarDos :: Integer -> Integer
sumarDos = (\nro -> nro `suma` 2)


cabeza (x:_) = x

cola (_:xs) = xs

resto (_:_:_:xs)  = xs

sayHello :: String -> String
sayHello alguien = "Hello " ++ alguien ++ "!"

primero :: (Integer, Integer, Integer) -> Integer
primero (x, _, _ ) = x