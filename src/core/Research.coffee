config =			require '../../config/units'
Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





class Research extends Timeout



	# isResearch

	# smithy
	# unit
	# config



	constructor: (smithy, unit) ->
		@isResearch = true
		super()

		if smithy?.isSmithy then @smithy = smithy
		else throw new ReferenceError 'Missing `smithy` argument.'

		if config[unit]?
			@unit = unit
			@config = config[@unit].research
		else throw new ReferenceError 'Missing or invalid `unit` argument.'

		if @config.researched
			throw new GameError "#{config[@unit].title} is already researched."

		@on 'start', @_onStart
		@on 'stop', @_onStop
		@on 'finish', @_onFinish

		return this



	start: ->
		return this if @running()

		if @smithy.researched[@unit]
			throw new GameError "#{config[@unit].title} has already been researched."

		if @smithy.village.warehouse.stocks.resources().moreThan @config.resources
			@smithy.village.warehouse.stocks.resources().subtract @config.resources
		else throw new GameError "Not enough resources to research #{this}."

		unless @smithy.village.requirementsMet @config.requirements
			throw new GameError "The requirements to research #{this} are not met."

		@duration().reset @config.time.clone().multiply @smithy.timeFactor

		return super()



	_onStart: =>
		@smithy.village.emit 'research.start', this

	_onStop: =>
		@smithy.village.warehouse.stocks.resources().add @config.resources
		@smithy.village.emit 'research.stop', this

	_onFinish: =>
		@smithy.researched[@unit] = true
		@smithy.village.emit 'research.finish', this
		@smithy.village.emit 'research', this



	toString: -> "* (#{@config.title})"





module.exports = Research
