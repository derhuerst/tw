Duration =			require '../src/util/Duration'
Stocks =			require '../src/util/Stocks'





module.exports =



	map:
		size: 1000
		spread: 10

	initialStocks: new Stocks # todo?
		wood: 1000
		clay: 1000
		iron: 1000

	nightBonus:
		factor: 2
		from: '22:00'
		to: '08:00'

	beginnerProtection: new Duration '5d'

	units:			require './units'
	buildings:		require './buildings'
