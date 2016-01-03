assert =			require 'assert'
{EventEmitter} =	require 'events'
sinon =				require 'sinon'

config =			require '../../config'
Building =			require '../../src/core/Building'





describe 'Building', ->

	# todo: mock buildings config

	b = null
	beforeEach -> b = new Building type: 'statue'

	it '`isBuilding`', ->
		assert.strictEqual b.isBuilding, true

	it 'should inherit from `EventEmitter`', ->
		assert b instanceof EventEmitter



	describe 'Resources::constructor', ->

		# todo: mock buildings config

		it 'should set `id` to the given one', ->
			b = new Building id: 'building-1', type: 'statue'
			assert.strictEqual b.id, 'building-1'

		it 'should generate a random `id` as fallback', ->
			assert.strictEqual typeof b.id, 'string'

		it 'should set `config`', ->
			assert.strictEqual b.config, config.buildings['statue']

		it 'should set `level` to the passed one', ->
			b = new Building type: 'statue', level: 2
			assert.strictEqual 0 + b.level, 2

		it 'should use `initialLevel` as a fallback for the `level`', ->
			assert.strictEqual 0 + b.level, config.buildings['statue'].initialLevel

		it.skip 'should use `1` as a fallback for the `initialLevel`', ->
			# todo: mock config first

		it 'should set `village` to the given one', ->
			v = {}
			b = new Building type: 'statue', village: v
			assert.strictEqual b.village, v



	describe 'Resources::points', ->

		beforeEach ->
			b = new Building type: 'statue', level: 2
			b.config.points = sinon.spy b.config, 'points'

		afterEach -> b.config.points.restore()

		it 'should return a `Number`', ->
			assert.strictEqual typeof b.points(), 'number'

		it 'should call `config.points` with the `level`', ->
			b.points()
			assert b.config.points.calledOnce
			assert.strictEqual 0 + b.config.points.firstCall.args[0], 2

		it 'should, after an upgrade, call `config.points` with the `level`', ->
			b.points()
			assert b.config.points.calledOnce
			assert.strictEqual 0 + b.config.points.firstCall.args[0], 2

			b.level++
			b.points()
			assert b.config.points.calledTwice
			assert.strictEqual 0 + b.config.points.secondCall.args[0], 3



	describe 'Building::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof b.toString(), 'string'
			assert.strictEqual typeof ('' + b), 'string'
