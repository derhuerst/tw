# todo: remove this file



{EventEmitter} =	require 'events'





class Points extends EventEmitter



	# points

	isPoints: true



	constructor: (options) ->
		options = options or {}

		@points = options.points or 0



	add: (points) ->
		points = points.points or points or 0
		@points += points
		@emit 'change', points
		return this


	subtract: (points) ->
		points = points.points or points or 0
		@points -= points
		@emit 'change', points
		return this


	multiply: (factor) ->
		previous = @points
		@points *= factor
		@emit 'change', @points - previous
		return this


	round: () ->
		previous = @points
		@points = Math.round @points
		@emit 'change', @points - previous
		return this



	moreThan: (points) ->
		return @points >= points.points



	watchedOnChange: (delta) =>
		@emit 'change', delta


	watch: (points) =>
		points.on 'change', @watchedOnChange

	unwatch: (points) =>
		points.off 'change', @watchedOnChange



	clone: () ->
		return new Points this



	toString: () ->
		return "#{@points}p"





module.exports = Points
