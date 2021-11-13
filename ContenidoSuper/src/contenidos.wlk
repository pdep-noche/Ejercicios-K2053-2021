class Contenido {
	
	var property presupuesto
	
	method esInteresante() {
		
		return presupuesto > 5000000
	}	
	
}

class Serie inherits Contenido {
	
	var property cantTemporadas
	
	override method esInteresante() {
		return super() && cantTemporadas < 5
	}
}

class Pelicula inherits Contenido {
	var anioDeEstreno
	
	
	override method esInteresante() {		
		return super() && anioDeEstreno == new Date().year()
	}
}

class Vehiculo {
	var property nivelSuciedad = 0
	
}

class Paloma  {
	
	var property peso
	
	method ensuciar(vehiculo) {
		var cantEnsucia = peso * 0.3
		vehiculo.incrementarNivelSuciedad(	cantEnsucia);
		peso -= cantEnsucia
	}
	
}


class Gaviota {
	
	var property cantPescados
	
	method ensuciar(vehiculo) {
		vehiculo.incrementarNivelSuciedad(cantPescados * 3)		
	}
}

class Ave  {
	
	var property cantEnsucia
	
	method ensuciar(vehiculo) {
		vehiculo.incrementarNivelSuciedad(cantEnsucia)
	}
	
}




