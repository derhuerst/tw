{EventEmitter} =	require 'events'
shortid =			require 'shortid'

helpers =			require '../util/helpers'

NumericValue =		require '../util/NumericValue'





class Player extends EventEmitter



	# id
	# name

	# points
	# villages

	isPlayer: true



	constructor: (options) ->
		options = options or {}

		@id = options.id or shortid.generate()
		@name = options.name or @id

		@points = new NumericValue (options.points or 0), 'p'
		@villages = []
		for village in options.villages or []
			@add village



	add: (village) ->
		if @villages[village.id]
			throw new GameError "#{village} does already belong to this player."

		@villages.add village
		@villages[village.id] = village
		@points.add village.points
		@points.watch village.points

		@emit 'villages.add', village


	remove: (village) ->
		unless @villages[village.id]
			throw new GameError "#{village} does not belong to this player."

		@villages[village.id] = null
		@villages.remove village
		@points.subtract village.points
		@points.unwatch village.points

		@emit 'villages.remove', village



	toString: () -> "plyr #{@name} #{@id}"





module.exports = Player
