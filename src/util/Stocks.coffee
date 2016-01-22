require './helpers'
require './Resources'
require './Production'
container = require '../container'

module.exports = container.publish 'util.Stocks', [
	'util.Resources', 'util.Production'
], (Resources, Production) ->





	class Stocks



		# isStocks

		# maxima

		# production

		# _resources
		# _updated



		constructor: (props = {}) ->
			@isStocks = true

			if props.maxima?.isResources then @maxima = props.maxima.clone()
			else @maxima = new Resources props.maxima
			@maxima.on 'change', @_maximaOnChange

			if props.production?.isProduction then @production = props.production.clone()
			else @production = new Production new Resources()
			@production.on 'change', @_update

			@_resources = new Resources()
			@_updated = Date.now()

			return this



		_maximaOnChange: =>
			if @_resources.wood > @maxima.wood then @_resources.wood = @maxima.wood
			if @_resources.clay > @maxima.clay then @_resources.clay = @maxima.clay
			if @_resources.iron > @maxima.iron then @_resources.iron = @maxima.iron

		_update: (production = @production) =>
			now = Date.now()
			@_resources.add production.resourcesDuring now - @_updated
			@_updated = now
			@_maximaOnChange()



		resources: -> @_update(); @_resources



		toString: ->
			resources = @resources()
			return [
				Math.round(resources.wood), '/', Math.round(@maxima.wood), 'w|'
				Math.round(resources.clay), '/', Math.round(@maxima.clay), 'c|'
				Math.round(resources.iron), '/', Math.round(@maxima.iron), 'i|'
				'<-', @production
			].join ''
