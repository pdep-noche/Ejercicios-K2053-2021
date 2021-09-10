object loboYamilo {
	
	
	var calorias = 80
	
	method calorias() = calorias
	
	method setCalorias(cantCalorias) {
		calorias = cantCalorias		
	}
	
	method comerA(unAnimal) {
		calorias += unAnimal.peso()/10
	}
	
	method sobrepeso() = calorias > 200
	
	method estaSaludable() = calorias.between(20,150)
	
	method correr(cantMinutos) {
		calorias -=  2*cantMinutos
	}
	
}

object chanchito {
	var peso = 30
	
	method peso() = peso
	
}
