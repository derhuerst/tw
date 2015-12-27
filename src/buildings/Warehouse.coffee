config =			require '../../config'
Stocks =			require '../util/Stocks'
Building =			require '../core/Building'





class Warehouse extends Building



	# isWarehouse

	# stocks



	constructor: (props = {}) ->
		@isWarehouse = true
		props.type = 'warehouse'
		super props

		@stocks = new Stocks props.stocks or config.initialStocks
		@_updateMaxima()

		@on 'upgrade.finish', @_updateMaxima
		@on 'downgrade.finish', @_updateMaxima



	_updateMaxima: => @stocks.maxima.reset @config.capacity @level





module.exports = Warehouse
