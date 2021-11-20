class Aseguradora {
	
	
	method cuantoTieneQuePagar(siniestro, vehiculo) {
		self.validarParticipacionVehiculo(siniestro, vehiculo)
		return vehiculo.cuantoCubrePoliza(siniestro)
		
	}
	
	method validarParticipacionVehiculo(unSiniestro, unVehiculo) {
		if(!unSiniestro.participo(unVehiculo)) {
			throw new NoParticipoVehiculo(message = "vehiculo no participo en siniestro")
		}
	}
}

class NoParticipoVehiculo inherits DomainException {
	
}

class Vehiculo {
	var property poliza
	const siniestros =  #{}
	
	
	method cuantoCubrePoliza(sinestro) {
		return poliza.cuantoCubreEn(sinestro, self)
	}
	
	method montoNoCubierto()  = siniestros.sum({unSiniestro => poliza.montoNoCubierto(unSiniestro, self)})
}

class Poliza {
	var property aseguradora
	
	method cuandoCubreEn(unSiniestro, vehiculo) {
		return self.danios(unSiniestro, vehiculo).sum({unDanio => unDanio.monto()})
	}
	
	
	method danios(sinestro, vehiculo)
	
	
	
}

class ContraTerceros inherits Poliza {
	override method danios(unSiniestro, vehiculo) {
		
		return unSiniestro.danios().filter({unDanio => unDanio.involucrado() != vehiculo})
	}
	
	method montoNoCubierto(siniestro, vehiculo) = siniestro.calcularDaniosPara(vehiculo)
	
}

class ContraTodoRiesgo inherits Poliza {
	override method danios(unSiniestro, _) = unSiniestro.danios()
	
	method montoNoCubierto(siniestro, _) = 0
}

class Siniestro {
	
	const property danios = #{}
	method calcularDaniosPara(vehiculo) = self.danioVehiculo(vehiculo).monto()
	
	method danioVehiculo(vehiculo) = danios.find({unDanio => unDanio.involucrado() == vehiculo})
}

class Danio {
	var property monto
	var property involucrado
}




