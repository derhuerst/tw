{EventEmitter} =	require 'events'
config =			require 'config'
shortid =			require 'shortid'

helpers =			require '../util/helpers'
GameError =			require '../util/GameError'

Vector =			require '../util/Vector'
NumericValue =		require '../util/NumericValue'

Headquarter =		require '../buildings/Headquarter'
RallyPoint =		require '../buildings/RallyPoint'
Farm =				require '../buildings/Farm'
Warehouse =			require '../buildings/Warehouse'
TimberCamp =		require '../buildings/TimberCamp'
ClayPit =			require '../buildings/ClayPit'
IronMine =			require '../buildings/IronMine'





class Village extends EventEmitter



	# id
	# name
	# position

	# points
	# loyalty

	# headquarter
	# wall
	# barracks
	# workshop
	# stable
	# academy
	# workshop
	# rallyPoint
	# market
	# timberCamp
	# clayPit
	# ironMine
	# farm
	# warehouse
	# stash

	isVillage: true



	constructor: (options) ->
		options = options or {}

		@id = options.id or shortid.generate()
		@name = options.name or @id
		@position = options.position or new Vector()

		@points = new NumericValue (options.points or config.initialPoints or 0), 'p'
		@loyalty = new NumericValue (options.loyalty or config.initialLoyalty or 100), 'l'

		@add options.warehouse or new Warehouse
			village: this
		@add options.farm or new Farm
			village: this
		@add options.headquarter or new Headquarter
			village: this
		@add options.rallyPoint or new RallyPoint
			village: this
		@add options.timberCamp or new TimberCamp
			village: this
		@add options.clayPit or new ClayPit
			village: this
		@add options.ironMine or new IronMine
			village: this



	add: (building) ->
		return if not building

		if @[building.type]
			throw new GameError "A #{building.config.title} does already exist in this village."

		@[building.type] = building

		building.on 'upgrade', @buildingOnConstruction
		building.on 'downgrade', @buildingOnConstruction

		@points.watch building.points
		@points.add building.points

		@emit 'buildings.add', building


	remove: (building) ->
		return if not building

		building = if building.isBuilding then @[building.type] else @[building]
		if not building
			throw new GameError "There is no #{building.config.title} in this village."

		@[building.type] = null

		building.off 'upgrade', @buildingOnConstruction
		building.off 'downgrade', @buildingOnConstruction

		@points.unwatch building.points
		@points.subtract building.points

		@emit 'buildings.remove', building



	buildingOnConstruction: (construction) ->
		@emit "buildings.#{construction.mode}", construction



	anticipatedLevel: (building) =>
		result = building.level
		for construction in @headquarter.constructions.timeouts
			if construction.mode is 'upgrade'
				result++
			else if construction.mode is 'downgrade'
				result--
		return result



	toString: () -> "vlg #{@position} #{@points} ##{@id}"





module.exports = Village
