assert =		require 'assert'

GameError =		require '../../src/util/GameError'





describe 'GameError', ->

	myGameError = null
	beforeEach -> myGameError = new GameError 'test message'



	it '`isGameError`', ->
		assert.strictEqual myGameError.isGameError, true

	it 'should inherit from `Error`', ->
		assert myGameError instanceof Error
