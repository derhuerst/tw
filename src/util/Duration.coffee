NumericValue =		require '../util/NumericValue'





class Duration extends NumericValue



	isDuration: true

	units:
		d: 1000 * 60 * 60 * 24
		h: 1000 * 60 * 60
		m: 1000 * 60
		s: 1000
		ms: 1



	constructor: (duration) ->
		@value = 0
		switch typeof duration
			when 'number'
				@value = duration
			when 'string'
				@value = @parse duration
			else
				if duration and duration.isDuration
					@value = duration.clone()
				else
					@value = parseFloat duration
		if isNaN @value
			@value = 0



	milliseconds: () ->
		return @value

	seconds: () ->
		return Math.floor @value / @units.s

	minutes: () ->
		return Math.floor @value / @units.m

	hours: () ->
		return Math.floor @value / @units.h

	days: () ->
		return Math.floor @value / @units.d



	clone: () ->
		return new Duration @value



	parse: (string) ->
		return 0 if string is '0' or string is '-0'

		duration = 0
		regex = /(\-?[\d.]+)(ms|s|m|h|d)/g
		sign = 1
		if string.charAt(0) is '-'
			sign = -1
			string = string.slice 1

		while match = regex.exec string
			value = parseFloat match[1]
			if isNaN value
				throw new Error 'invalid duration'
			duration += value * @units[match[2]]

		return sign * duration


	toString: () ->
		return '0' if @value is 0

		string = ''
		if @value < 0
			string += '-'
		duration = Math.abs @value

		for abbreviation, factor of @units
			part = Math.floor duration / factor
			continue if part is 0
			duration -= part * factor
			string += part + abbreviation

		return string



	valueOf: () ->
		return @value





module.exports = Duration
