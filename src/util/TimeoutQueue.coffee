{EventEmitter} =	require 'events'





class TimeoutQueue extends EventEmitter



	# timeouts
	# current

	isTimeoutQueue: true



	constructor: () ->
		super()

		@timeouts = []

		_this = this
		@timeoutOnFinish = () ->
			_this.remove this
			_this.emit 'progress', this
			if _this.timeouts.length > 0
				_this.next()
			else _this.emit 'finish'



	next: () =>
		timeout = @timeouts[0]
		timeout.once 'finish', @timeoutOnFinish
		timeout.once 'stop', @timeoutOnFinish
		timeout.start()



	add: (timeout) ->
		@timeouts.add timeout
		@emit 'add', timeout
		if @timeouts.length is 1
			@next()


	remove: (timeout) ->
		@timeouts.remove timeout
		@emit 'remove', timeout





module.exports = TimeoutQueue
