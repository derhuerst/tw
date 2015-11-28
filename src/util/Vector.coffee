class Vector



	# x
	# y

	isVector: true



	constructor: (x, y) ->
		@x = x or 0
		@y = y or 0



	reset: () ->
		@x = 0
		@y = 0
		return this


	add: (summand) ->
		if summand.isVector
			@x += summand.x
			@y += summand.y
		else
			@x += summand
			@y += summand
		return this


	subtract: (subtrahend) ->
		if subtrahend.isVector
			@x -= subtrahend.x
			@y -= subtrahend.y
		else
			@x -= subtrahend
			@y -= subtrahend
		return this


	multiply: (factor) ->
		if factor.isVector
			@x *= factor.x
			@y *= factor.y
		else
			@x *= factor
			@y *= factor
		return this


	round: () ->
		@x = Math.round @x
		@y = Math.round @y
		return this



	distanceTo: (vector) -> vector.clone().subtract this



	clone: () -> new Vector @x, @y



	valueOf: () -> Math.sqrt Math.pow(2, @x) + Math.pow(2, @y)

	toString: () -> "#{@x}|#{@y}"





module.exports = Vector
