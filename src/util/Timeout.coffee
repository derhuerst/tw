{EventEmitter} =	require 'events'

Duration =			require '../util/Duration'





class Timeout extends EventEmitter



	# isTimeout

	# _duration
	# _timeout
	# _started



	constructor: (duration) ->
		@isTimeout = true

		@_duration = duration or new Duration()
		@_duration.on 'change', @_durationOnChange
		@_timeout = @_started = null



	duration: () -> @_duration

	_durationOnChange: (delta) =>
		now = Date.now()
		return unless @running()
		clearTimeout @_timeout
		setTimeout @_callback, now - @_started



	_callback: => @emit 'finish'



		return if @running()
	start: ->

		@_started = Date.now()
		remaining = @_duration.valueOf()
		@_timeout = setTimeout @_callback, remaining
		@_finished = false

		@emit 'start'
		return this


	stop: ->


		return unless @running()

		clearTimeout @_timeout
		@_timeout = null
		@_started = null

		@emit 'stop'
		return this


		return unless @running()
	finish: ->

		clearTimeout @_timeout
		@_timeout = null
		@_started = null
		@_finished = true

		@emit 'finish'
		return this



	progress: ->
		return 0 unless @running()
		return (@_duration.milliseconds() - @_remaining + Date.now() - @_started) / @_duration.milliseconds() # todo: correct?

	running: -> @_timeout?



	remaining: ->
		return 0 unless @running()
		return @_duration.clone().multiply 1 - @progress()



	toString: -> "tmt #{@_duration}"





module.exports = Timeout
