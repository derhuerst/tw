assert =			require 'assert'
sinon =				require 'sinon'

Upgrade =			require '../../src/core/Upgrade'
Village =			require '../../src/core/Village'
Timeout =			require '../../src/util/Timeout'
config =			require '../../config/buildings/headquarter'
GameError =			require '../../src/util/GameError'
{equalResources} =	require '../../test/helpers'





describe 'Upgrade', ->

	village = null
	building = null
	upgrade = null

	beforeEach ->
		village = new Village()
		building = village.headquarter
		building.village.warehouse.stocks.resources().reset 1000
		upgrade = new Upgrade building


	it '`isUpgrade`', ->
		assert.strictEqual upgrade.isUpgrade, true

	it 'should inherit from `Timeout`', ->
		assert upgrade instanceof Timeout



	describe 'Upgrade::constructor', ->

		it 'should throw a `ReferenceError` if `building` has not been passed', ->
			createWithoutBuilding = -> upgrade = new Upgrade()
			assert.throws createWithoutBuilding, ReferenceError

		it 'should set `building` to the passed one', ->
			assert.strictEqual upgrade.building, building



	describe 'Upgrade::start', ->

		start = null
		beforeEach -> start = -> upgrade.start()


		it 'should throw a `GameError` if the building has been upgraded in the mean time', ->
			assert.doesNotThrow start, GameError
			upgrade.stop()

			upgrade = new Upgrade building
			building.level.add 1
			assert.throws start, GameError

		it 'should throw a `GameError` if the building is at maximum level', ->
			assert.doesNotThrow start, GameError
			upgrade.stop()

			upgrade = new Upgrade building
			building.level.reset building.config.maximalLevel
			assert.throws start, GameError

		it 'should throw a `GameError` if there are not enough resources', ->
			assert.doesNotThrow start, GameError
			upgrade.stop()

			upgrade = new Upgrade building
			building.village.warehouse.stocks.resources().reset 10
			assert.throws start, GameError

		it 'should subtract the neede workers from the village', ->
			# todo: mock building config
			onChange = sinon.spy()
			village.farm.workers.on 'change', onChange

			start()
			assert onChange.calledOnce
			expected = config.workers(1) - config.workers(2)
			actual = onChange.firstCall.args[1] - onChange.firstCall.args[0]
			assert.strictEqual actual, expected

		it 'should emit `start`', ->
			onStart = sinon.spy()
			upgrade.on 'start', onStart
			start()
			assert onStart.calledOnce



	describe 'Upgrade::stop', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should do nothing if not `running`', ->
			upgrade.on 'stop', spy
			upgrade.stop()
			assert.strictEqual spy.callCount, 0

		it 'should emit `stop`', ->
			upgrade.on 'stop', spy
			upgrade.start()
			upgrade.stop()
			assert spy.calledOnce



	it 'should increment the `building`\'s `level` when `finish`ed', ->
		expected = 1 + building.level
		upgrade.start()
		upgrade.finish()
		assert.strictEqual 0 + building.level, expected

	it 'should refund to the `village`\'s `resources` when `stop`ed', ->
		before = village.warehouse.stocks.resources().clone()
		upgrade.start()
		upgrade.stop()
		assert equalResources village.warehouse.stocks.resources(), before

	it 'should refund to the `village`\'s `workers` when `stop`ed', ->
		before = 0 + village.farm.workers
		upgrade.start()
		upgrade.stop()
		assert.strictEqual 0 + village.farm.workers, before



	describe 'event handling on `building`', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should emit `upgrade.start` when `start`ed', ->
			building.on 'upgrade.start', spy
			upgrade.start()
			assert spy.calledOnce
			assert spy.calledWithExactly upgrade

		it 'should emit `upgrade.stop` when `stop`ed', ->
			building.on 'upgrade.stop', spy
			upgrade.start()

			upgrade.stop()
			assert spy.calledOnce
			assert spy.calledWithExactly upgrade

		it 'should emit `upgrade.finish` and `upgrade` when `finish`ed', ->
			building.on 'upgrade.finish', spy
			spy2 = sinon.spy()
			building.on 'upgrade', spy2
			upgrade.start()

			upgrade.finish()
			assert spy.calledOnce
			assert spy.calledWithExactly upgrade
			assert spy2.calledOnce
			assert spy2.calledWithExactly upgrade



	describe 'Upgrade::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof upgrade.toString(), 'string'
			assert.strictEqual typeof ('' + upgrade), 'string'
