object pepita {
	
	
	var energia = 100
	
	
	method volar(cantMetros) {
		energia -= cantMetros
	}
	
	method comer(cantGramos) {
		energia += cantGramos * 2
	}
	
	method energia() = energia	
	
}
