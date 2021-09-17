object pepe {
	
	var categoria	
	var cantFaltas = 0
	var bonoPresentismo
	var bonoResultado
	
	
	method sueldo() {
		return categoria.neto()	+ bonoPresentismo.importe(cantFaltas) + bonoResultado.importe(categoria.neto())		
	}
	
	method categoria(unaCategoria) {
		categoria = unaCategoria
	}
	
	method cantFaltas(cantidad) {
		cantFaltas = cantidad
	}
	
	method bonoPresentismo(unBono) {
		bonoPresentismo = unBono		
	}
	
	method bonoResultado(unBono) {
		bonoResultado = unBono
	}
	
}

object cadete {
	var neto = 15000
	
	method neto() = neto
}

object gerente {
	var neto = 10000
	
	method neto() = neto
}


object bonoDependeFaltas {
	
	method importe(faltas) {
		if (faltas == 0){
			return 100
		}
		
		if (faltas == 1) {
			return 50
		}
		
		return 0	
	}
	
	
}

object bonoNulo {
	
	method importe(_) {
		return 0
		
	}	
}

object bonoPorcentaje {
	method importe(unNeto) {
		return unNeto * 0.1
	}
}


object bonoFijo {
	
	method importe(_) {
		return 80
	}
}















