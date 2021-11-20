
class EspacioUrbano {
	var property superficie
	var property valuacion
	var property tieneVallado
	const property trabajosRealizados = #{}
	
	
	method esGrande() {
		
		return superficie > 50 && self.cumpleCondiciones()
	}
	
	method cumpleCondiciones()
	
	method esEspacioVerde() = false
	
	method esEspacioLimpliable() = false
	
	
	method aumentarValuacion(cantidad) {
		valuacion += cantidad
	}
	
	method esDeUsoIntensivo() {
		return self.cantidaDeTrabajosHeavies() > 5
	}
	
	method cantidaDeTrabajosHeavies() {
		return self.trabajosRealizadosHeavies().size()
	}
	
	method trabajosRealizadosHeavies() {
		return trabajosRealizados.filter({unTrabajo => unTrabajo.esHeavy()})
	}
	

}

class Plaza inherits EspacioUrbano {
	
	var property cantCanchas
	var property espacioEsparcimiento
	
	override method cumpleCondiciones() = cantCanchas > 2
	
	override method esEspacioVerde() = cantCanchas == 0
	
	
	override method esEspacioLimpliable() = true
	
}

class Plazoleta inherits EspacioUrbano {
	var property procer
	
	override method cumpleCondiciones() = procer === "San Martin" && tieneVallado
	
}

class Anfiteatro inherits EspacioUrbano {
	var property capacidad
	var property tamanioEscenario
	
	override method cumpleCondiciones() = capacidad > 500	
	
	override method esEspacioLimpliable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano {
	
	const property espaciosUrbanos
	
	override method cumpleCondiciones() = espaciosUrbanos.all({unEspacio => unEspacio.esGrande()})
	
	override method esEspacioVerde()  = espaciosUrbanos.size() > 3
}

class Trabajador {
	
	var property valorHora = 100
	
	var property profesion
	
	method trabajaEn(espacioUrbano) {
		profesion.trabajaEn(espacioUrbano, self)
	}	
	
	method realizoTrabajoHeavy(trabajo) {
		return profesion.esHeavy(trabajo)
	}
	
}

class Profesion{
	
	
	method trabajaEn(espacioUrbano, trabajador) {
		self.validarTrabajoEn(espacioUrbano)
		self.producirEfecto(espacioUrbano)
		self.registrarTrabajo(espacioUrbano, trabajador)
		}
		
	method validarTrabajoEn(unEspacioUrbano) {
		if(!self.puedeRealizarTrabajoEn(unEspacioUrbano)) {
			throw new TrabajoIncompatible(message= "no puede realizar dicho trabajo")
		}
	}
	
	method esHeavy(trabajo) {
		return trabajo.costo() > 10000
	}
	
	method puedeRealizarTrabajoEn(unEspacio)
	method producirEfecto(espacioUrbano)
	
	method registrarTrabajo(espacioUrbano, trabajador) {
		espacioUrbano.agregarTrabajo(self.trabajoRealizado(espacioUrbano, trabajador))
	}
	
	method trabajoRealizado(espacioUrbano, trabajador) {
		return new Trabajo(persona = trabajador, duracion = self.duracionTrabajo(espacioUrbano), costo  = self.costoTrabajo(espacioUrbano, trabajador))
	}
	
	method duracionTrabajo(espacioUrbano)
	
	method costoTrabajo(espacioUrbano, trabajador) {
		return trabajador.valorHora() * self.duracionTrabajo(espacioUrbano)
		
	}
}



object cerrajero inherits Profesion {
	
	override method puedeRealizarTrabajoEn(unEspacioUrbano) {
		!unEspacioUrbano.tieneVallado()
	}
	
	override method producirEfecto(espacioUrbano) {
		espacioUrbano.tieneVallado(true)
	}
	
	override method duracionTrabajo(espacioUrbano) {
		if(espacioUrbano.esGrande()) {
			return 5			
		}		
		return 3
	}
	
	override method esHeavy(trabajo) {
		return super(trabajo) && trabajo.duracion() > 5
	}
}


object jardinero inherits Profesion {
	override method puedeRealizarTrabajoEn(unEspacioUrbano) = unEspacioUrbano.esEspacioVerde()
	
	override method producirEfecto(espacioUrbano) {
		espacioUrbano.aumentarValuacion(espacioUrbano.valuacion() *0.1)
	}
	
	override method duracionTrabajo(espacioUrbano) = espacioUrbano.superficie() /10
	
	
	override method costoTrabajo(espacioUrbano, trabajador) = 2500
}


object encargado inherits Profesion {
	
	override method puedeRealizarTrabajoEn(unEspacioUrbano) = unEspacioUrbano.esLimpiable()
	
	override method producirEfecto(espacioUrbano) {
		espacioUrbano.aumentarValuacion(5000)
	}
	
	override method duracionTrabajo(_) = 8
	
	
}

object secretaria {
	
	
	const property espaciosUrbanos = #{}
	
	method espaciosUrbanosDeUsoIntensivo() {
		return espaciosUrbanos.filter({unEspacio => unEspacio.esDeUsoIntensivo()})
	}
	
	
}

class Trabajo {
	
	var property fecha = new Date()
	var property duracion
	var property persona
	var property costo
	
	method esHeavy() = persona.realizoTrabajoHeavy(self) 
}
class TrabajoIncompatible inherits DomainException {}













