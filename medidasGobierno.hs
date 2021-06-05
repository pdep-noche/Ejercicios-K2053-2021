type Bien = (String,Float)        
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float,
cantidadDeHijos :: Float, bienes :: [Bien] } deriving Show

homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]

type Ciudad = [Ciudadano]
springfield :: Ciudad
springfield = [homero, burns, frink, krabappel]

diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio ciudad = maximoPatrimonio ciudad - minimoPatrimonio ciudad

maximoPatrimonio :: Ciudad -> Float
maximoPatrimonio ciudad = patrimonio.ciudadanoSegun maximo $ ciudad

minimoPatrimonio :: Ciudad -> Float
minimoPatrimonio ciudad = patrimonio.ciudadanoSegun minimo $ ciudad

ciudadanoSegun :: (Ciudadano -> Ciudadano -> Ciudadano) -> Ciudad -> Ciudadano
ciudadanoSegun f ciudad = foldl1 f ciudad

maximo :: Ciudadano -> Ciudadano -> Ciudadano
maximo unCiudadano otroCiudadano | patrimonio unCiudadano >= patrimonio otroCiudadano = unCiudadano
                                 | otherwise = otroCiudadano

minimo :: Ciudadano -> Ciudadano -> Ciudadano
minimo unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                 | otherwise = otroCiudadano

patrimonio :: Ciudadano -> Float
patrimonio unCiudadano = foldl (\sem bien -> sem + snd bien) (sueldo unCiudadano) (bienes unCiudadano)

-----2
tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama unCiudadano = any altaGama . bienes $ unCiudadano

altaGama :: Bien -> Bool
altaGama ("auto", monto) = monto > 100000
altaGama _ = False

-- 3
type Medida = Ciudadano -> Ciudadano
auh :: Medida
auh unCiudadano = aplicarMedida (patrimonio unCiudadano < 0) unCiudadano (modificarSueldo unCiudadano ((1000*).cantidadDeHijos $ unCiudadano))

aplicarMedida :: Bool -> Ciudadano -> Ciudadano -> Ciudadano
aplicarMedida cond unCiudadano ciudadanoModif | cond = ciudadanoModif
                                              | otherwise = unCiudadano

modificarSueldo unCiudadano cantidad = unCiudadano {sueldo = sueldo unCiudadano + cantidad}

-- b
impuestoGanancias :: Float -> Medida
impuestoGanancias minimo unCiudadano = aplicarMedida (sueldo unCiudadano > minimo) unCiudadano (modificarSueldo unCiudadano (diferencia minimo (sueldo unCiudadano)))

diferencia minimo sueldo = (minimo - sueldo) * 0.3

-- c
impuestoAltaGama :: Medida
impuestoAltaGama unCiudadano = aplicarMedida (tieneAutoAltaGama unCiudadano) unCiudadano (modificarSueldo unCiudadano (montoADisminuir (bienes unCiudadano)) )

montoADisminuir bienes = ((-0.1)*).snd.head.filter altaGama $ bienes

--d
negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion profesion porcentaje unCiudadano = aplicarMedida (esDeProfesion profesion unCiudadano) unCiudadano (modificarSueldo unCiudadano (cantidadDeAumento porcentaje (sueldo unCiudadano)))

cantidadDeAumento porcentaje sueldo = (sueldo * porcentaje) /100

esDeProfesion unaProfesion unCiudadano =(unaProfesion ==).profesion $ unCiudadano

-- 4
data Gobierno = UnGobierno { anios :: [Int], medidas :: [ Medida ]}

gobiernoA :: Gobierno
gobiernoA = UnGobierno [1999..2003] [impuestoGanancias 30000, negociarSueldoProfesion "Profesor" 10, negociarSueldoProfesion "Empresario" 40, impuestoAltaGama, auh]

gobiernoB :: Gobierno
gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40000, negociarSueldoProfesion "Profesor" 30, negociarSueldoProfesion "Camionero" 40]

gobernarUnAño :: Gobierno -> Ciudad -> Ciudad
gobernarUnAño unGobierno unaCiudad = map  (aplicarMedidas (medidas unGobierno))  unaCiudad

aplicarMedidas :: [Medida] -> Ciudadano -> Ciudadano
aplicarMedidas medidas unCiudadano = foldl  (flip ($))  unCiudadano medidas 

{-*Main> gobernarUnAño gobiernoA springfield
[UnCiudadano {profesion = "SeguridadNuclear", sueldo = 12000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion = "Empresario", sueldo = 286600.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 13200.0, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 13200.0, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}

gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto unGobierno unaCiudad = foldl  (flip ($))  unaCiudad (replicate (length.anios $ unGobierno) (gobernarUnAño unGobierno))

gobernarPeriodoCompleto' :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto' unGobierno unaCiudad = foldl (\ciudad f -> f unGobierno ciudad) unaCiudad (replicate (length.anios $ unGobierno) gobernarUnAño)

{-*Main> gobernarPeriodoCompleto  gobiernoA springfield
[UnCiudadano {profesion = "SeguridadNuclear", sueldo = 21000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion = "Empresario", sueldo = 235626.9, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 19326.12, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo
= 19326.12, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}

--e
distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza unGobierno unaCiudad = diferenciaDePatrimonio unaCiudad > (diferenciaDePatrimonio.gobernarPeriodoCompleto unGobierno) unaCiudad

{-*Main> distribuyoRiqueza gobiernoB springfield
True
-}

kane :: Ciudadano
kane = UnCiudadano "Empresario" 100000 0 [("Rosebud",cantidad) | cantidad <- [5,10..]]

f1 :: (Num a) =>  a -> ( t -> a -> Bool)->  t  -> [a] ->[a]
f1 x y z = map (*x) . filter (y z) 