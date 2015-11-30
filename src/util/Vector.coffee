class Vector



	# isVector

	# x
	# y



	constructor: (x, y) ->
		@isVector = true

		@x = x or 0
		@y = y or 0



	reset: () ->
		@x = 0
		@y = 0
		return this


	add: (summand = 0) ->
		if summand.isVector
			@x += summand.x
			@y += summand.y
		else
			@x += summand
			@y += summand
		return this


	subtract: (subtrahend = 0) ->
		if subtrahend.isVector
			@x -= subtrahend.x
			@y -= subtrahend.y
		else
			@x -= subtrahend
			@y -= subtrahend
		return this


	multiply: (factor = 1) ->
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



	vectorTo: (target) ->
		return new Vector 0, 0 unless target and target.isVector
		target.clone().subtract this

	distanceTo: (target) -> @vectorTo(target).valueOf()



	clone: () -> new Vector @x, @y



	valueOf: () -> Math.sqrt Math.pow(@x, 2) + Math.pow(@y, 2)

	toString: () -> "#{@x}|#{@y}"





module.exports = Vector
