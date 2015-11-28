Stocks =			require '../src/util/Stocks'





module.exports =



	mapSize: 50

	initialStocks: new Stocks # todo?
		wood: 1000
		clay: 1000
		iron: 1000
	initialWorkers: 0

	units:			require './units'
	buildings:		require './buildings'
