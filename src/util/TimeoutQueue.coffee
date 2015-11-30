{EventEmitter} =	require 'events'

_ =					require './helpers'





class TimeoutQueue extends EventEmitter



	# isTimeoutQueue

	# _timeouts



	constructor: ->
		@isTimeoutQueue = true
		super()

		@_timeouts = []



	_removeOldTimeout: =>
		timeout = @_timeouts.shift()
		timeout.removeListener 'finish', @_removeOldTimeout
		timeout.removeListener 'stop', @_removeOldTimeout
		@emit 'progress', timeout
		@_next()

	_next: ->
		if @_timeouts.length is 0
			@emit 'finish'
			return this
		timeout = @_timeouts[0]

		timeout.once 'finish', @_removeOldTimeout
		timeout.once 'stop', @_removeOldTimeout
		timeout.start()



	add: (timeout) ->
		return this unless timeout and timeout.isTimeout

		@_timeouts.add timeout
		if @_timeouts.length is 1 # was empty before
			@_next()
			@emit 'start'

		@emit 'add', timeout
		return this


	remove: (timeout) ->
		i = @_timeouts.indexOf timeout
		return this if i is -1

		if i is 0 then @_removeOldTimeout
		else @_timeouts.remove timeout

		@emit 'remove', timeout
		return this





module.exports = TimeoutQueue
