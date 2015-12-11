# todo: remove abstraction?
{EventEmitter} =	require 'events'

Vector =			require '../util/Vector'
Duration =			require '../util/Duration'





class Speed extends EventEmitter



	# duration
	# distance

	isSpeed: true



	constructor: (duration, distance) ->
		if duration and duration.isDuration then @duration = duration
		else @duration = new Duration '1m'
		if distance and distance.isVector then @distance = distance
		else @distance = new Vector 1, 0



	distanceDuring: (duration) ->
		return @distance.clone().multiply duration / @duration


	durationToTravel: (distance) ->
		return @duration.clone().multiply distance / @distance



	clone: -> new Speed @duration, @distance



	valueOf: -> 0 + @distanceDuring new Duration '5m'

	toString: -> "#{@distance} / #{@duration}"





module.exports = Speed
