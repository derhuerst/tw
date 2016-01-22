assert =			require 'assert'
sinon =				require 'sinon'
{equalUnits,
equalResources,
equalDuration} =	require '../helpers'

stubbedConfig = {}

container = require '../../src/container'
require '../../src/util/Units'
Duration = container 'util.Duration'
Resources = container 'util.Resources'
Units = container 'util.Units',
	'config.units': -> stubbedConfig





correctChangeEvent = (spy, before, after) ->
	return false unless spy.calledOnce
	args = spy.firstCall.args
	return false unless equalUnits args[0], before
	return false unless equalUnits args[1], after
	return true



describe 'Units', ->

	beforeEach -> Object.assign stubbedConfig,
		a: abbreviation: 'a'
		b: abbreviation: 'b'
		c: abbreviation: 'c'

	u = null
	spy = null

	beforeEach ->
		u = new Units a: 4, b: 5, c: 6
		# b = new Units
		# 	spearFighter: 11, axeman: 9 # infantry
		# 	scout: 8 # cavalry
		# 	catapult: 4 # siege
		# 	paladin: 3 # special
		spy = sinon.spy()
		u.on 'change', spy

	afterEach -> spy.reset()


	it '`isUnits`', ->
		assert.strictEqual u.isUnits, true



	describe 'Units::constructor', ->

		it 'should set all units to the given values', ->
			assert.strictEqual u.a, 4
			assert.strictEqual u.b, 5
			assert.strictEqual u.c, 6

		it 'should set `0` as default the units', ->
			u = new Units a: 1, c: 1
			assert.strictEqual u.b, 0



	describe 'Units::reset', ->

		# todo: mocks?

		it 'should return the instance', ->
			assert.strictEqual u.reset(), u
			assert.strictEqual u.reset(new Units()), u
			assert.strictEqual u.reset(10), u

		it 'should set all units to the given value', ->
			b = new Units a: 3, c: 1
			u.reset b
			equalUnits u, b

		it 'should use `0` as the default value', ->
			u.reset()
			assert.strictEqual u.a, 0

		it 'should emit a correct `change` event when given a `Number`', ->
			old = new Units a: u.a, b: u.b, c: u.c
			u.reset 10
			assert correctChangeEvent spy, old, u

		it 'should emit a correct `change` event when given `Units`', ->
			old = new Units a: u.a, b: u.b, c: u.c
			u.reset new Units()
			assert correctChangeEvent spy, old, u



	describe 'Units::add', ->

		old = null
		beforeEach -> old = new Units a: u.a, b: u.b, c: u.c


		it 'should return the instance', ->
			assert.strictEqual u.add(), u
			assert.strictEqual u.add(new Units()), u
			assert.strictEqual u.add(10), u

		it 'should do nothing when called without a summand', ->
			u.add()
			equalUnits u, old

		it 'should correctly add a `Number` to all units', ->
			u.add 10
			assert.strictEqual u.a, old.a + 10
			assert.strictEqual u.b, old.b + 10
			assert.strictEqual u.c, old.c + 10

		it 'should correctly emit a `change` event when given a `Number`', ->
			u.add 10
			assert correctChangeEvent spy, old, u

		it 'should correctly add `Units` to all units', ->
			b = new Units a: 3, c: 1
			u.add b
			assert.strictEqual u.a, old.a + 3
			assert.strictEqual u.b, old.b
			assert.strictEqual u.c, old.c + 1

		it 'should correctly emit a `change` event when given `Units`', ->
			u.add new Units a: 3, c: 1
			assert correctChangeEvent spy, old, u



	describe 'Units::subtract', ->

		old = null
		beforeEach -> old = new Units a: u.a, b: u.b, c: u.c


		it 'should return the instance', ->
			assert.strictEqual u.add(), u
			assert.strictEqual u.add(new Units()), u
			assert.strictEqual u.subtract(10), u

		it 'should do nothing when called without a subtrahend', ->
			u.subtract()
			equalUnits u, old

		it 'should correctly subtract a `Number` from all units', ->
			u.subtract 10
			assert.strictEqual u.a, old.a - 10
			assert.strictEqual u.b, old.b - 10
			assert.strictEqual u.c, old.c - 10

		it 'should correctly emit a `change` event when given a `Number`', ->
			u.subtract 10
			assert correctChangeEvent spy, old, u

		it 'should correctly subtract `Units` from all units', ->
			b = new Units a: 3, c: 1
			u.subtract b
			assert.strictEqual u.a, old.a - 3
			assert.strictEqual u.b, old.b
			assert.strictEqual u.c, old.c - 1

		it 'should correctly emit a `change` event when given `Units`', ->
			u.subtract new Units a: 3, c: 1
			assert correctChangeEvent spy, old, u



	describe 'Units::multiply', ->

		old = null
		beforeEach -> old = new Units a: u.a, b: u.b, c: u.c


		it 'should return the instance', ->
			assert.strictEqual u.multiply(), u
			assert.strictEqual u.multiply(2), u

		it 'should do nothing when called without a factor', ->
			u.multiply()
			equalUnits u, old

		it 'should correctly multiply a `Number` with all units', ->
			u.multiply 2
			assert.strictEqual u.a, old.a * 2
			assert.strictEqual u.b, old.b * 2
			assert.strictEqual u.c, old.c * 2

		it 'should correctly emit a `change` event when given a `Number`', ->
			u.multiply 2
			assert correctChangeEvent spy, old, u



	describe 'Units::round', ->

		beforeEach -> u = new Units a: 0.9, b: 2, c: 3.1


		it 'should return the instance', ->
			assert.strictEqual u.round(), u

		it 'should round all units correctly', ->
			u.round()
			assert.strictEqual u.a, 1
			assert.strictEqual u.b, 2
			assert.strictEqual u.c, 3

		it 'should emit a correct `change` event', ->
			old = new Units a: u.a, b: u.b, c: u.c
			u.on 'change', bla = sinon.spy()
			u.round()
			assert correctChangeEvent bla, old, u



	describe 'Units::count', ->

		it 'should return the sum of its values', ->
			assert.strictEqual u.count(), 4 + 5 + 6



	describe 'Units::moreThan', ->

		b = null
		beforeEach -> b = new Units a: 2, b: 3, c: 4


		it 'should return `true` for `Units` with every unit being greater or equal', ->
			assert.strictEqual u.moreThan(b), true

		it 'should return `false` for `Units` with any unit being lower', ->
			b.b = 6
			assert.strictEqual u.moreThan(b), false



	describe 'Units::offense', ->

		beforeEach -> Object.assign stubbedConfig,
			a: offense: 1
			b: offense: 2
			c: offense: 3


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.offense(), 'number'

		it 'should return the sum of its `offense`s', ->
			assert.strictEqual u.offense(), 4 * 1 + 5 * 2 + 6 * 3



	describe 'Units::defenseGeneral', ->

		beforeEach -> Object.assign stubbedConfig,
			a: defenseGeneral: 3
			b: defenseGeneral: 2
			c: defenseGeneral: 1


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.defenseGeneral(), 'number'

		it 'should return the sum of its `defenseGeneral`s', ->
			assert.strictEqual u.defenseGeneral(), 4 * 3 + 5 * 2 + 6 * 1



	describe 'Units::defenseCavalry', ->

		beforeEach -> Object.assign stubbedConfig,
			a: defenseCavalry: 2
			b: defenseCavalry: 3
			c: defenseCavalry: 1


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.defenseCavalry(), 'number'

		it 'should return the sum of its `defenseCavalry`s', ->
			assert.strictEqual u.defenseCavalry(), 4 * 2 + 5 * 3 + 6 * 1



	describe 'Units::defenseArchers', ->

		beforeEach -> Object.assign stubbedConfig,
			a: defenseArchers: 3
			b: defenseArchers: 1
			c: defenseArchers: 2


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.defenseArchers(), 'number'

		it 'should return the sum of its `defenseArchers`s', ->
			assert.strictEqual u.defenseArchers(), 4 * 3 + 5 * 1 + 6 * 2



	describe 'Units::haul', ->

		beforeEach -> Object.assign stubbedConfig,
			a: haul: 10
			b: haul: 15
			c: haul: 20


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.haul(), 'number'

		it 'should return the sum of its `haul`s', ->
			assert.strictEqual u.haul(), 4 * 10 + 5 * 15 + 6 * 20



	describe 'Units::resources', ->

		beforeEach -> Object.assign stubbedConfig,
			a: costs: resources: new Resources().reset 20
			b: costs: resources: new Resources().reset 15
			c: costs: resources: new Resources().reset 10


		it 'should return `Resources`', ->
			assert u.resources() instanceof Resources

		it 'should return the sum of its `resources`s', ->
			expected = new Resources
				wood: 4 * 20 + 5 * 15 + 6 * 10
				clay: 4 * 20 + 5 * 15 + 6 * 10
				iron: 4 * 20 + 5 * 15 + 6 * 10
			assert equalResources u.resources(), expected



	describe 'Units::duration', ->

		beforeEach -> Object.assign stubbedConfig,
			a: costs: time: new Duration 20
			b: costs: time: new Duration 10
			c: costs: time: new Duration 15


		it 'should return a `Duration`', ->
			assert u.duration() instanceof Duration

		it 'should return the sum of its `time`s', ->
			assert.strictEqual u.duration().valueOf(), 4 * 20 + 5 * 10 + 6 * 15



	describe 'Units::workers', ->

		beforeEach -> Object.assign stubbedConfig,
			a: costs: workers: 1
			b: costs: workers: 2
			c: costs: workers: 3


		it 'should return a `Number`', ->
			assert.strictEqual typeof u.workers(), 'number'

		it 'should return the sum of its `workers`s', ->
			assert.strictEqual u.workers(), 4 * 1 + 5 * 2 + 6 * 3



	describe 'Units::speed', ->

		beforeEach -> Object.assign stubbedConfig,
			a: speed: new Duration 100
			b: speed: new Duration 200
			c: speed: new Duration 300


		it 'should return the speed of the slowest unit', ->
			assert.strictEqual u.speed().valueOf(), 300
			b = new Units a: 1, b: 1
			assert.strictEqual b.speed().valueOf(), 200



	describe 'Units::subset', ->

		it 'should return `Units`', ->
			assert u.subset([]) instanceof Units
			assert u.subset(['spearFighter']) instanceof Units

		it 'should not return the same instance', ->
			assert.notEqual u.subset([]), u
			assert.notEqual u.subset(['spearFighter']), u

		it 'should correctly copy amounts for given types', ->
			assert equalUnits u.subset(['a', 'b']), new Units a: 1, b: 3



	describe 'Units::infantry', ->

		it 'should return `Units`', ->
			assert u.infantry() instanceof Units

		it 'should call `subset` correctly', ->
			u.subset = sinon.spy u.subset
			u.infantry()
			assert u.subset.calledOnce
			assert u.subset.calledWithExactly [
				'spearFighter'
				'swordsman'
				'axeman'
				'archer'
			]



	describe 'Units::cavalry', ->

		it 'should return `Units`', ->
			assert u.cavalry() instanceof Units

		it 'should call `subset` correctly', ->
			u.subset = sinon.spy u.subset
			u.cavalry()
			assert u.subset.calledOnce
			assert u.subset.calledWithExactly [
				'scout'
				'lightCavalry'
				'mountedArcher'
				'heavyCavalry'
			]



	describe 'Units::siege', ->

		it 'should return `Units`', ->
			assert u.siege() instanceof Units

		it 'should call `subset` correctly', ->
			u.subset = sinon.spy u.subset
			u.siege()
			assert u.subset.calledOnce
			assert u.subset.calledWithExactly ['ram', 'catapult']



	describe 'Units::special', ->

		it 'should return `Units`', ->
			assert u.special() instanceof Units

		it 'should call `subset` correctly', ->
			u.subset = sinon.spy u.subset
			u.special()
			assert u.subset.calledOnce
			assert u.subset.calledWithExactly ['paladin', 'nobleman']



	describe 'Units::clone', ->

		b = null
		beforeEach -> b = u.clone()


		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isUnits, true

		it 'should return a `Units` with equal units', ->
			assert equalUnits b, u



	describe 'Units::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof u.toString(), 'string'
			assert.strictEqual typeof ('' + u), 'string'
