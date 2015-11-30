GameError =			require '../util/GameError'

Movement =			require '../core/Movement'





class Support extends Movement



	# isSupport



	constructor: ->
		@isSupport = true
		super arguments...



	start: ->
		return if @running()

		# todo?

		return super()



	onStart: ->
		super()
		origin.emit 'outgoing-support', this
		origin.emit 'outgoing-support.start', this
		target.emit 'incoming-support', this
		target.emit 'incoming-support.start', this


	onStop: ->
		super()
		origin.emit 'outgoing-support.stop', this
		target.emit 'incoming-support.stop', this


	onFinish: ->
		super()
		origin.emit 'outgoing-support.finish', this
		target.emit 'incoming-support.finish', this
		# todo: add troops to rally point





module.exports = Support
