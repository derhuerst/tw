{EventEmitter} =	require 'events'
shortid =			require 'shortid'

helpers =			require '../util/helpers'
NumericValue =		require '../util/NumericValue'
GameError =			require '../util/GameError'





class Player extends EventEmitter



	# isPlayer

	# id
	# name

	# points
	# _villages



	constructor: (props = {}) ->
		@isPlayer = true
		super()

		@id = props.id or shortid.generate()
		@name = props.name or @id

		@points = new NumericValue (props.points or 0), 'p'
		@_villages = []
		if props.villages
			@addVillage village for village in props.villages

		return this



	addVillage: (village) ->
		return this unless village and village.isVillage

		if @_villages[village.id]
			throw new GameError 'The village has already been added.'

		@_villages.push village
		@_villages[village.id] = village
		@points.add village.points
		@points.watch village.points

		@emit 'add-village', village
		return this

	getVillage: (id) -> @_villages[id] or null
	villages: -> @_villages

	deleteVillage: (village) ->
		return this unless village and village.isVillage

		unless @_villages[village.id]
			throw new GameError 'The village does not belong to this player.'

		@_villages[village.id] = null
		@_villages.remove village
		@points.subtract village.points
		@points.unwatch village.points

		@emit 'delete-village', village
		return this



	toString: -> "plyr #{@name} #{@id}"





module.exports = Player
