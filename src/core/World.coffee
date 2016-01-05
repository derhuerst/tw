{EventEmitter} =	require 'events'
shortid =			require 'shortid'
random =			require 'lodash/number/random'

config =			require '../../config'
helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
Vector =			require '../util/Vector'
Village =			require '../core/Village'
Player =			require '../core/Player'





class World extends EventEmitter



	# isGame

	# _players

	# _villages
	# _map



	constructor: (props = {}) ->
		@isWorld = true
		super()

		@_players = {}

		@_villages = []
		if props.mapSize then mapSize = props.mapSize
		else mapSize = config.map.size or 1000
		@_map = size: mapSize



	addVillage: (village) =>
		return this unless village and village.isVillage

		if @_villages[village.id]
			throw new GameError 'The village has already been added.'
		if @_map["#{village.position.x}-#{village.position.y}"]
			throw new GameError 'The location is occupied by another village.'

		@_villages.push village
		@_villages[village.id] = village
		@_map["#{village.position.x}-#{village.position.y}"] = village

		@emit 'add-village', village
		return this

	getVillage: (x, y) ->
		return @_villages[x] or null if typeof x is 'string'
		return @_map["#{x.x}-#{x.y}"] or null if x and x.isVector
		return @_map["#{x}-#{y}"] or null

	deleteVillage: (village) ->
		return this unless village and village.isVillage

		unless @_villages[village.id]
			throw new GameError 'The village does not exist.'

		@_villages.remove village
		@_villages[village.id] = null
		@_map["#{village.position.x}-#{village.position.y}"] = null

		@emit 'delete-village', village
		return this



	getPlayer: (id) -> @_players[id] or null

	addPlayer: (player) ->
		return this unless player and player.isPlayer

		if @_players[player.id]
			throw new GameError "#{player} already is in this world."

		@_players[player.id] = player

		@addVillage village for village in player.villages()
		player.on 'add-village', @addVillage

		@emit 'add-player', player
		return this

	deletePlayer: (player) ->
		return this unless player and player.isPlayer

		unless @_players[player.id]
			throw new GameError "#{player} does not exist in the world."

		@_players[player.id] = null

		@deleteVillage village for village in player.villages()
		player.removeListener 'add-village', @addVillage

		@emit 'delete-player', player
		return this



	_createPosition: (direction) ->
		angle = Math.PI / 2 * switch direction
			when 'north-west' then	Math.random() - 2
			when 'south-west' then	Math.random() - 1
			when 'south-east' then	Math.random() + 0
			when 'north-east' then	Math.random() + 1
			else					Math.random() * 4
		r = Math.sqrt config.map.spread * @_villages.length / Math.PI
		x = Math.round @_map.size / 2 + r * Math.sin angle
		y = Math.round @_map.size / 2 + r * Math.cos angle
		return {x, y}

	createVillage: (direction) ->
		# random id
		id = shortid.generate()
		id = shortid.generate() while @_villages[id]

		pos = @_createPosition direction
		while @_map["#{pos.x}-#{pos.y}"]?
			pos = @_createPosition direction

		return new Village {id, position: new Vector pos.x, pos.y}

	createPlayer: ->
		id = shortid.generate()
		id = shortid.generate() while @_players[id]
		return new Player {id}





module.exports = World
