Production =		require '../util/Production'

Building =			require '../core/Building'





class ClayPit extends Building



	# isClayPit



	constructor: (props = {}) ->
		@isClayPit = true
		props.type = 'clayPit'
		super props

		@on 'upgrade.finish', @_updateVillageProduction
		@on 'downgrade.finish', @_updateVillageProduction
		@_updateVillageProduction()



	_updateVillageProduction: =>
		# todo: add a helper method to `Resources`
		if @village.warehouse?.stocks
			@village.warehouse.stocks.production.reset new Resources
				wood: @village.warehouse.stocks.production.wood
				clay: @config.production @level
				iron: @village.warehouse.stocks.production.iron





module.exports = ClayPit
