class Contenido {
	var property presupuesto
	
	
	method esIteresante() {
		return presupuesto > 5000000  && self.cumpleCriterioInteresante()
	}	
	
	
	method cumpleCriterioInteresante()
}

class Serie inherits Contenido{
	
	var property cantTemporadas
	override method cumpleCriterioInteresante() {
		
		return cantTemporadas < 5
	}	
	
}

class Pelicula inherits Contenido {
	
	var property anioPublicacion
	override method cumpleCriterioInteresante() {
		return anioPublicacion == (new Date().year())
	}	
	
}
