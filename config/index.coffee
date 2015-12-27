Duration =			require '../src/util/Duration'
Stocks =			require '../src/util/Stocks'





beginOfDay = (timestamp) ->
	beginOfDay = new Date timestamp
	beginOfDay.setHours 0
	beginOfDay.setMinutes 0
	beginOfDay.setSeconds 0
	beginOfDay.setMilliseconds 0
	return beginOfDay



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
		active: (timestamp) ->
			delta = timestamp - beginOfDay timestamp
			return false if delta <= new Duration '8h'
			return false if delta >= new Duration '22h'
			return true

	beginnerProtection: new Duration '5d'

	units:			require './units'
	buildings:		require './buildings'
