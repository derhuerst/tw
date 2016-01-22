proxyquire =		require('proxyquire').noPreserveCache()
assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

NumericValue =		require '../../src/util/NumericValue'
Building =			require '../../src/core/Building'

configStub = {}
Headquarter =		proxyquire '../../src/buildings/Headquarter',
	'../core/Building':	-> @config = configStub





describe.only 'Headquarter', ->

	beforeEach -> configStub.timeFactor = new NumericValue 1

	headquarter = null
	beforeEach -> headquarter = new Headquarter()


	it.skip '`isHeadquarter`', ->
		assert.strictEqual headquarter.isHeadquarter, true

	it 'should inherit from `Building`', ->
		assert headquarter instanceof Building



	describe 'Resources::constructor', ->

		it.skip 'should set `id` to the given one', ->
			headquarter = new Headquarter id: 'building-1', type: 'custom'
			assert.strictEqual headquarter.id, 'building-1'

		it.skip 'should generate a random `id` as fallback', ->
			assert.strictEqual typeof headquarter.id, 'string'

		it.skip 'should set `config`', ->
			assert.strictEqual headquarter.config, stubbedConfig.custom

		it.skip 'should set `level` to the passed one', ->
			headquarter = new Headquarter type: 'custom', level: 2
			assert.strictEqual 0 + headquarter.level, 2

		it.skip 'should use `initialLevel` as a fallback for the `level`', ->
			stubbedConfig.custom.initialLevel = 3
			headquarter = new Headquarter type: 'custom'
			assert.strictEqual 0 + headquarter.level, stubbedConfig.custom.initialLevel

		it.skip 'should use `1` as a fallback for the `initialLevel`', ->
			stubbedConfig.custom = {}
			headquarter = new Headquarter type: 'custom'
			assert.strictEqual 0 + headquarter.level, 1

		it.skip 'should set `village` to the given one', ->
			v = {}
			headquarter = new Headquarter type: 'custom', village: v
			assert.strictEqual headquarter.village, v



	describe 'Resources::points', ->

		beforeEach -> stubbedConfig.custom.points = -> 0

		beforeEach ->
			headquarter = new Headquarter type: 'custom', level: 2
			headquarter.config.points = sinon.spy headquarter.config, 'points'

		afterEach -> headquarter.config.points.restore()


		it.skip 'should return a `Number`', ->
			assert.strictEqual typeof headquarter.points(), 'number'

		it.skip 'should call `config.points` with the `level`', ->
			headquarter.points()
			assert headquarter.config.points.calledOnce
			assert headquarter.config.points.calledWithExactly headquarter.level



	describe 'Headquarter::toString', ->

		it.skip 'should return a `String`', ->
			assert.strictEqual typeof headquarter.toString(), 'string'
			assert.strictEqual typeof ('' + b), 'string'
