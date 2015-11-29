config =			require 'config'

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

		@on 'upgrade.finish', @onUpgradeFinish
		@on 'downgrade.finish', @onDowngradeFinish

		@stocks.maxima.add @totalCapacity()



	onUpgradeFinish: (upgrade) =>
		@stocks.maxima.add upgrade.config.capacity


	onDowngradeFinish: (downgrade) =>
		@stocks.maxima.subtract downgrade.config.capacity



	totalCapacity: () ->
		result = 0
		for level in [0 ... @level]
			result += @config.levels[level].capacity
		return result





module.exports = Warehouse
