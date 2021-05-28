p :: ( a -> Bool )  -> [a]  -> a
p n = (head . filter n) 

f :: (Ord t) => (a -> t)  -> [(a,a)] -> Bool
f x y = (x.fst.head) y > (x.snd.head) y

g :: (Eq a) =>   ( t -> a) ->  t  ->   t  -> Bool
g f a b = f a == f b

p1 ::  ( c ->  Bool) -> ( b -> c )  ->  Int  -> [b] -> Bool
p1 x y z = ((> z) . length . filter x . map y)

h ::(Eq a) =>  a ->  [( t , a , x ) ]  -> (t, a, x)
h nom  = head.filter ((nom==).g1)
g1 (_, c, _) = c


f2 ::  (Ord t, Num t, Num a )  =>    a -> ( a -> t)  ->  [ a ]  -> a
f2 x _ [] = x
f2 x y (z:zs) | y z > 0 = z + f2 x y zs
              | otherwise = f2 x y zs

qfsort :: (Ord t) =>  ( a ->  t) -> [ a ] -> [a] 
qfsort f [ ] = [ ]
qfsort f (x:xs) = (qfsort f (filter ((> f x).f) xs)) ++ [x] ++ (qfsort f (filter ((< f x).f) xs))

data Animal= Raton {nombre :: String, edad :: Float, peso :: Float, enfermedades :: [String]} deriving Show
type Enfermedad = String
type Hierba = Animal -> Animal
-- Ejemplo de raton

cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]
orejudo = Raton "Orejudo" 4.0 10.0 ["obesidad", "sinusitis"]
-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]

modificarEdad f unRaton = unRaton {edad = (f.edad) unRaton}

modificarNombre f unRaton = unRaton { nombre = (f.nombre) unRaton}

modificarPeso f unRaton = unRaton { peso = f. peso $ unRaton}

modificarEnfermedades f unRaton = unRaton { enfermedades = f . enfermedades $ unRaton}
-- Punto 2
-- a
hierbaBuena :: Hierba
hierbaBuena unRaton = modificarEdad sqrt unRaton

--b
hierbaVerde :: Enfermedad -> Hierba
hierbaVerde unaEnfermedad unRaton = modificarEnfermedades (filter (/= unaEnfermedad)) unRaton

--c
alcachofa :: Hierba
alcachofa unRaton = modificarPeso perderPeso unRaton

perderPeso :: Float -> Float
perderPeso peso | peso > 2 = peso * 0.9
                | otherwise = peso * 0.95

hierbaMagica :: Hierba
hierbaMagica unRaton = modificarEdad (*0).modificarEnfermedades ((\_ -> [])) $ unRaton
-- Punto 3
medicamento :: [Hierba] -> Animal -> Animal
medicamento hierbas unRaton = foldl (flip ($))  unRaton hierbas

{-*Main> medicamento [alcachofa, hierbaMagica] cerebro
Raton {nombre = "Cerebro", edad = 0.0, peso = 0.19, enfermedades = [] 
 -}
-- b
antiAge :: Hierba
antiAge unRaton = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) unRaton

-- c
reduceFatFast :: Int -> Hierba
reduceFatFast potencia unRaton = medicamento ([hierbaVerde "obesidad"] ++ (replicate potencia alcachofa)) unRaton

{-*Main> reduceFatFast 1 orejudo
Raton {nombre = "Orejudo", edad = 4.0, peso = 9.0, enfermedades = ["sinusitis"]} -}

hierbaMilagrosa :: Hierba
hierbaMilagrosa unRaton =  foldr  hierbaVerde  unRaton  enfermedadesInfecciosas

hierbaMilagrosa' :: Hierba
hierbaMilagrosa' unRaton = medicamento (map hierbaVerde enfermedadesInfecciosas) unRaton

-- 4
cantidadIdeal f = head.filter f $ [1..]

estanMejoresQueNunca :: [Animal] -> Hierba -> Bool
estanMejoresQueNunca ratones unMedicamento = all ((<1).peso.unMedicamento) ratones

{-
estanMejoresQueNunca [cerebro, orejudo] hierbaMilagrosa
False-}

experimento ratones = cantidadIdeal  (estanMejoresQueNunca ratones.reduceFatFast)

{-*Main> experimento [cerebro, orejudo]
29 -}