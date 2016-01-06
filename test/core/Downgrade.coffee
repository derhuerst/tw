proxyquire =		require('proxyquire').noPreserveCache()
assert =			require 'assert'
sinon =				require 'sinon'

Downgrade =			require '../../src/core/Downgrade'
Village =			require '../../src/core/Village'
Timeout =			require '../../src/util/Timeout'
GameError =			require '../../src/util/GameError'
{equalResources} =	require '../../test/helpers'

Village =			proxyquire '../../src/core/Village',
	'../../config/buildings':	stubbedConfig = {}





describe 'Downgrade', ->

	village = null
	building = null
	downgrade = null

	beforeEach ->
		village = new Village()
		village.headquarter.level.reset 15
		building = village.headquarter
		building.level.add 1
		building.village.warehouse.stocks.resources().reset 1000
		downgrade = new Downgrade building


	it '`isDowngrade`', ->
		assert.strictEqual downgrade.isDowngrade, true

	it 'should inherit from `Timeout`', ->
		assert downgrade instanceof Timeout



	describe 'Downgrade::constructor', ->

		it 'should throw a `ReferenceError` if `building` has not been passed', ->
			createWithoutBuilding = -> downgrade = new Downgrade()
			assert.throws createWithoutBuilding, ReferenceError

		it 'should set `building` to the passed one', ->
			assert.strictEqual downgrade.building, building



	describe 'Downgrade::start', ->

		start = null
		beforeEach -> start = -> downgrade.start()


		it 'should throw a `GameError` if the building has been downgraded in the mean time', ->
			assert.doesNotThrow start, GameError
			downgrade.stop()

			downgrade = new Downgrade building
			building.level.add 1
			assert.throws start, GameError

		it 'should throw a `GameError` if the building is at minimum level', ->
			assert.doesNotThrow start, GameError
			downgrade.stop()

			downgrade = new Downgrade building
			building.level.reset building.config.minimalLevel
			assert.throws start, GameError

		it 'should throw a `GameError` if the headquarter\'s level is below `15`', ->
			assert.doesNotThrow start, GameError
			downgrade.stop()

			downgrade = new Downgrade building
			building.village.headquarter.level.reset 14
			assert.throws start, GameError

		it 'should throw a `GameError` if the village\'s loyalty is below `100`', ->
			assert.doesNotThrow start, GameError
			downgrade.stop()

			downgrade = new Downgrade building
			building.village.loyalty.reset 99
			assert.throws start, GameError

		it 'should emit `start`', ->
			onStart = sinon.spy()
			downgrade.on 'start', onStart
			start()
			assert onStart.calledOnce



	describe 'Downgrade::stop', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should do nothing if not `running`', ->
			downgrade.on 'stop', spy
			downgrade.stop()
			assert.strictEqual spy.callCount, 0

		it 'should emit `stop`', ->
			downgrade.on 'stop', spy
			downgrade.start()
			downgrade.stop()
			assert spy.calledOnce



	it 'should decrement the `building`\'s `level` when `finish`ed', ->
		expected = building.level - 1
		downgrade.start()
		downgrade.finish()
		assert.strictEqual 0 + building.level, expected

	it 'should refund to the `village`\'s `resources` when `stop`ed', ->
		before = village.warehouse.stocks.resources().clone()
		downgrade.start()
		downgrade.stop()
		assert equalResources village.warehouse.stocks.resources(), before

	it 'should refund to the `village`\'s `workers` when `stop`ed', ->
		before = 0 + village.farm.workers
		downgrade.start()
		downgrade.stop()
		assert.strictEqual 0 + village.farm.workers, before



	describe 'event handling on `building`', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should emit `downgrade.start` when `start`ed', ->
			building.on 'downgrade.start', spy
			downgrade.start()
			assert spy.calledOnce
			assert spy.calledWithExactly downgrade

		it 'should emit `downgrade.stop` when `stop`ed', ->
			building.on 'downgrade.stop', spy
			downgrade.start()

			downgrade.stop()
			assert spy.calledOnce
			assert spy.calledWithExactly downgrade

		it 'should emit `downgrade.finish` and `downgrade` when `finish`ed', ->
			building.on 'downgrade.finish', spy
			spy2 = sinon.spy()
			building.on 'downgrade', spy2
			downgrade.start()

			downgrade.finish()
			assert spy.calledOnce
			assert spy.calledWithExactly downgrade
			assert spy2.calledOnce
			assert spy2.calledWithExactly downgrade



	describe 'Downgrade::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof downgrade.toString(), 'string'
			assert.strictEqual typeof ('' + downgrade), 'string'
