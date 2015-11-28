Resources =			require '../util/Resources'
Production =		require '../util/Production'





class Stocks extends Resources



	# maxima

	# production
	# updated

	isStocks: true



	constructor: (options) ->
		options = options or {}
		super options

		@maxima = new Resources options.maxima
		@maxima.on 'change', @maximaOnChange

		@production = options.production or new Production()
		@production.on 'pre-change', @update
		@updated = Date.now()

		@on 'change', @limitToMaxima



	limitToMaxima: () ->
		if @wood > @maxima.wood
			@wood = @maxima.wood
		else if @clay > @maxima.clay
			@clay = @maxima.clay
		else if @iron > @maxima.iron
			@iron = @maxima.iron


	maximaOnChange: () =>
		@emit 'change'



	update: () =>
		@add @production.resourcesDuring Date.now() - @updated
		@updated = Date.now()
		return this



	clone: () -> new Stocks this



	toString: () ->
		@update()
		return "#{Math.round @wood}/#{@maxima.wood}w|#{Math.round @clay}/#{@maxima.clay}c|#{Math.round @iron}/#{@maxima.iron}i <- #{@production}"





module.exports = Stocks
