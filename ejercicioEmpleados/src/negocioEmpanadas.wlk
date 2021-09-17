object galvan {
	
	var sueldoFijo = 15000
	
	method sueldo()  = sueldoFijo
	
	
}

object baigorria {
	var cantidadEmpanadasVedidas = 400
	var montoXEmpanada = 50
	
	method sueldo()  = cantidadEmpanadasVedidas * montoXEmpanada
	
	
}

object negocio {
	
	var cantidadDisponible = 50000
	
	method pagarA(unEmpleado) {
		
		cantidadDisponible -= unEmpleado.sueldo()		
		
	}
}
