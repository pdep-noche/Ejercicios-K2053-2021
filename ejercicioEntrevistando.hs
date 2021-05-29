data Postulante = UnPostulante {nombre :: String, edad :: Int, remuneracion :: Float, conocimientos :: [String]} | Estudiante {legajo :: String, conocimientos:: [String]} deriving Show

pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]

tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

type Nombre = String

data Puesto = UnPuesto {puesto:: String, conocimientoRequeridos :: [String]} deriving Show

jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]

chePibe = UnPuesto "cadete" ["ir al banco"]

 

apellidoDueno:: Nombre

apellidoDueno = "Gonzalez"

type Requisito = Postulante -> Bool

tieneConocimiento :: Puesto -> Requisito
tieneConocimiento unPuesto unPostulante = all (\unConocimiento -> elem unConocimiento (conocimientos unPostulante))  (conocimientoRequeridos unPuesto)

tieneConocimiento' ::  Puesto -> Requisito
tieneConocimiento' unPuesto unPostulante = all (flip elem (conocimientos unPostulante)). conocimientoRequeridos $ unPuesto

edadAceptable :: Int -> Int -> Requisito
edadAceptable edadMin edadMax postulante = edadMin <= edad postulante && edad postulante <= edadMax

sinArreglo :: Requisito
sinArreglo postulante = (apellidoDueno /=).last.words.nombre $ postulante

preseleccion :: [Postulante] -> [Requisito] -> [Postulante]
preseleccion postulantes requisitos = filter  (cumpleTodosLosRequisitos requisitos)   postulantes

cumpleTodosLosRequisitos requisitos postulante = all ($ postulante)  requisitos

{-
preseleccion [tito, pepe] [(edadAceptable 30 40), tieneConocimiento jefe, sinArreglo] -}

{-
preseleccion [tito, pepe] [(edadAceptable 30 40), tieneConocimiento jefe, sinArreglo, (all (/= "repetir lógica").conocimientos)] -}
{-
preseleccion [tito, pepe] [(edadAceptable 30 40), tieneConocimiento jefe, sinArreglo,(not.(elem "repetir logica").conocimientos )] -}


actualizarPostulantes :: [Postulante] -> [Postulante]
actualizarPostulantes postulantes = [ aumentarSueldo 27.incrementarEdad $ unPostulante |unPostulante <- postulantes ]

incrementarEdad :: Postulante -> Postulante
incrementarEdad postulante = postulante {edad = edad postulante + 1}

aumentarSueldo :: Float -> Postulante -> Postulante
aumentarSueldo porcentaje postulante = postulante { remuneracion = nuevoSueldo porcentaje postulante}

nuevoSueldo porcentaje postulante = remuneracion postulante + ((remuneracion postulante) * porcentaje /100)

-- 3 b
actualizarPostulantes' postulantes = map (aumentarSueldo 27 . incrementarEdad) postulantes


postulantesInfinitos :: [Postulante]
postulantesInfinitos = tito : postulantesInfinitos

-- 4 a
capacitar :: Postulante -> String -> Postulante
capacitar postulante conocimiento = postulante {conocimientos =  aprender conocimiento postulante}

aprender :: String -> Postulante -> [String]
aprender unConocimiento (UnPostulante _ _ _ conocimientos) = agregarConocimiento conocimientos  unConocimiento
aprender unConocimiento (Estudiante _ conocimientos) = agregarConocimiento (init conocimientos) unConocimiento

agregarConocimiento conocimientos unConocimiento = [unConocimiento] ++ conocimientos

capacitacion :: Puesto -> Postulante -> Postulante
capacitacion unPuesto postulante = foldl  capacitar  postulante  (conocimientoRequeridos unPuesto)

--capacitacion jefe tito
--capacitacion jefe (Estudiante "123242354" ["C++"])

