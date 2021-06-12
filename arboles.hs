import Text.Show.Functions
data Arbol = Arbol {especie :: Especie, altura :: Int, ancho :: Int, vitalidad :: Float} deriving Show
type Especie = (String, Crecimiento)

type Crecimiento =  (Int -> Int)

unJacaranda = Arbol jacaranda 6 1 1.4
unPino = Arbol pino 5 3 1.9
unEucalipto = Arbol eucalipto 5 4 0.7
otroJacaranda = Arbol jacaranda 10 2 1.0
unCerezo = Arbol cerezo 7 11 0.9
unBanano = Arbol banano 8 10 2.1

cerezo= ("cerezo", escalonado)
banano= ("banano", progresivo)
jacaranda = ("jacaranda", progresivo)
pino = ("pino", duplica)
eucalipto = ("eucalipto", escalonado)

progresivo = (`div` 2)
escalonado = (`mod` 2)
duplica = (2*)
torcido = progresivo.escalonado

arboles = [unJacaranda,unPino, unEucalipto ]
-- 2
hayAlgunFrondoso :: [Arbol] -> Bool
hayAlgunFrondoso arboles = any esFrondosoConVitalidad arboles

esFrondosoConVitalidad :: Arbol -> Bool
esFrondosoConVitalidad arbol = esFrondoso arbol && tieneVitalidad arbol

esFrondoso :: Arbol -> Bool
esFrondoso arbol = (altura arbol >= 6 && altura arbol <= 15) && (ancho arbol > altura arbol)

tieneVitalidad :: Arbol -> Bool
tieneVitalidad arbol = (>1).vitalidad $ arbol

-- 3
type FactorClimatico = Arbol -> Arbol


modificarAncho :: (Int -> Int) -> Arbol -> Arbol
modificarAncho f arbol =  arbol {ancho = f.ancho $ arbol}

modificarAlto :: (Int -> Int) -> Arbol -> Arbol
modificarAlto f arbol = arbol {altura = f.altura $ arbol }

modificarVitalidad  ::  (Float -> Float) -> Arbol -> Arbol
modificarVitalidad f arbol = arbol { vitalidad = f.vitalidad $ arbol}

granizo :: FactorClimatico
granizo arbol = modificarAncho progresivo. modificarAlto progresivo $ arbol

lluvia :: Float -> FactorClimatico
lluvia cantMilimetros arbol = modificarAlto (+1).modificarVitalidad (sumar cantMilimetros) $ arbol

sumar :: Float -> Float -> Float
sumar cant vitalidad = vitalidad * (1 + cant /100)

temperatura :: Float -> FactorClimatico
temperatura grados arbol | grados < 0 = modificarVitalidad (/2) arbol
                        | grados > 40 = modificarVitalidad (sumar (-40)) arbol
                        | otherwise = arbol