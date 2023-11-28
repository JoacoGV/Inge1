!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test01SonIgualesConMismoPaloYNumero

	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test02SonDistintasConDistintoPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test03SonDistintasConNumeroAunqueIgualPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test04CartasIgualesTienenElMismoHash

	self assert: (CartaDeTruco bastoCon: 1) hash equals: (CartaDeTruco bastoCon: 1) hash

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta

	self deny: (CartaDeTruco bastoCon: 1) = 1! !


!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test07NoHayCartaDeTrucoConNumeroOcho

	self 
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test08NoHayCartaDeTrucoConNumeroNueve

	self 
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:12'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa

	self 
		should: [ CartaDeTruco palo: #otro numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test10NoSePuedeCrearCartaConNumeroMenorAUno

	self 
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test11NoSePuedeCrearCartaConNumeroMayorADoce

	self 
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test12ElNumeroDeLaCartaDebeSerEntero

	self 
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:55:30'!
test13LaTablaDeValoresEsCorrecta

	self assert: (CartaDeTruco anchoDeEspada mataA: CartaDeTruco anchoDeBasto).
	self assert: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco sieteDeEspada).
	self assert: (CartaDeTruco sieteDeEspada mataA: CartaDeTruco sieteDeOro).
	self assert: (CartaDeTruco sieteDeOro mataA: (CartaDeTruco espadaCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) empardaCon: (CartaDeTruco oroCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) mataA: (CartaDeTruco espadaCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) empardaCon: (CartaDeTruco oroCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) mataA: (CartaDeTruco oroCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) empardaCon: (CartaDeTruco copaCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) mataA: (CartaDeTruco espadaCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) empardaCon: (CartaDeTruco oroCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) mataA: (CartaDeTruco espadaCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) empardaCon: (CartaDeTruco oroCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) mataA: (CartaDeTruco espadaCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) empardaCon: (CartaDeTruco oroCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) mataA: (CartaDeTruco copaCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) empardaCon: (CartaDeTruco bastoCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) mataA: (CartaDeTruco espadaCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) empardaCon: (CartaDeTruco oroCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) mataA: (CartaDeTruco espadaCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) empardaCon: (CartaDeTruco oroCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) mataA: (CartaDeTruco espadaCon: 4)).
	self assert: ((CartaDeTruco espadaCon: 4) empardaCon: (CartaDeTruco oroCon: 4)).

	{ 3. 2. 12. 11. 10. 6. 5. 4 } do: [ :unNumero |
		CartaDeTruco palos do: [ :unPalo | 
			self assert: ((CartaDeTruco espadaCon: unNumero) empardaCon: (CartaDeTruco palo: unPalo numero: unNumero)) ]]
	! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:51'!
test14HayCartasQueNoSonPardas

	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:59'!
test15HayCartasQuePierdenConOtras

	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:53:21'!
test16SieteDeCopasYDeBastoEsSieteFalso

	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:54:57'!
test17SieteDeOroYDeEspadaNoSonSieteFalso

	self deny: (CartaDeTruco sieteDeOro) esSieteFalso.
	self deny: (CartaDeTruco sieteDeEspada) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:55:53'!
test18AnchoDeOroYDeCopaSonAnchoFalsos

	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:56:28'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos

	self deny: (CartaDeTruco anchoDeEspada) esAnchoFalso.
	self deny: (CartaDeTruco anchoDeBasto) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 11:58:24'!
test20FallaBuscandoValorDeCartaInválida

	"Creo una carta de manera inválida para probar la correctitud del la tabla de valores - Hernan"
	self 
		should: [ CartaDeTruco new initializePalo: #invalido numero: 1; valor ]
		raise: Error 
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 19:39:03'!
test04NoSePuedeCrearUnaRondaDeTrucoRepartiendoMenosDeTresCartasParaLaMano
	self 
	should: [
			RondaDeTruco cartasDeLaMano: (OrderedCollection with: (CartaDeTruco anchoDeBasto)) cartasDelPie: (OrderedCollection with: CartaDeTruco anchoDeEspada).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco noSePuedenRepartirMenosDeTresCartasACadaJugador.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 19:53:44'!
test05NoSePuedeCrearUnaRondaDeTrucoRepartiendoMasDeTresCartasParaLaMano
	self 
	should: [
			RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada) with: CartaDeTruco sieteDeOro)
				cartasDelPie: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4)).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco noSePuedenRepartirMasDeTresCartasACadaJugador.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 19:51:24'!
test06NoSePuedeCrearUnaRondaDeTrucoRepartiendoMenosDeTresCartasParaElPie
	self 
	should: [
			RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto)).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco noSePuedenRepartirMenosDeTresCartasACadaJugador.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 19:49:02'!
