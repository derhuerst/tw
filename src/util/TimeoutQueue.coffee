{EventEmitter} =	require 'events'

_ =					require './helpers'





class TimeoutQueue extends EventEmitter



	# isTimeoutQueue

	# _timeouts



	constructor: ->
		@isTimeoutQueue = true
		super()

		@_timeouts = []



	_removePreviousTimeout: =>
		timeout = @_timeouts.shift()
		@emit 'progress', timeout
		@_next()

	_next: ->
		if @_timeouts.length is 0
			@emit 'finish'
			return this

		timeout = @_timeouts[0]
		timeout.once 'finish', @_removePreviousTimeout
		timeout.once 'stop', @_removePreviousTimeout
		timeout.start()



	add: (timeout) ->
		return this unless timeout?.isTimeout
		return this if timeout.running()

		@_timeouts.add timeout
		if @_timeouts.length is 1 # was empty before
			@_next()
			@emit 'start'

		@emit 'add', timeout
		return this


	remove: (timeout) ->
		return this unless timeout?.isTimeout
		i = @_timeouts.indexOf timeout
		return this if i is -1

		if i is 0 then @_removePreviousTimeout
		else @_timeouts.remove timeout

		@emit 'remove', timeout
		return this





module.exports = TimeoutQueue
