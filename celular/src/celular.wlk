class Mensajeria {
	
	var property memoriaBase
	var property memoriaConversacion
	var property cantidadConversaciones = 0
	var property gastoBateriaPorConversacion = 1
	
	method memoriaOcupada() = memoriaBase + (memoriaConversacion * cantidadConversaciones)
	
	method consumoBateria() = gastoBateriaPorConversacion * cantidadConversaciones
}

class Reproductor {
	 
	 var property memoriaPorItem
	 var property cantidadItems = 0
	 var property memoriaMaxima
	 var property consumoBateria = 2
	 
	 method memoriaOcupada() = (memoriaPorItem * cantidadItems).min(memoriaMaxima)
}

object calculadora {
	const property memoriaOcupada = 10
	var property consumoBateria = 0
}


object celular {
	const aplicacionesAbiertas = #{}
	var property limiteMemoria = 1000
	var property bateria = 100
	
	method memoriaLibre() {
		return limiteMemoria - self.memoriaOcupaAplicaciones()
	}
	
	
	method memoriaOcupaAplicaciones() {
		return aplicacionesAbiertas.sum({unaAplicacion => unaAplicacion.memoriaOcupada()})
	}
	
	method usarCelularUnMinuto() {
		bateria -= self.consumoBateria()
	}
	
	method consumoBateria() {
		return aplicacionesAbiertas.sum({unaAplicacion => unaAplicacion.consumoBateria()})
	}
}
