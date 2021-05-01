data Punto = Plano { coorX :: Double  , coorY :: Double } | 
               Espacio {coorX :: Double , coorY :: Double, coorZ :: Double }

distancia:: Punto-> Double
distancia (Plano x y) = sqrt (x^2 + y^2)
distancia (Espacio x y z) = sqrt (x^2 + y^2 + z^2)

puntoPlano = Plano 6 8
puntoEspacio = Espacio 8 9 7

data Persona = Persona { nombre:: String, edad::Integer} deriving Show

cumplirAños :: Persona -> Persona
cumplirAños (Persona nom edad) = Persona nom (edad + 1)

julia = Persona "julia" 23

seleccionar :: (Integer -> Bool )-> [Integer ] -> [Integer]
seleccionar criterio numeros = [num | num <- numeros , criterio num]

data Empleado = Comun {nomEmple :: String, sueldoBasico :: Integer} | Jerarquico { nomEmple :: String, sueldoBasico :: Integer, cantACargo :: Integer}

sueldo :: Empleado -> Integer
sueldo (Comun _ basico) = basico
sueldo (Jerarquico _ basico cant ) = basico + plus cant

plus cantidad = cantidad * 500

sonia = Comun "sonia" 17000
sofia = Jerarquico "sofia" 4000 5


data Bebida = Cafe {nombreBebida :: String} | Gaseosa {sabor ::String , azucar :: Integer}

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe "capuchino") = True
esEnergizante (Gaseosa "pomelo" cant) = cant > 10
esEnergizante _  = False


find' :: (a -> Bool) -> [a] -> a
find' criterio lista =  head . filter criterio $ lista

data Politico = Politico {proyectosPresentados :: [String], sueldoPolitico :: Float, edadPolitico :: Int } deriving Show
 
politicos = [ Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81, Politico ["tratar de reconquistar luchas sociales"] 10000 63, Politico ["tolerancia 100 para delitos"] 15500 49 ]

--a)  un político joven (menos de 50 años)
-- *Main> find' ((<50).edadPolitico)  politicos
--Politico {proyectosPresentados = ["tolerancia 100 para delitos"], sueldoPolitico = 15500.0, edadPolitico = 49}

--b)  alguno que haya presentado más de 3 proyectos
-- *Main> find' ((>3).length.proyectosPresentados) politicos
-- Politico {proyectosPresentados = ["ser libres","libre estacionamiento
-- coches politicos","ley no fumar","ley 19182"], sueldoPolitico = 20000.0, edadPolitico = 81}

--c) alguno que haya presentado algún proyecto que tenga más de 3 palabras
-- *Main> find' (any ((<3).length.words).proyectosPresentados) politicos
--Politico {proyectosPresentados = ["ser libres","libre estacionamiento
--coches politicos","ley no fumar","ley 19182"], sueldoPolitico = 20000.0, edadPolitico = 81}

