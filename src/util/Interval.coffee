Duration =			require '../util/Duration'





class Interval



	# isInterval

	# callback
	# interval
	# _interval

	noop: ->



	constructor: (interval, callback) ->
		@isInterval = true

		@callback = callback or @noop
		@interval = new Duration interval or 1000
		@interval.on 'change', @intervalOnChange



	intervalOnChange: () =>
		@stop()
		@start()



	start: ->
		@_interval = setInterval @_callback
		return this


	stop: ->
		clearInterval @_callback
		@_callback = null
		return this



	_callback: => @callback()



	clone: -> new Interval this.duration



	toString: -> "itv #{@duration}"





module.exports = Interval