test07NoSePuedeCrearUnaRondaDeTrucoRepartiendoMasDeTresCartasParaElPie
	self 
	should: [
			RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada) with: CartaDeTruco sieteDeOro).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco noSePuedenRepartirMasDeTresCartasACadaJugador.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 19:58:18'!
test08NoSePuedeCrearUnaRondaDeTrucoRepartiendoUnaMismaCartaAAmbosJugadores
	self 
	should: [
			RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco noSePuedeRepartirUnaMismaCartaAAmbosJugadores.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 20:49:05'!
test09ElPieNoPuedeComenzarLaRondaDeTruco
	
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
				
				

	self 
	should: [
			ronda pieJuega: (CartaDeTruco anchoDeBasto).
		]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
			self assert: anError messageText equals: RondaDeTruco elPieNoPuedeJugarEnEsteMomento.
			self assert: ronda cartasEnManoDelPie equals: 3.
		].! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 20:28:03'!
test10CuandoLaManoJuegaTieneUnCartaMenosEnMano	
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
				
	ronda manoJuega: (CartaDeTruco bastoCon: 3).
	self assert: ronda cartasEnManoDeLaMano equals: 2.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 20:32:00'!
test11LaManoNoPuedeJugarLuegoDeHaberJugadoLaCartaInicial	
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
		
	
	self 
		should: [
			ronda manoJuega: (CartaDeTruco bastoCon: 3).
			ronda manoJuega: (CartaDeTruco bastoCon: 2).
		] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [ :anError |
					self assert: anError messageText equals: RondaDeTruco laManoNoPuedeJugarEnEsteMomento.
					self assert: ronda cartasEnManoDeLaMano equals: 2.
				].
			! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 20:40:27'!
test12LaManoNoPuedeJugarUnaCartaQueNoPosea
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
		
	
	self 
		should: [
			ronda manoJuega: (CartaDeTruco anchoDeBasto ).

		] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [ :anError |
					self assert: anError messageText equals: RondaDeTruco elJugadorNoTieneEsaCartaEnMano.
					self assert: ronda cartasEnManoDeLaMano equals: 3.
				].
			! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 20:46:02'!
test13ElPiePuedeJugarLuegoDeQueLaManoHayaJugadoLaCartaInicial
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
		
	ronda manoJuega: (CartaDeTruco bastoCon: 2).
	ronda pieJuega: (CartaDeTruco anchoDeBasto).
	self assert: ronda cartasEnManoDelPie equals: 2.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 21:02:21'!
test14CuandoElPieJugaTienUnaCartaMenosEnMano
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
				
	ronda manoJuega: (CartaDeTruco bastoCon: 2).
	ronda pieJuega: (CartaDeTruco anchoDeBasto).

	self assert: ronda cartasEnManoDelPie equals: 2.
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 21:02:31'!
test15ElPieNoPuedeJugarUnaCartaQueNoPosea
	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada)).
				
	ronda manoJuega: (CartaDeTruco bastoCon: 2).
	
	self should: [
			ronda pieJuega: (CartaDeTruco bastoCon: 2).
		] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco elJugadorNoTieneEsaCartaEnMano.
			self assert: ronda cartasEnManoDelPie equals: 3			
		].
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 21:02:39'!
test16SiLaManoGanaLaVueltaPuedeContinuarJugandoOtraCarta

	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4)).
				
	ronda manoJuega: (CartaDeTruco anchoDeBasto).
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self shouldnt: [ ronda manoJuega: (CartaDeTruco anchoDeEspada). ]
	raise: Error.
	
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'jgv 11/27/2023 21:05:52'!
test17SiLaManoGanaLaVueltaElPieNoPuedeJugarAntesQueLaManoVuelvaATirarCarta

	| ronda |
	
	ronda := RondaDeTruco 
				cartasDeLaMano: (OrderedCollection with: (CartaDeTruco anchoDeBasto) with: (CartaDeTruco anchoDeEspada) with: (CartaDeTruco sieteDeEspada))
				cartasDelPie: (OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4)).
				
	ronda manoJuega: (CartaDeTruco anchoDeBasto).
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self should: [ ronda manoJuega: (CartaDeTruco anchoDeEspada). ]
	raise: Error
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco elPieNoPuedeJugarEnEsteMomento.
			self assert: ronda cartasEnManoDelPie equals: 2.
		].
	
	
! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/3/2021 15:27:51'!
initializePalo: unPalo numero: unNumero 
	
	palo := unPalo.
	numero := unNumero.! !


!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:44:36'!
= unaCarta 
	
	^(unaCarta isKindOf: self class) and: [(unaCarta paloEs: palo) and: [ unaCarta numeroEs: numero ]]! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:51'!
empardaCon: cartaParda

	^self valor = cartaParda valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:43:24'!
