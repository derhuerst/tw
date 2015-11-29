NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Farm extends Building



	# isFarm

	# workers



	constructor: (options) ->
		@isFarm = true
		options = options or {}
		options.type = 'farm'
		super options

		@workers = new NumericValue options.workers or @config.initialWorkers or 0

		@on 'upgrade.finish', @onUpgradeFinish
		@on 'downgrade.finish', @onDowngradeFinish

		@workers.add @totalCapacity()



	onUpgradeFinish: (upgrade) =>
		@workers.add upgrade.config.capacity


	onDowngradeFinish: (downgrade) =>
		@workers.subtract downgrade.config.capacity



	totalCapacity: () ->
		result = 0
		for level in [0 ... @level]
			result += @config.levels[level].capacity
		return result





module.exports = Farm
