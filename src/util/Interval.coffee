Duration =			require '../util/Duration'





class Interval



	# callback
	# interval
	# _interval

	isInterval: true

	noop: ()->



	constructor: (callback, interval) ->
		@callback = callback or @noop
		@interval = new Duration interval or 1000
		@interval.on 'change', @intervalOnChange



	intervalOnChange: () =>
		@stop()
		@start()



	start: () ->
		@_interval = setInterval @_callback
		return this


	stop: () ->
		clearInterval @_callback
		@_callback = null
		return this



	_callback: () =>
		@callback()



	clone: () ->
		return new Interval this.interval



	toString: () ->
		return "itv #{@interval}"





module.exports = Interval