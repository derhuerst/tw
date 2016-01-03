assert =			require 'assert'
sinon =				require 'sinon'

config =			require '../../config/units'
Duration =			require '../../src/util/Duration'
Resources =			require '../../src/util/Resources'
Units =				require '../../src/util/Units'
{equalUnits} =		require '../helpers'





correctChangeEvent = (spy, before, after) ->
	assert spy.calledOnce
	args = spy.firstCall.args
	assert equalUnits args[0], before
	assert equalUnits args[1], after

units =
	spearFighter: 12, swordsman: 11, axeman: 10, archer: 9 # infantry
	scout: 8, lightCavalry: 7, mountedArcher: 6, heavyCavalry: 5 # cavalry
	ram: 4, catapult: 3 # siege
	paladin: 2, nobleman: 1 # special



describe 'Units', ->

	a = null
	b = null
	spy = null

	beforeEach ->
		a = new Units units
		b = new Units
			spearFighter: 11, axeman: 9 # infantry
			scout: 8 # cavalry
			catapult: 4 # siege
			paladin: 3 # special
		spy = sinon.spy()
		a.on 'change', spy

	afterEach -> spy.reset()


	it '`isUnits`', ->
		assert.strictEqual a.isUnits, true



	describe 'Units::constructor', ->

		it 'should set all units to the given values', ->
			for unit, amount of units
				assert.strictEqual a[unit], amount

		it 'should set `0` as default the units', ->
			a = new Units
				swordsman: 1
			for unit, amount of units
				continue if unit is 'swordsman'
				assert.strictEqual a[unit], 0



	describe 'Units::reset', ->

		it 'should return the instance', ->
			assert.strictEqual a.reset(b), a
			assert.strictEqual a.reset(10), a

		it 'should set all units to the given value', ->
			expected = Object.assign {}, a, b
			a.reset b
			equalUnits a, b

		it 'should use `0` as the default value', ->
			a.reset()
			assert.strictEqual a[unit], 0 for unit of units

		it 'should emit a correct `change` event when given a `Number`', ->
			old = new Units a
			a.reset 10
			correctChangeEvent spy, old, a

		it 'should emit a correct `change` event when given `Units`', ->
			old = new Units a
			a.reset b
			correctChangeEvent spy, old, a



	describe 'Units::add', ->

		old = null
		beforeEach -> old = new Units a


		it 'should return the instance', ->
			assert.strictEqual a.add(b), a
			assert.strictEqual a.add(10), a

		it 'should do nothing when called without a summand', ->
			a.add()
			equalUnits a, old

		it 'should correctly add a `Number` to all units', ->
			a.add 10
			assert.strictEqual a[unit], old[unit] + 10 for unit of units

		it 'should correctly emit a `change` event when given a `Number`', ->
			a.add 10
			correctChangeEvent spy, old, a

		it 'should correctly add `Units` to all units', ->
			a.add b
			assert.strictEqual a[unit], old[unit] + b[unit] for unit of units

		it 'should correctly emit a `change` event when given `Units`', ->
			a.add b
			correctChangeEvent spy, old, a



	describe 'Units::subtract', ->

		old = null
		beforeEach -> old = new Units a


		it 'should return the instance', ->
			assert.strictEqual a.subtract(b), a
			assert.strictEqual a.subtract(10), a

		it 'should do nothing when called without a subtrahend', ->
			a.subtract()
			equalUnits a, old

		it 'should correctly subtract a `Number` from all units', ->
			a.subtract 10
			assert.strictEqual a[unit], old[unit] - 10 for unit of units

		it 'should correctly emit a `change` event when given a `Number`', ->
			a.subtract 10
			correctChangeEvent spy, old, a

		it 'should correctly subtract `Units` from all units', ->
			a.subtract b
			assert.strictEqual a[unit], old[unit] - b[unit] for unit of units

		it 'should correctly emit a `change` event when given `Units`', ->
			a.subtract b
			correctChangeEvent spy, old, a



	describe 'Units::multiply', ->

		old = null
		beforeEach -> old = new Units a


		it 'should return the instance', ->
			assert.strictEqual a.multiply(2), a

		it 'should do nothing when called without a factor', ->
			a.multiply()
			equalUnits a, old

		it 'should correctly multiply a `Number` with all units', ->
			a.multiply 2
			assert.strictEqual a[unit], old[unit] * 2 for unit of units

		it 'should correctly emit a `change` event when given a `Number`', ->
			a.multiply 2
			correctChangeEvent spy, old, a



	describe 'Units::round', ->

		it 'should return the instance', ->
			assert.strictEqual a.round(), a

		it 'should round all units correctly', ->
			a.round()
			for unit of units
				assert.strictEqual a[unit], Math.round a[unit]

		it 'should emit a correct `change` event', ->
			old = new Units a
			a.round b
			correctChangeEvent spy, old, a



	describe 'Units::count', ->

		it 'should return the sum of its values', ->
			assert.strictEqual a.count(), 78



	describe 'Units::moreThan', ->

		it 'should return `true` for `Units` with every unit being greater or equal', ->
			b = new Units a
			b.spearFighter--
			b.ram -= 2
			b.nobleman = 0
			assert.strictEqual a.moreThan(b), true

		it 'should return `false` for `Units` with any unit being lower', ->
			b = new Units a
			b.spearFighter++
			b.ram += 2
			assert.strictEqual a.moreThan(b), false



	describe 'Units::offense', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.offense(), 'number'

		it 'should return the sum of its `offense`s', ->
			assert.strictEqual a.offense(), (
				units.spearFighter * config.spearFighter.offense +
				units.swordsman * config.swordsman.offense +
				units.axeman * config.axeman.offense +
				units.archer * config.archer.offense +
				units.lightCavalry * config.lightCavalry.offense +
				units.mountedArcher * config.mountedArcher.offense +
				units.heavyCavalry * config.heavyCavalry.offense +
				units.ram * config.ram.offense +
				units.catapult * config.catapult.offense +
				units.paladin * config.paladin.offense +
				units.nobleman * config.nobleman.offense
			)



	describe 'Units::defenseGeneral', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.defenseGeneral(), 'number'

		it 'should return the sum of its `defenseGeneral`s', ->
			assert.strictEqual a.defenseGeneral(), (
				units.spearFighter * config.spearFighter.defenseGeneral +
				units.swordsman * config.swordsman.defenseGeneral +
				units.axeman * config.axeman.defenseGeneral +
				units.archer * config.archer.defenseGeneral +
				units.scout * config.scout.defenseGeneral +
				units.lightCavalry * config.lightCavalry.defenseGeneral +
				units.mountedArcher * config.mountedArcher.defenseGeneral +
				units.heavyCavalry * config.heavyCavalry.defenseGeneral +
				units.ram * config.ram.defenseGeneral +
				units.catapult * config.catapult.defenseGeneral +
				units.paladin * config.paladin.defenseGeneral +
				units.nobleman * config.nobleman.defenseGeneral
			)



	describe 'Units::defenseCavalry', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.defenseCavalry(), 'number'

		it 'should return the sum of its `defenseCavalry`s', ->
			assert.strictEqual a.defenseCavalry(), (
				units.spearFighter * config.spearFighter.defenseCavalry +
				units.swordsman * config.swordsman.defenseCavalry +
				units.axeman * config.axeman.defenseCavalry +
				units.archer * config.archer.defenseCavalry +
				units.scout * config.scout.defenseCavalry +
				units.lightCavalry * config.lightCavalry.defenseCavalry +
				units.mountedArcher * config.mountedArcher.defenseCavalry +
				units.heavyCavalry * config.heavyCavalry.defenseCavalry +
				units.ram * config.ram.defenseCavalry +
				units.catapult * config.catapult.defenseCavalry +
				units.paladin * config.paladin.defenseCavalry +
				units.nobleman * config.nobleman.defenseCavalry
			)



	describe 'Units::defenseArchers', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.defenseArchers(), 'number'

		it 'should return the sum of its `defenseArchers`s', ->
			assert.strictEqual a.defenseArchers(), (
				units.spearFighter * config.spearFighter.defenseArchers +
				units.swordsman * config.swordsman.defenseArchers +
				units.axeman * config.axeman.defenseArchers +
				units.archer * config.archer.defenseArchers +
				units.scout * config.scout.defenseArchers +
				units.lightCavalry * config.lightCavalry.defenseArchers +
				units.mountedArcher * config.mountedArcher.defenseArchers +
				units.heavyCavalry * config.heavyCavalry.defenseArchers +
				units.ram * config.ram.defenseArchers +
				units.catapult * config.catapult.defenseArchers +
				units.paladin * config.paladin.defenseArchers +
				units.nobleman * config.nobleman.defenseArchers
			)



	describe 'Units::haul', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.haul(), 'number'

		it 'should return the sum of its `haul`s', ->
			assert.strictEqual a.haul(), (
				units.spearFighter * config.spearFighter.haul +
				units.swordsman * config.swordsman.haul +
				units.axeman * config.axeman.haul +
				units.archer * config.archer.haul +
				units.lightCavalry * config.lightCavalry.haul +
				units.mountedArcher * config.mountedArcher.haul +
				units.heavyCavalry * config.heavyCavalry.haul +
				units.paladin * config.paladin.haul
			)



	describe 'Units::resources', ->

		# todo: mock units config

		it 'should return `Resources`', ->
			assert a.resources() instanceof Resources

		it 'should return the sum of its `resources`s', ->
			expected = new Resources()
				.add config.spearFighter.costs.resources.clone().multiply units.spearFighter
				.add config.swordsman.costs.resources.clone().multiply units.swordsman
				.add config.axeman.costs.resources.clone().multiply units.axeman
				.add config.archer.costs.resources.clone().multiply units.archer
				.add config.scout.costs.resources.clone().multiply units.scout
				.add config.lightCavalry.costs.resources.clone().multiply units.lightCavalry
				.add config.mountedArcher.costs.resources.clone().multiply units.mountedArcher
				.add config.heavyCavalry.costs.resources.clone().multiply units.heavyCavalry
				.add config.ram.costs.resources.clone().multiply units.ram
				.add config.catapult.costs.resources.clone().multiply units.catapult
				.add config.paladin.costs.resources.clone().multiply units.paladin
				.add config.nobleman.costs.resources.clone().multiply units.nobleman
			actual = a.resources()
			assert.strictEqual actual.wood, expected.wood
			assert.strictEqual actual.clay, expected.clay
			assert.strictEqual actual.iron, expected.iron



	describe 'Units::duration', ->

		# todo: mock units config

		it 'should return a `Duration`', ->
			assert a.duration() instanceof Duration

		it 'should return the sum of its `time`s', ->
			assert.strictEqual a.duration().valueOf(), (
				units.spearFighter * config.spearFighter.costs.time +
				units.swordsman * config.swordsman.costs.time +
				units.axeman * config.axeman.costs.time +
				units.archer * config.archer.costs.time +
				units.scout * config.scout.costs.time +
				units.lightCavalry * config.lightCavalry.costs.time +
				units.mountedArcher * config.mountedArcher.costs.time +
				units.heavyCavalry * config.heavyCavalry.costs.time +
				units.ram * config.ram.costs.time +
				units.catapult * config.catapult.costs.time +
				units.paladin * config.paladin.costs.time +
				units.nobleman * config.nobleman.costs.time
			)



	describe 'Units::workers', ->

		# todo: mock units config

		it 'should return a `Number`', ->
			assert.strictEqual typeof a.workers(), 'number'

		it 'should return the sum of its `workers`s', ->
			assert.strictEqual a.workers(), (
				units.spearFighter * config.spearFighter.costs.workers +
				units.swordsman * config.swordsman.costs.workers +
				units.axeman * config.axeman.costs.workers +
				units.archer * config.archer.costs.workers +
				units.scout * config.scout.costs.workers +
				units.lightCavalry * config.lightCavalry.costs.workers +
				units.mountedArcher * config.mountedArcher.costs.workers +
				units.heavyCavalry * config.heavyCavalry.costs.workers +
				units.ram * config.ram.costs.workers +
				units.catapult * config.catapult.costs.workers +
				units.paladin * config.paladin.costs.workers +
				units.nobleman * config.nobleman.costs.workers
			)



	describe 'Units::speed', ->

		it 'should not the speed of the slowest unit', ->
			expected = config.nobleman.speed # slowest of a is nobleman
			assert.strictEqual a.speed().valueOf(), expected.valueOf()
			expected = config.catapult.speed # slowest of b is catapult
			assert.strictEqual b.speed().valueOf(), expected.valueOf()



	describe 'Units::subset', ->

		it 'should return `Units`', ->
			assert a.subset([]) instanceof Units
			assert a.subset(['spearFighter']) instanceof Units

		it 'should not return the same instance', ->
			assert.notEqual a.subset([]), a
			assert.notEqual a.subset(['spearFighter']), a

		it 'should correctly copy amounts for given types', ->
			expected = new Units {axeman: 10, catapult: 3}
			equalUnits a.subset(['axeman', 'catapult']), expected



	describe 'Units::infantry', ->

		it 'should return `Units`', ->
			assert a.infantry() instanceof Units

		it 'should call `subset` correctly', ->
			a.subset = sinon.spy a.subset
			a.infantry b
			assert a.subset.calledOnce
			assert a.subset.calledWithExactly [
				'spearFighter'
				'swordsman'
				'axeman'
				'archer'
			]



	describe 'Units::cavalry', ->

		it 'should return `Units`', ->
			assert a.cavalry() instanceof Units

		it 'should call `subset` correctly', ->
			a.subset = sinon.spy a.subset
			a.cavalry b
			assert a.subset.calledOnce
			assert a.subset.calledWithExactly [
				'scout'
				'lightCavalry'
				'mountedArcher'
				'heavyCavalry'
			]



	describe 'Units::siege', ->

		it 'should return `Units`', ->
			assert a.siege() instanceof Units

		it 'should call `subset` correctly', ->
			a.subset = sinon.spy a.subset
			a.siege b
			assert a.subset.calledOnce
			assert a.subset.calledWithExactly ['ram', 'catapult']



	describe 'Units::special', ->

		it 'should return `Units`', ->
			assert a.special() instanceof Units

		it 'should call `subset` correctly', ->
			a.subset = sinon.spy a.subset
			a.special b
			assert a.subset.calledOnce
			assert a.subset.calledWithExactly ['paladin', 'nobleman']



	describe 'Units::clone', ->

		b = null
		beforeEach -> b = a.clone()


		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isUnits, true

		it 'should return a `Units` with equal all units', ->
			assert.strictEqual b[unit], a[unit] for unit of units



	describe 'Units::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
