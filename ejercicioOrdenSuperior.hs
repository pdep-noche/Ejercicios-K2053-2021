
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

type Nombre = String
f2 :: [Persona] -> [(Nombre, Int)]
f2 personas = map (\persona -> (nombre persona, edad persona)). filter (\persona -> esMenor persona) $ personas

type Fecha = (Int, Int, Int)
data Persona = Persona {nombre:: Nombre, lugarNacimiento :: String, fechaNacimiento :: Fecha} deriving Show

edad :: Persona -> Int
edad persona = 2020 - añoNacimiento persona

añoNacimiento (Persona _ _ (_, _, año)) = año

esMenor :: Persona -> Bool
esMenor persona = edad persona < 18


f3 lista g h = map g . filter h $ lista

{-
f3 ["lechuga", "anana", "alfajor de chocolate"] (\comida -> (comida, (cantConsonantes comida, cantVocales comida))) (\comida -> cantConsonantes comida > cantVocales comida)
[("lechuga",(4,3)),("alfajor de chocolate",(10,8))] -}

{-
f3 [Persona "Luis" "Cordoba" (20,2,2005), Persona "Pedro" "Rosario" (5,5,1940), Persona "Marta" "Mendoza" (12,10,2003)] (\persona -> (nombre persona, edad persona)) (\persona -> esMenor persona)
[("Luis",15),("Marta",17)]
-}
