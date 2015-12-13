Production =		require '../util/Production'

Building =			require '../core/Building'





class ClayPit extends Building



	# isClayPit



	constructor: (options) ->
		@isClayPit = true
		options = options or {}
		options.type = 'clayPit'
		super options

		@on 'upgrade.finish', @_updateVillageProduction
		@on 'downgrade.finish', @_updateVillageProduction
		@_updateVillageProduction()



	_updateVillageProduction: =>
		# todo: add a helper method to `Resources`
		@village.warehouse.stocks.production.reset new Resources
			wood: @village.warehouse.stocks.production.wood
			clay: @config.production @level
			iron: @village.warehouse.stocks.production.iron





module.exports = ClayPit
