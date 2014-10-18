# todo: rewrite; use Duration events; make duration changable even if running



{EventEmitter} =	require 'events'

Duration =			require '../util/Duration'





class Timeout extends EventEmitter



	# duration
	# _timeout
	# _remaining
	# _started

	isTimeout: true



	constructor: (duration) ->
		@duration = duration or new Duration() # todo: make changeable
		@_timeout = null
		@_remaining = @_started = 0



	running: () ->
		return !!@_timeout



	_callback: () =>
		@emit 'finish'



	start: () ->
		return if @running()

		@_started = Date.now()
		@_remaining = @duration.milliseconds()
		@_timeout = setTimeout @_callback, @_remaining

		@emit 'start'
		return this


	pause: () ->
		return if not @running()

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
		return if not @running()

		@_started = 0
		@_remaining = 0
		clearTimeout @_callback

		@emit 'stop'
		return this


	finish: () ->
		return if not @running()

		@_started = 0
		@_remaining = 0
		clearTimeout @_callback

		@emit 'finish'
		return this



	progress: () ->
		return 0 if not @running()
		return (@duration.milliseconds() - @_remaining + Date.now() - @_started) / @duration.milliseconds() # todo: correct?


	remaining: () ->
		return 0 if not @running()
		return @duration.clone().multiply 1 - @progress()


	toString: () ->
		return "tmt #{@duration}"





module.exports = Timeout
