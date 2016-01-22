Production =		require '../util/Production'

Building =			require '../core/Building'





class TimberCamp extends Building



	# isTimberCamp



	constructor: (props = {}) ->
		@isTimberCamp = true
		props.type = 'timberCamp'
		super props

		@on 'upgrade.finish', @_updateVillageProduction
		@on 'downgrade.finish', @_updateVillageProduction

		process.nextTick @_updateVillageProduction()



	_updateVillageProduction: =>
		# todo: add a helper method to `Resources`
		if @village.warehouse?.stocks
			@village.warehouse.stocks.production.reset new Resources
				wood: @config.production @level
				clay: @village.warehouse.stocks.production.clay
				iron: @village.warehouse.stocks.production.iron





module.exports = TimberCamp
