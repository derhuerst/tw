{EventEmitter} =	require 'events'
shortid =			require 'shortid'

config =			require '../../config'
helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
Vector =			require '../util/Vector'
NumericValue =		require '../util/NumericValue'

Headquarter =		require '../buildings/Headquarter'
Wall =				require '../buildings/Wall'

Barracks =			require '../buildings/Barracks'
Workshop =			require '../buildings/Workshop'
Stable =			require '../buildings/Stable'
Academy =			require '../buildings/Academy'
Smithy =			require '../buildings/Smithy'

RallyPoint =		require '../buildings/RallyPoint'
Statue =			require '../buildings/Statue'
Market =			require '../buildings/Market'

TimberCamp =		require '../buildings/TimberCamp'
ClayPit =			require '../buildings/ClayPit'
IronMine =			require '../buildings/IronMine'
Farm =				require '../buildings/Farm'

Warehouse =			require '../buildings/Warehouse'
Stash =				require '../buildings/Stash'





buildings =
	headquarter:	Headquarter
	wall:			Wall

	barracks:		Barracks
	workshop:		Workshop
	stable:			Stable
	academy:		Academy
	smithy:			Smithy

	rallyPoint:		RallyPoint
	statue:			Statue
	market:			Market

	timberCamp:		TimberCamp
	clayPit:		ClayPit
	ironMine:		IronMine
	farm:			Farm

	warehouse:		Warehouse
	stash:			Stash



class Village extends EventEmitter



	# isVillage

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
	# smithy
	# rallyPoint
	# statue
	# market
	# timberCamp
	# clayPit
	# ironMine
	# farm
	# warehouse
	# stash



	constructor: (options) ->
		@isVillage = true
		options = options or {}

		@id = options.id or shortid.generate()
		@name = options.name or @id
		@position = options.position or new Vector()

		@points = new NumericValue()
		@_recomputePoints()
		options.loyalty ?= config.initialLoyalty or 1
		@loyalty = new NumericValue options.loyalty, 'l'

		for type, traits of config.buildings
			given = options[type]
			if given?.isBuilding and given.type is type
				@addBuilding given
			else if traits.initialLevel > 0
				@addBuilding new buildings[type] village: this



	addBuilding: (building) ->
		return this unless building and building.isBuilding

		if @[building.type]
			throw new GameError "There already is a #{building.config.title} in the village."

		@[building.type] = building
		building.village = this

		building.on 'upgrade', @_buildingOnConstruction
		building.on 'downgrade', @_buildingOnConstruction
		@_recomputePoints()

		@emit 'add-building', building
		return this

	deleteBuilding: (building) ->
		return this unless building and building.isBuilding

		unless @[building.type] is building
			throw new GameError "This #{building.config.title} is not part of this village."

		@[building.type] = null
		building.village = null

		building.removeListener 'upgrade', @_buildingOnConstruction
		building.removeListener 'downgrade', @_buildingOnConstruction
		@_recomputePoints()

		@emit 'delete-building', building
		return this



	_recomputePoints: () ->
		result = 0
		for type, traits of config.buildings
			result += @[type]?.points() or 0
		@points.reset result

	_buildingOnConstruction: (construction) =>
		@emit "#{construction.mode}-building", construction
		@_recomputePoints()



	toString: -> "vlg #{@position} #{@points} ##{@id}"





module.exports = Village
