Production =		require '../util/Production'

Building =			require '../core/Building'





class ClayPit extends Building



	# isClayPit



	constructor: (options) ->
		@isClayPit = true
		options = options or {}
		options.type = 'clayPit'
		super options

		@on 'upgrade.finish', @onUpgradeFinish
		@on 'downgrade.finish', @onDowngradeFinish

		@village.warehouse.stocks.production.add @totalProduction()



	onUpgradeFinish: (upgrade) =>
		@village.warehouse.stocks.production.add upgrade.config.production


	onDowngradeFinish: (downgrade) =>
		@village.warehouse.stocks.production.subtract downgrade.config.production



	totalProduction: () ->
		result = new Production()
		for level in [0 ... @level]
			result.add @config.levels[level].production
		return result





module.exports = ClayPit
