
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
calcular' (nro, otroNum) | even nro && even otroNum = (doble nro, otroNum)
                          | odd otroNum && odd nro  = (nro , siguiente otroNum)
                          | even nro && odd otroNum = (doble nro, siguiente otroNum)
                          | otherwise = (nro, otroNum)



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








