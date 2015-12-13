Production =		require '../util/Production'

Building =			require '../core/Building'





class TimberCamp extends Building



	# isTimberCamp



	constructor: (options) ->
		@isTimberCamp = true
		options = options or {}
		options.type = 'timberCamp'
		super options

		@on 'upgrade.finish', @_updateVillageProduction
		@on 'downgrade.finish', @_updateVillageProduction
		@_updateVillageProduction()



	_updateVillageProduction: =>
		# todo: add a helper method to `Resources`
		@village.warehouse.stocks.production.reset new Resources
			wood: @config.production @level
			clay: @village.warehouse.stocks.production.clay
			iron: @village.warehouse.stocks.production.iron





module.exports = TimberCamp
