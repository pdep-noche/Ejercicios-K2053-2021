object sara {
	
	var peso = 55
	var vitalidad = 90
	var temperatura = 37
	
	
	method modificarTemperatura(cantidad) {
		temperatura += cantidad
	}
	
	method modificarVitalidad(cantidad) {
		vitalidad += cantidad
	}	
	
	method modificarPeso(cantidad) {
		peso += cantidad
	}
	
	method peso() = peso
	
	method vitalidad() = vitalidad
	
	method temperaturaNormal() {
		temperatura = 37
	}
	
	method temperatura(cantidad) {
		temperatura = cantidad
	}	
	
	
	method esAfectadaPor(algo) {
		algo.afectar(self)
	}
	
	
	method temperatura() = temperatura
	
	
}

object malaria {
	
	method afectar(persona) {
		
		persona.modificarTemperatura(3)
		
	}
	
}

object varicela {
	
	method afectar(persona) {
		persona.modificarVitalidad(-5)
		persona.modificarPeso(persona.peso()*(-0.1))
	}
}

object gripe {
	
	method afectar(persona) {
		persona.modificarVitalidad(persona.vitalidad() * (-0.2))
	}
}

object paracetamol {
	
	method afectar(persona) {
		if (persona.temperatura() > 37) {
			persona.temperaturaNormal()
		}
	}
}

object polen {
	var gramos = 10
	
	method afectar(persona) {
		persona.modificarVitalidad(gramos * 0.1)
	}
}

object nuez {
	
	method afectar(persona) {
		persona.modificarVitalidad(persona.vitalidad() * 0.3)
	}
}


