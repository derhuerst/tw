config =			require '../../config'
Stocks =			require '../util/Stocks'
Building =			require '../core/Building'





class Warehouse extends Building



	# isWarehouse

	# stocks



	constructor: (options) ->
		@isWarehouse = true
		options = options or {}
		options.type = 'warehouse'
		super options

		@stocks = new Stocks options.stocks or config.initialStocks
		@_updateMaxima()

		@on 'upgrade.finish', @_updateMaxima
		@on 'downgrade.finish', @_updateMaxima



	_updateMaxima: => @stocks.maxima.reset @config.capacity @level





module.exports = Warehouse
