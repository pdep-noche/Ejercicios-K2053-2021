object tom {
	
	var energia
	var posicion = 30
	
	method energia(cantEnergia)  {
		energia = cantEnergia
	}
	
	method energia() = energia
	
	method posicion() = posicion
	
	method velocidad() = 5 + (energia/10)
	
	method puedeAtraparA(algo) = self.velocidad() > algo.velocidad()
	
	method correrA(algo)  {
		energia -= 0.5 *  self.velocidad() * self.distanciaA(algo)
		posicion = algo.posicion()	
	}
	
	method distanciaA(algo) {
		return (posicion - algo.posicion()).abs()
	}	
	
}

object jerry {
	var peso
	var posicion = 34
	
	method peso(cantidad) {
		peso = cantidad
	}
	
	method velocidad() = 10 - peso
	
	method posicion() = posicion
	
	}
	
object robotRaton {
	const velocidad = 8
	var posicion = 37
	
	method velocidad() = velocidad

	method posicion() = posicion
	
}
