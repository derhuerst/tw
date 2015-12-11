Building =			require '../core/Building'





class Workshop extends Building



	# isWorkshop

	# recruitments
	# timeFactor



	constructor: (options) ->
		@isWorkshop = true
		options.type = 'barracks'
		super options

		@recruitments = new TimeoutQueue()
		@timeFactor = new NumericValue options.timeFactor or @config.levels[@level].timeFactor or 1

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset construction.config.timeFactor or 1
		# todo: speed up / slow down queued recruitment tasks?



	recruit: (units) ->
		recruitment = new Recruitment this, units.siegeEngines()
		@recruitments.add recruitment
		return recruitment





module.exports = Workshop
