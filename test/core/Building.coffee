proxyquire =		require('proxyquire').noPreserveCache()
assert =			require 'assert'
{EventEmitter} =	require 'events'
sinon =				require 'sinon'

Building =			proxyquire '../../src/core/Building',
	'../../config/buildings':	stubbedConfig = {}





describe 'Building', ->

	beforeEach -> stubbedConfig.custom =
		initialLevel: 1

	b = null
	beforeEach -> b = new Building type: 'custom'


	it '`isBuilding`', ->
		assert.strictEqual b.isBuilding, true

	it 'should inherit from `EventEmitter`', ->
		assert b instanceof EventEmitter



	describe 'Resources::constructor', ->

		it 'should set `id` to the given one', ->
			b = new Building id: 'building-1', type: 'custom'
			assert.strictEqual b.id, 'building-1'

		it 'should generate a random `id` as fallback', ->
			assert.strictEqual typeof b.id, 'string'

		it 'should set `config`', ->
			assert.strictEqual b.config, stubbedConfig.custom

		it 'should set `level` to the passed one', ->
			b = new Building type: 'custom', level: 2
			assert.strictEqual 0 + b.level, 2

		it 'should use `initialLevel` as a fallback for the `level`', ->
			stubbedConfig.custom.initialLevel = 3
			b = new Building type: 'custom'
			assert.strictEqual 0 + b.level, stubbedConfig.custom.initialLevel

		it 'should use `1` as a fallback for the `initialLevel`', ->
			stubbedConfig.custom = {}
			b = new Building type: 'custom'
			assert.strictEqual 0 + b.level, 1

		it 'should set `village` to the given one', ->
			v = {}
			b = new Building type: 'custom', village: v
			assert.strictEqual b.village, v



	describe 'Resources::points', ->

		beforeEach -> stubbedConfig.custom.points = -> 0

		beforeEach ->
			b = new Building type: 'custom', level: 2
			b.config.points = sinon.spy b.config, 'points'

		afterEach -> b.config.points.restore()


		it 'should return a `Number`', ->
			assert.strictEqual typeof b.points(), 'number'

		it 'should call `config.points` with the `level`', ->
			b.points()
			assert b.config.points.calledOnce
			assert b.config.points.calledWithExactly b.level



	describe 'Building::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof b.toString(), 'string'
			assert.strictEqual typeof ('' + b), 'string'
