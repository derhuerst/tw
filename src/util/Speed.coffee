# todo: remove abstraction?
{EventEmitter} =	require 'events'

Vector =			require '../util/Vector'
Duration =			require '../util/Duration'





class Speed extends EventEmitter



	# duration
	# distance

	isSpeed: true



	constructor: (duration, distance) ->
		@duration = duration or new Duration '1m'
		@distance = distance or new Vector 1, 0



	distanceDuring: (duration) ->
		return @distance.clone().multiply duration / @duration


	durationToTravel: (distance) ->
		return @duration.clone().multiply distance / @distance



	clone: () -> new Speed this



	valueOf: () -> 0 + @durationToTravel new Vector 1, 0

	toString: () -> "#{@distance} / #{@duration}"





module.exports = Speed
