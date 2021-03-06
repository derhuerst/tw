{EventEmitter} =	require 'events'
shortid =			require 'shortid'

config =			require '../../config'
helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
Vector =			require '../util/Vector'
NumericValue =		require '../util/NumericValue'
Loyalty =			require '../util/Loyalty'

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



	constructor: (props = {}) ->
		@isVillage = true

		@id = props.id or shortid.generate()
		@name = props.name or @id
		@position = props.position or new Vector()

		@points = new NumericValue()
		@_recomputePoints()
		@loyalty = new Loyalty props.loyalty ? config.initialLoyalty ? 100

		for type, traits of config.buildings
			given = props[type]
			if given?.isBuilding and given.type is type
				@addBuilding given
			else if traits.initialLevel > 0
				@addBuilding new buildings[type] village: this

		return this



	addBuilding: (building) ->
		return this unless building and building.isBuilding

		if @[building.type]
			throw new GameError "There already is a #{building.config.title} in the village."

		# todo: check if `requirements` are met

		@[building.type] = building
		building.village = this

		building.level.on 'change', @_buildingLevelOnChange
		@_recomputePoints()

		@emit 'add-building', building
		return this

	deleteBuilding: (building) ->
		return this unless building and building.isBuilding

		unless @[building.type] is building
			throw new GameError "This #{building.config.title} is not part of this village."

		@[building.type] = null
		building.village = null

		building.level.removeListener 'change', @_buildingLevelOnChange
		@_recomputePoints()

		@emit 'delete-building', building
		return this



	requirementsMet: (requirements = {}) ->
		for building, level of requirements
			return false unless @[building]?.level >= level
		return true



	_recomputePoints: ->
		result = 0
		for type, traits of config.buildings
			result += @[type]?.points() or 0
		@points.reset result

	_buildingLevelOnChange: => @_recomputePoints()



	toString: -> "vlg #{@position.toString()} #{@points} ##{@id}"





module.exports = Village