hash
	
	^palo hash bitXor: numero hash ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:59'!
mataA: cartaPerdedora

	^self valor < cartaPerdedora valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:53'!
numeroEs: unNumero

	^numero = unNumero ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:39'!
paloEs: unPalo

	^palo = unPalo ! !


!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAncho

	^ self numeroEs: 1! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:31'!
esAnchoDeBasto
	
	^self esAncho and: [ self esDeBasto ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:41'!
esAnchoDeEspada
	
	^self esAncho and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAnchoFalso
	
	^self esAncho and: [ self esDeOro or: [ self esDeCopa ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:32'!
esCaballo
	
	^self numeroEs: 11! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:25:29'!
esDeBasto
	
	^self paloEs: self basto! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esDeCopa
	
	^self paloEs: self copa! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:18'!
esDeEspada
	
	^self paloEs: self espada ! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:35'!
esDeOro
	
	^self paloEs: self oro! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:22'!
esRey
	
	^self numeroEs: 12! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:16:57'!
esSiete
	
	^self numeroEs: 7! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:00'!
esSieteDeEspadas
	
	^self esSiete and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:15'!
esSieteDeOro
	
	^self esSiete and: [ self esDeOro ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esSieteFalso
	
	^self esSiete and: [ self esDeCopa or: [ self esDeBasto ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:43'!
esSota
	
	^self numeroEs: 10! !


!CartaDeTruco methodsFor: 'printing' stamp: 'HAW 7/3/2021 15:14:43'!
printOn: aStream

	aStream 
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: 	palo ! !


!CartaDeTruco methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:51:09'!
valor
	
	^self class valorDe: self! !


!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:33'!
basto
	
	^self class basto! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:44'!
copa

	^ self class copa! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:08'!
espada
	
	^self class espada! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:26:27'!
oro

	^ self class oro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:37'!
anchoDeBasto
	
	^self bastoCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:57'!
anchoDeEspada
	
	^self espadaCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:03'!
bastoCon: unNumero

	^self palo: self basto numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:08'!
copaCon: unNumero

	^self palo: self copa numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:16'!
espadaCon: unNumero

	^self palo: self espada numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:34'!
oroCon: unNumero

	^self palo: self oro numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 18:06:08'!
palo: unPalo numero: unNumero 
	
	self assertNúmeroEsVálido: unNumero.
	self assertPaloEsVálido: unPalo.
	
	^self new initializePalo: unPalo numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:12:50'!
sieteDeEspada
	
	^self espadaCon: 7! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:17:44'!
sieteDeOro
	
	^self oroCon: 7! !


!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:56:25'!
basto
	
	^#basto! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:25'!
copa
	
	^#copa! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:55:44'!
espada
	
	^#espada! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:43'!
oro
	
	^#oro! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/4/2021 18:07:36'!
palos

	"No se puede acceder a self en backtick, por eso se usa CartaDeTruco como receiver - Hernan"
	^ `{CartaDeTruco espada. CartaDeTruco basto. CartaDeTruco oro. CartaDeTruco copa }`! !


!CartaDeTruco class methodsFor: 'initialization' stamp: 'HAW 7/5/2021 10:52:07'!
initializeOrdenDePrioridad
	
	"Cuanto más chico sea el índice de la carta en esta colección, más valor tiene - Hernan"
	ordenDePrioridad := OrderedCollection new.
	
	ordenDePrioridad 
		add: [ :carta | carta esAnchoDeEspada ];
		add: [ :carta | carta esAnchoDeBasto ];
		add: [ :carta | carta esSieteDeEspadas ];
		add: [ :carta | carta esSieteDeOro ];
		add: [ :carta | carta numeroEs: 3 ];
		add: [ :carta | carta numeroEs: 2 ];
		add: [ :carta | carta esAnchoFalso ];
		add: [ :carta | carta esRey ];
		add: [ :carta | carta esCaballo ];
		add: [ :carta | carta esSota ];
		add: [ :carta | carta esSieteFalso ];
		add: [ :carta | carta numeroEs: 6 ];
		add: [ :carta | carta numeroEs: 5 ];
		add: [ :carta | carta numeroEs: 4 ];
		yourself.
	
	! !


!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:54:01'!
ordenDePrioridad
	
	^ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ] ! !

!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/5/2021 11:58:24'!
valorDe: unaCarta 
	
	self ordenDePrioridad withIndexDo: [ :bloqueDeVerificacion :index |
		(bloqueDeVerificacion value: unaCarta) ifTrue: [ ^index ]].
	
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:02'!
numeroDeCartaInvalidoErrorDescription
	
	^'El truco no se puede jugar con ochos ni con nueves'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:12'!
paloInvalidoErrorDescription
	
	^'Los palos de la carta solo pueden ser espada, basto, oro y copa'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:24'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	
	^'Error de programación: Tabla de valores incorrecta o carta inválida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:02'!
assertNúmeroEsVálido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:12'!
assertPaloEsVálido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'pie mano otraManoDeTruco_CHANGE_ME laManoPuedeJugar elPiePuedeJugar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'pie' stamp: 'jgv 11/27/2023 20:19:12'!
cartasEnManoDelPie
	^pie size.! !

!RondaDeTruco methodsFor: 'pie' stamp: 'jgv 11/27/2023 21:18:36'!
pieJuega: unaCartaDeTruco
	elPiePuedeJugar ifFalse: [	self error: RondaDeTruco elPieNoPuedeJugarEnEsteMomento].
	
	pie remove: unaCartaDeTruco ifAbsent: [self error: RondaDeTruco elJugadorNoTieneEsaCartaEnMano].
	
	mano last size = 2 ifTrue: [ 
		(mano last first mataA: mano last second) ifTrue: [ 	
			laManoPuedeJugar := laManoPuedeJugar not.
			elPiePuedeJugar := elPiePuedeJugar not.]
	].! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'jgv 11/27/2023 20:51:45'!
initializeCartasDeLaMano: unaManoDeTruco cartasDelPie: otraManoDeTruco 
	mano := unaManoDeTruco.
	pie := otraManoDeTruco.
	laManoPuedeJugar := true.
	elPiePuedeJugar := false.! !


!RondaDeTruco methodsFor: 'mano' stamp: 'jgv 11/27/2023 20:28:20'!
cartasEnManoDeLaMano
	^mano size.! !

!RondaDeTruco methodsFor: 'mano' stamp: 'jgv 11/27/2023 21:17:54'!
manoJuega: unaCartaDeTruco 
	laManoPuedeJugar ifFalse: [ self error: RondaDeTruco laManoNoPuedeJugarEnEsteMomento ].
	
	mano remove: unaCartaDeTruco ifAbsent: [ self error: RondaDeTruco elJugadorNoTieneEsaCartaEnMano].
	
	mano last size = 2 ifTrue: [ 
			(mano last first mataA: mano last second) ifTrue: [ 	
				laManoPuedeJugar := laManoPuedeJugar not.
				elPiePuedeJugar := elPiePuedeJugar not.]
		]

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'jgv 11/27/2023 20:17:57'!
cartasDeLaMano: unaManoDeTruco cartasDelPie: otraManoDeTruco
	(unaManoDeTruco size < 3 or: [otraManoDeTruco size < 3]) ifTrue: [self error: RondaDeTruco noSePuedenRepartirMenosDeTresCartasACadaJugador].
	(unaManoDeTruco size > 3 or: [otraManoDeTruco size > 3]) ifTrue: [self error: RondaDeTruco noSePuedenRepartirMasDeTresCartasACadaJugador.].
	(unaManoDeTruco anySatisfy: [ :unaCartaDeTruco | otraManoDeTruco includes: unaCartaDeTruco]) ifTrue: [
			self error: RondaDeTruco noSePuedeRepartirUnaMismaCartaAAmbosJugadores.
		].
	
	^self new initializeCartasDeLaMano: unaManoDeTruco cartasDelPie: otraManoDeTruco.! !


!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 20:39:20'!
elJugadorNoTieneEsaCartaEnMano
	^'El jugador no tiene esa carta en mano'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 20:48:35'!
elPieNoPuedeJugarEnEsteMomento
	^'El pie no puede jugar en este momento!!'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 20:50:06'!
laManoNoPuedeJugarEnEsteMomento
	^'La mano no puede jugar en este momento!!'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:19:56'!
noSePuedeCrearRondaSinCartasRepartidas
	^'No se puede crear la ronda sin cartas repartidas!!'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:23:28'!
noSePuedeCrearUnaRondaDeTrucoSinRepartirCartasALaMano
	^'No se puede crear una ronda de truco sin repartir cartas a La Mano'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:33:50'!
noSePuedeCrearUnaRondaDeTrucoSinRepartirCartasAlPie
	^'No se puede crear una ronda de truco sin repartir cartas al Pie'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:58:43'!
noSePuedeRepartirUnaMismaCartaAAmbosJugadores
	^'No se puede repartir una misma carta a ambors jugadores!!'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:44:23'!
noSePuedenRepartirMasDeTresCartasACadaJugador
	^'No se pueden repartir más de tres cartas a cada jugador!!'! !

!RondaDeTruco class methodsFor: 'error-descriptions' stamp: 'jgv 11/27/2023 19:39:32'!
noSePuedenRepartirMenosDeTresCartasACadaJugador
	^'No se pueden repartir menos de tres cartas a los jugadores!!'! !
