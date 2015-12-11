TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'
GameError =			require '../util/GameError'

Building =			require '../core/Building'
Upgrade =			require '../core/Upgrade'
Downgrade =			require '../core/Downgrade'





class Headquarter extends Building



	# isHeadquarter

	# constructions
	# timeFactor



	constructor: (options) ->
		@isHeadquarter = true
		options = options or {}
		options.type = 'headquarter'
		super options

		@constructions = new TimeoutQueue()
		@timeFactor = new NumericValue options.timeFactor or @config.levels[@level].timeFactor or 1

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset construction.config.timeFactor or 1
		# todo: speed up / slow down queued construction tasks?



	upgrade: (building) ->
		return unless building

		building = if building.isBuilding then @village[building.type] else @village[building]
		unless building
			throw new GameError "There is no #{building.config.title} in this village."

		# todo: check level >= maximumLevel, incorporating all queued up- & downgrades

		upgrade = new Upgrade building
		@constructions.add upgrade

		return upgrade


	downgrade: (building) ->
		return unless building

		building = if building.isBuilding then @village[building.type] else @village[building]
		unless building
			throw new GameError "There is no #{building.config.title} in this village."

		downgrade = new Downgrade building
		@constructions.add downgrade

		return downgrade





module.exports = Headquarter
