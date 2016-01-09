proxyquire =		require('proxyquire').noPreserveCache()
assert =			require 'assert'
sinon =				require 'sinon'

Recruitment =		require '../../src/core/Recruitment'
Timeout =			require '../../src/util/Timeout'
GameError =			require '../../src/util/GameError'
Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
{equalResources,
equalUnits} =		require '../../test/helpers'

cfg =
	'../../config/units':		unitsStub = {}
	'../../config/buildings':	buildingsStub = {}
Village =			proxyquire '../../src/core/Village', cfg
Building =			proxyquire '../../src/core/Building', cfg
Units =				proxyquire '../../src/util/Units', cfg





describe 'Recruitment', ->

	beforeEach -> buildingsStub.foo =
		initialLeveL: 0
		points: -> 1
		requirements: {}
		timeFactor: -> 1

	beforeEach ->
		unitsStub.foo = costs:
			resources:	new Resources wood: 1, clay: 1, iron: 1
			time:		new Duration '1s'
			workers:	1
		unitsStub.bar = costs:
			resources:	new Resources wood: 2, clay: 2, iron: 2
			time:		new Duration '2s'
			workers:	2

	village = null
	beforeEach ->
		village = new Village
			barracks:	new Building {village, type: 'barracks'}
			stable:		new Building {village, type: 'stable'}
			workshop:	new Building {village, type: 'workshop'}
			academy:	new Building {village, type: 'academy'}
			statue:		new Building {village, type: 'statue'}
		village.warehouse.stocks.maxima.reset 100000
		village.warehouse.stocks.resources().reset 100000
		village.farm.workers.reset 1000

	units = null
	recruitment = null

	beforeEach ->
		units = new Units spearFighter: 1, scout: 1, ram: 1, nobleman: 1, paladin: 1
		recruitment = new Recruitment village, units


	it '`isRecruitment`', ->
		assert.strictEqual recruitment.isRecruitment, true

	it 'should inherit from `Timeout`', ->
		assert recruitment instanceof Timeout



	describe 'Recruitment::constructor', ->

		it 'should throw a `ReferenceError` if `village` has not been passed', ->
			createWithoutVillage = -> new Recruitment()
			assert.throws createWithoutVillage, ReferenceError

		it 'should set `village` to the passed one', ->
			assert.strictEqual recruitment.village, village

		it 'should throw a `ReferenceError` if `units` has not been passed', ->
			createWithoutUnits = -> new Recruitment village
			assert.throws createWithoutUnits, ReferenceError

		it 'should clone the passed `units`', ->
			assert.notEqual recruitment.units, units
			assert equalUnits recruitment.units, units



	describe 'Recruitment::start', ->

		start = null
		beforeEach -> start = -> recruitment.start()


		it 'should throw a `GameError` if the barracks\' level is 0', ->
			village.barracks.level.reset 1
			start()
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.barracks.level.reset 0
			assert.throws start, GameError

		it 'should throw a `GameError` if the stable\'s level is 0', ->
			village.stable.level.reset 1
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.stable.level.reset 0
			assert.throws start, GameError

		it 'should throw a `GameError` if the workshop\'s level is 0', ->
			village.workshop.level.reset 1
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.stable.level.reset 0
			assert.throws start, GameError

		it 'should throw a `GameError` if the academy\'s level is 0', ->
			village.academy.level.reset 1
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.stable.level.reset 0
			assert.throws start, GameError

		it 'should throw a `GameError` if the statue\'s level is 0', ->
			village.statue.level.reset 1
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.stable.level.reset 0
			assert.throws start, GameError

		it 'should throw a `GameError` if the village already has a paladin', ->
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.rallyPoint.units.available.paladin = 1
			assert.throws start, GameError

		it 'should throw a `GameError` if there are not enough resources', ->
			assert.doesNotThrow start, GameError
			recruitment.stop()
			recruitment = new Recruitment village, units

			village.warehouse.stocks.resources().reset 10
			assert.throws start, GameError

		it 'should subtract the resources needed from the village', ->
			recruitment = new Recruitment village, new Units foo: 3, bar: 5
			expected = village.warehouse.stocks.resources().clone()
			expected.subtract new Resources wood: 13, clay: 13, iron: 13
			start()
			assert equalResources village.warehouse.stocks.resources(), expected

		it 'should subtract the workers needed from the village', ->
			recruitment = new Recruitment village, new Units foo: 3, bar: 5
			expected = village.farm.workers - 13
			start()
			assert.strictEqual 0 + village.farm.workers, expected

		it 'should emit `start`', ->
			onStart = sinon.spy()
			recruitment.on 'start', onStart
			start()
			assert onStart.calledOnce



	describe 'Recruitment::stop', ->

		it 'should emit `stop`', ->
			spy = sinon.spy()
			recruitment.on 'stop', spy
			recruitment.start()
			recruitment.stop()
			assert spy.calledOnce



	it 'should add the `units` for the village\'s rally point when `finish`ed', ->
		expected = village.rallyPoint.units.available.clone().add units
		recruitment.start()
		recruitment.finish()
		assert equalUnits village.rallyPoint.units.available, expected

	it 'should refund 90% to the `village`\'s `resources` when `stop`ed', ->
		expected = village.warehouse.stocks.resources().clone()
		expected.subtract units.resources().clone().multiply .1
		recruitment.start()
		recruitment.stop()
		assert equalResources village.warehouse.stocks.resources(), expected

	it 'should refund to the `village`\'s `workers` when `stop`ed', ->
		before = 0 + village.farm.workers
		recruitment.start()
		recruitment.stop()
		assert.strictEqual 0 + village.farm.workers, before



	describe 'event handling on `building`', ->

		spy = null
		beforeEach -> spy = sinon.spy()


		it 'should emit `recruitment.start` when `start`ed', ->
			village.on 'recruitment.start', spy
			recruitment.start()
			assert spy.calledOnce
			assert spy.calledWithExactly recruitment

		it 'should emit `recruitment.stop` when `stop`ed', ->
			village.on 'recruitment.stop', spy
			recruitment.start()

			recruitment.stop()
			assert spy.calledOnce
			assert spy.calledWithExactly recruitment

		it 'should emit `recruitment.finish` and `recruitment` when `finish`ed', ->
			village.on 'recruitment.finish', spy
			spy2 = sinon.spy()
			village.on 'recruitment', spy2
			recruitment.start()

			recruitment.finish()
			assert spy.calledOnce
			assert spy.calledWithExactly recruitment
			assert spy2.calledOnce
			assert spy2.calledWithExactly recruitment



	describe 'Recruitment::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof recruitment.toString(), 'string'
			assert.strictEqual typeof ('' + recruitment), 'string'
