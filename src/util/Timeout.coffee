EventEmitter = require('events').EventEmitter
require './Duration'
container = require '../container'

module.exports = container.publish 'util.Timeout', [
	'util.Duration'
], (Duration) ->





	class Timeout extends EventEmitter



		# isTimeout

		# _duration
		# _timeout
		# _started



		constructor: (duration = 0) ->
			@isTimeout = true

			duration = new Duration duration unless duration.isDuration
			@_duration = duration
			@_duration.on 'change', @_durationOnChange
			@_timeout = @_started = null

			return this



		duration: -> @_duration

		_durationOnChange: (delta) =>
			now = Date.now()
			return unless @running()
			clearTimeout @_timeout
			setTimeout @_callback, now - @_started



		_callback: =>
			@_timeout = null
			@_started = null
			@_finished = true
			@emit 'finish'



		start: ->
			return this if @running()

			@_started = Date.now()
			remaining = @_duration.valueOf()
			@_timeout = setTimeout @_callback, remaining
			@_finished = false

			@emit 'start'
			return this


		stop: ->
			return this unless @running()

			clearTimeout @_timeout
			@_timeout = null
			@_started = null

			@emit 'stop'
			return this


		finish: ->
			return this unless @running()

			clearTimeout @_timeout
			@_timeout = null
			@_started = null
			@_finished = true

			@emit 'finish'
			return this



		progress: ->
			now = Date.now()
			return 1 if @_finished
			return 0 unless @running()
			return (now - @_started) / @_duration # todo: correct?

		running: -> @_timeout?

		remaining: ->
			return 0 unless @running()
			return @_duration.clone().multiply 1 - @progress()



		clone: -> new Timeout @_duration



		toString: -> "tmt #{@_duration}"

		valueOf: -> @_duration.valueOf()
