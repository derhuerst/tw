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



	constructor: (props = {}) ->
		@isHeadquarter = true
		props.type = 'headquarter'
		super props

		@constructions = new TimeoutQueue()
		@timeFactor = new NumericValue @config.timeFactor @level

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset @config.timeFactor @level
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



	anticipatedLevel: (building) =>
		@constructions.timeouts()
		.filter (construction) -> construction.building is building
		.reduce (level, construction) ->
			if construction.mode is 'upgrade' then result++
			else if construction.mode is 'downgrade' then result--
		, building.level # initial value for `level`





module.exports = Headquarter
