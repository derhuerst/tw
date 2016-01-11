proxyquire =		require('proxyquire').noPreserveCache()
assert =			require 'assert'
sinon =				require 'sinon'

Village =			require '../../src/core/Village'
Smithy =			require '../../src/buildings/Smithy'
Timeout =			require '../../src/util/Timeout'
Duration =			require '../../src/util/Duration'
GameError =			require '../../src/util/GameError'
{equalResources} =	require '../../test/helpers'

Research =			proxyquire '../../src/core/Research',
	'../../config/units':	unitsStub = {}





describe 'Research', ->

	village = null
	smithy = null
	research = null

	beforeEach ->
		village = new Village()
		smithy = new Smithy village: this, level: 3
		village.addBuilding smithy
		village.warehouse.stocks.resources().reset 100000
		research = new Research smithy, 'axeman'

	beforeEach -> unitsStub.foo = research: {}


	it '`isResearch`', ->
		assert.strictEqual research.isResearch, true

	it 'should inherit from `Timeout`', ->
		assert research instanceof Timeout



	describe 'Research::constructor', ->

		it 'should throw a `ReferenceError` if `smithy` has not been passed', ->
			createWithoutSmithy = -> research = new Research()
			assert.throws createWithoutSmithy, ReferenceError

		it 'should set `smithy` to the passed one', ->
			assert.strictEqual research.smithy, smithy

		it 'should throw a `ReferenceError` if `unit` has not been passed', ->
			createWithoutUnit = -> research = new Research smithy
			assert.throws createWithoutUnit, ReferenceError

		it 'should set `unit` to the passed one', ->
			assert.strictEqual research.unit, 'axeman'

		it 'should set `config` to `config[unit].research`', ->
			unitsStub.foo = research: {}
			research = new Research smithy, 'foo'
			assert.strictEqual research.config, unitsStub.foo.research

		it 'should throw a `GameError` if the unit is researched from the beginning', ->
			init = -> new Research smithy, 'foo'

			unitsStub.foo = research: researched: false
			assert.doesNotThrow init, GameError
			unitsStub.foo = research: researched: true
			assert.throws init, GameError



	describe 'Research::start', ->

		start = null
		beforeEach -> start = -> research.start()


		it 'should throw a `GameError` if the unit has already been researched', ->
			assert.doesNotThrow start, GameError
			research.stop()

			research = new Research smithy, 'axeman'
			smithy.researched.axeman = true
			assert.throws start, GameError

		it 'should throw a `GameError` if the `requirements` are not met', ->
			unitsStub.foo.research = requirements: smithy: 2
			assert.doesNotThrow start, GameError
			research.stop()

			research = new Research smithy, 'foo'
			smithy.level.reset 1
			assert.throws start, GameError

		it 'should throw a `GameError` if there are not enough resources', ->
			assert.doesNotThrow start, GameError
			research.stop()

			research = new Research smithy, 'axeman'
			village.warehouse.stocks.resources().reset 10
			assert.throws start, GameError

		it 'should set the `duration` according to config and smithy `timeFactor`', ->
			unitsStub.foo.research = researched: false, time: new Duration '1m'
			smithy.timeFactor.reset 2.5
			research = new Research smithy, 'foo'

			research.start()
			assert.strictEqual 0 + research.duration(), 0 + new Duration '2m30s'

		it 'should emit `start`', ->
			onStart = sinon.spy()
			research.on 'start', onStart
			start()
			assert onStart.calledOnce



	it 'should `smithy.researched[unit]` to `true` when `finish`ed', ->
		research.start()
		research.finish()
		assert.strictEqual smithy.researched.axeman, true

	it 'should refund to the `village`\'s `resources` when `stop`ed', ->
		before = village.warehouse.stocks.resources().clone()
		research.start()
		research.stop()
		assert equalResources village.warehouse.stocks.resources(), before



	describe 'event handling on `building`', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should emit `research.start` when `start`ed', ->
			village.on 'research.start', spy
			research.start()
			assert spy.calledOnce
			assert spy.calledWithExactly research

		it 'should emit `research.stop` when `stop`ed', ->
			village.on 'research.stop', spy
			research.start()

			research.stop()
			assert spy.calledOnce
			assert spy.calledWithExactly research

		it 'should emit `research.finish` and `research` when `finish`ed', ->
			village.on 'research.finish', spy
			spy2 = sinon.spy()
			village.on 'research', spy2
			research.start()

			research.finish()
			assert spy.calledOnce
			assert spy.calledWithExactly research
			assert spy2.calledOnce
			assert spy2.calledWithExactly research



	describe 'Research::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof research.toString(), 'string'
			assert.strictEqual typeof ('' + research), 'string'
