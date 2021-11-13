class Persona {
	
	var property cantCelulas
	const enfermedades = #{}
	var property temperatura
	const tempMax = 45
	
	method contraer(enfermedad ) {
		self.validarCantEnfermedades()
		enfermedades.add(enfermedad)
	}


	method modificarTemperatura(cantidad) {
		temperatura = (temperatura + cantidad).min(45)
	}
	
	method modificarCelulas(cantidad) {
		cantCelulas = (cantCelulas + cantidad).max(0)
	}
	
	method validarCantEnfermedades() {
		if( enfermedades.size() >= 7) {
			throw new DomainException(message = "No puede contraer más enfermedades")
		}
	}
	
 	method tenes(unaEnfermedad) {
 		return enfermedades.contains(unaEnfermedad)
 	}
 	
 	method vivirUnDia() {
 		enfermedades.forEach({unaEnf => unaEnf.afectarA(self)})
 	}
 	
 	method estaEnComa() {
 		return temperatura == tempMax || cantCelulas < 10000000
 	}
 	
 	method cantDeCelulasDeEnfAgresivas() {
 		return self.enfermedadesAgresivas().sum({enfermedad => enfermedad.cantidadcelulasAmenazadas()})
 	}
 	
 	method enfermedadesAgresivas() {
 		return enfermedades.filter({unaEnfer => unaEnfer.esAgresiva(self)})
 	}
 	
 	method enfermedadQueMasCelulasAfecta() = enfermedades.max({unaEnfer => unaEnfer.cantidadcelulasAmenazadas()})
 	
 	method curarseDe(enfermedad) {
 		enfermedades.remove(enfermedad)
 	}
 	
 	method recibirDosis(cantidad) {
 		enfermedades.forEach({unaEnfermedad => unaEnfermedad.atenuar(cantidad, self)})
 	}
 	
 	method disminuirTodaLaTemperatura() {
 		temperatura = 0
 	}
}

class Medico inherits Persona {
	
	var property dosis
	
	method atenderA(unPaciente) {
		unPaciente.recibirDosis(dosis)
	}
	
	override method contraer(unaEnfermedad) {
		super(unaEnfermedad)
		self.atenderA(self)
	}
}

class JefeDeDepartamento inherits Medico {
	const subordinados = #{}
	
	override method atenderA(unPaciente) {
		subordinados.anyOne().atenderA(unPaciente)
	}
}

class Enfermedad {
	var property cantidadcelulasAmenazadas
	
	method atenuar(dosis, persona) {
		self.reducirCantCelulasAmenazadas(dosis)
		if (cantidadcelulasAmenazadas == 0) {
			persona.curarseDe(self)
		}
	}
	
	method reducirCantCelulasAmenazadas(dosis) {
		cantidadcelulasAmenazadas = (cantidadcelulasAmenazadas - dosis *15).max(0)
	}
	
}

class EnfermedadInfecciona inherits Enfermedad   {

	method reproducir() {
		cantidadcelulasAmenazadas *= 2
		
	}
	
	method esAgresiva(paciente) = cantidadcelulasAmenazadas >=  0.001 * paciente.cantCelulas()
	
	method afectarA(paciente) {
		paciente.modificarTemperatura(cantidadcelulasAmenazadas/1000)
	}
}	

	


class EnfermedadAutoinmune inherits Enfermedad {
	
	var cantVecesAfecta = 0
	
	method esAgresiva(_) = cantVecesAfecta > 30
	
	method afectarA(paciente) {
		paciente.modificarCelulas(-cantidadcelulasAmenazadas)
		cantVecesAfecta += 1
	}
	
}

object hipotermia {
	
	method afectarA(paciente) {		
		paciente.disminuirTodaLaTemperatura()
	}	
	
	method atenuar(dosis) {		
	}
	
	method cantidadcelulasAmenazadas() = 0
	
	method esAgresiva(paciente) = true	
	
}

