# We use the classical JavaScript inheritance pattern for greater flexibility here.
# See http://stackoverflow.com/a/5251506

GameError = (message = '') ->
	@isGameError = true

	# mimic the `Error` class
	@name = 'GameError'
	@message = message
	@stack = new Error().stack

	return this

GameError.prototype = new Error()





module.exports = GameError
