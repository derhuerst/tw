{EventEmitter} =	require 'events'

Duration =			require '../util/Duration'





class Timeout extends EventEmitter



	# _duration
	# _timeout
	# _remaining
	# _started

	isTimeout: true



	constructor: (duration) ->
		@_duration = duration or new Duration()
		@_duration.on 'change', @_durationOnChange
		@_timeout = null
		@_remaining = @_started = 0



	duration: () -> @_duration

	_durationOnChange: (delta) =>
		hasBeenRunning = @running()
		@pause() if hasBeenRunning
		@_remaining += delta
		@resume() if hasBeenRunning



	_callback: () =>
		@emit 'finish'



	start: () ->
		return if @running()

		@_started = Date.now()
		@_remaining = @_duration.milliseconds()
		@_timeout = setTimeout @_callback, @_remaining

		@emit 'start'
		return this


	pause: () ->
		return unless @running()

		@_remaining -= Date.now() - @_started
		clearTimeout @_callback

		@emit 'pause'
		return this


	resume: () ->
		return if @running()

		@_started = Date.now()
		@_timeout = setTimeout @_callback, @_remaining

		@emit 'resume'
		return this


	stop: () ->
		return unless @running()

		@_started = 0
		@_remaining = 0
		clearTimeout @_callback

		@emit 'stop'
		return this


	finish: () ->
		return unless @running()

		@_started = 0
		@_remaining = 0
		clearTimeout @_callback

		@emit 'finish'
		return this



	progress: () ->
		return 0 unless @running()
		return (@_duration.milliseconds() - @_remaining + Date.now() - @_started) / @_duration.milliseconds() # todo: correct?



	running: () -> !!@_timeout

	remaining: () ->
		return 0 unless @running()
		return @_duration.clone().multiply 1 - @progress()



	toString: () -> "tmt #{@_duration}"





module.exports = Timeout
