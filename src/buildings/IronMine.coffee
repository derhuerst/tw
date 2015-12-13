Production =		require '../util/Production'

Building =			require '../core/Building'





class IronMine extends Building



	# isIronMine



	constructor: (options) ->
		@isIronMine = true
		options = options or {}
		options.type = 'ironMine'
		super options

		@on 'upgrade.finish', @_updateVillageProduction
		@on 'downgrade.finish', @_updateVillageProduction
		@_updateVillageProduction()



	_updateVillageProduction: =>
		# todo: add a helper method to `Resources`
		@village.warehouse.stocks.production.reset new Resources
			wood: @village.warehouse.stocks.production.wood
			clay: @village.warehouse.stocks.production.clay
			iron: @config.production @level





module.exports = IronMine
