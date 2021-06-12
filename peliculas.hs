import Text.Show.Functions
psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas"  "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"
juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer] 60

peliculasEmpresa = [psicosis, perfumeDeMujer, elSaborDeLasCervezas,lasTortugasTambienVuelan]
data Pelicula = Pelicula {nombreP :: String, genero:: String, 
             duracion::Int, origen :: String} deriving (Show, Eq)
data UnUsuario = Usuario { nombre :: String, categoria:: String , 
           edad :: Int, paisResidencia :: String, 
           peliculas :: [Pelicula], nivelSalud :: Int } deriving Show
-- 2
ver :: Pelicula -> UnUsuario -> UnUsuario
ver unaPelicula usuario = usuario { peliculas = peliculas usuario ++ [unaPelicula]}

-- 3
premiarUsuariosFieles :: [UnUsuario] -> [UnUsuario]
premiarUsuariosFieles usuarios = map premiarSiEsFiel usuarios

premiarSiEsFiel :: UnUsuario -> UnUsuario
premiarSiEsFiel unUsuario | cumpleCondiciones unUsuario = subirCategoria unUsuario
                           | otherwise = unUsuario

cumpleCondiciones :: UnUsuario -> Bool 
cumpleCondiciones usuario = ((>2).length. peliculasQueNoSeanDe "Estados Unidos".peliculas) usuario 

peliculasQueNoSeanDe :: String -> [Pelicula] -> [Pelicula]
peliculasQueNoSeanDe pais peliculas = filter ((pais /=).origen) peliculas

subirCategoria :: UnUsuario -> UnUsuario
subirCategoria usuario = usuario {categoria = (nuevaCategoria .categoria) usuario}

nuevaCategoria :: String -> String
nuevaCategoria "basica" = "estandar"
nuevaCategoria _ = "premium"

type CriterioBusqueda = Pelicula -> Bool

teQuedasteCorto :: CriterioBusqueda
teQuedasteCorto unaPelicula =   (<35).duracion $ unaPelicula

cuestionDeGenero :: [String] -> CriterioBusqueda
cuestionDeGenero generos unaPelicula = elem (genero unaPelicula)  generos


cuestionDeGenero' generos unaPelicula = any (==(genero unaPelicula)) generos

deDondeSaliste:: String -> CriterioBusqueda
deDondeSaliste unOrigen pelicula = (==unOrigen). origen $ pelicula

vaPorEseLado ::(Eq t) =>  Pelicula -> (Pelicula -> t)  -> CriterioBusqueda
vaPorEseLado pelicula cacteristica otraPelicula = (cacteristica pelicula)  == (cacteristica otraPelicula)

--5
busquedaDePeliculas :: UnUsuario -> [CriterioBusqueda] -> [Pelicula] -> [Pelicula]
busquedaDePeliculas usuario criterios peliculas = take 3. filter (esRecomendablePara usuario criterios) $ peliculas

esRecomendablePara :: UnUsuario -> [CriterioBusqueda] ->Pelicula -> Bool
esRecomendablePara usuario criterios pelicula = (not.vio pelicula) usuario && cumpleCriterios pelicula criterios

vio :: Pelicula -> UnUsuario -> Bool
vio unaPelicula unUsuario = elem unaPelicula (peliculas unUsuario)

cumpleCriterios :: Pelicula -> [CriterioBusqueda]  -> Bool
cumpleCriterios pelicula criterios = all  ($ pelicula)  criterios


{- busquedaDePeliculas juan [deDondeSaliste "Iran",cuestionDeGenero ["Drama", "Comdia"],(not.teQuedasteCorto)] peliculasEmpresa
[Pelicula {nombreP = "El sabor de las cervezas", genero = "Drama", duracion = 95, origen = "Iran"},Pelicula {nombreP = "Las tortugas tambi\233n vuelan", genero = "Drama", duracion = 103, origen = "Iran"}]
-}

--SegundaParte
--1
data Capitulo = Capitulo {nombreS :: String, generoS :: String, duracionS ::Int, origenS :: String, afecta :: (UnUsuario -> UnUsuario) } deriving Show


consumen :: UnUsuario -> Capitulo -> UnUsuario
consumen usuario capitulo = (afecta capitulo) usuario

--3
capituloI = Capitulo "Dr House - Piloto" "Drama" 30 "Estados Unidos"  (\usuario -> usuario {nivelSalud = (nivelSalud usuario)- 10}) 

--4
type Serie = [Capitulo]

maraton :: UnUsuario -> Serie -> UnUsuario
maraton usuario capitulos = foldl consumen  usuario capitulos

serieInfinita = repeat capituloI
{- maraton juan (take 3 serieInfinita)
-}