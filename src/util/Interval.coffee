Duration =			require '../util/Duration'





class Interval



	# isInterval

	# callback
	# _duration
	# _interval

	noop: ->



	constructor: (duration = 1000, callback = @noop) ->
		@isInterval = true

		@_duration = if duration.isDuration then duration else new Duration duration
		@_duration.on 'change', @_durationOnChange
		@callback = if 'function' is typeof callback then callback else @noop
		@_interval = null



	duration: -> @_duration

	_durationOnChange: =>
		if @running()
			clearInterval @_interval
			@_interval = setInterval @_callback, @_duration.valueOf()



	start: ->
		unless @running()
			@_interval = setInterval @_callback, @_duration.valueOf()
		return this


	stop: ->
		if @running() then clearInterval @_interval
		return this



	_callback: => @callback()



	running: -> @_interval



	clone: -> new Interval @_duration, @callback

	toString: -> "itv #{@duration}"





module.exports = Interval
