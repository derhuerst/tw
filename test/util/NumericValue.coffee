assert =			require 'assert'
sinon =				require 'sinon'

{EventEmitter} =	require 'events'

NumericValue =		require '../../src/util/NumericValue'





describe 'NumericValue', ->

	onChange = sinon.spy()
	afterEach -> onChange.reset()

	it '`isNumericValue`', ->
		a = new NumericValue()
		assert.strictEqual a.isNumericValue, true

	it 'should inherit from `EventEmitter`', ->
		a = new NumericValue()
		assert a instanceof EventEmitter



	describe 'NumericValue::constructor', ->

		it 'should initialize `value` correctly', ->
			a = new NumericValue 1, 'test'
			assert.strictEqual a.value, 1

			# testing the default value
			b = new NumericValue()
			assert.strictEqual b.value, 0

		it 'should initialize `abbreviation` correctly', ->
			a = new NumericValue 0, 'test'
			assert.strictEqual a.abbreviation, 'test'

			# testing the default value
			b = new NumericValue()
			assert.strictEqual b.abbreviation, ''



	describe 'NumericValue::reset', ->

		a = null
		b = null

		beforeEach ->
			a = new NumericValue 1, 'test'
			b = 2
			a.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.reset(b), a
			assert.strictEqual a.reset(), a

		it 'should set `value` correctly', ->
			a.reset b
			assert.strictEqual a.value, b

			# testing the default value
			a.reset()
			assert.strictEqual a.value, 0

		it 'should emit a correct `change` event', ->
			oldValue = a.value
			a.reset b
			assert onChange.calledOnce
			assert onChange.calledWithExactly oldValue, a.value



	describe 'NumericValue::add', ->

		a = null
		b = null
		expected = null

		beforeEach ->
			a = new NumericValue 1, 'test'
			a.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.add(2), a

		it 'should do nothing when called without a summand', ->
			oldValue = a.value
			a.add()
			assert.strictEqual a.value, oldValue
			assert onChange.callCount is 0

		describe 'when adding a `Number`', ->

			beforeEach ->
				b = 2
				expected = a + b

			it 'should set `value` correctly', ->
				a.add b
				assert.strictEqual a.value, expected

			it 'should emit a correct `change` event', ->
				oldValue = a.value
				a.add b
				assert onChange.calledOnce
				assert onChange.calledWithExactly oldValue, a.value

		describe 'when adding a `NumericValue`', ->

			beforeEach -> b = new NumericValue 2

			it 'should set `value` correctly', ->
				a.add b
				assert.strictEqual a.value, expected

			it 'should emit a correct `change` event', ->
				oldValue = a.value
				a.add b
				assert onChange.calledOnce
				assert onChange.calledWithExactly oldValue, a.value



	describe 'NumericValue::subtract', ->

		a = null
		b = null

		beforeEach ->
			a = new NumericValue 1, 'test'
			a.on 'change', onChange
			b = 2

		it 'should return the instance', ->
			assert.strictEqual a.subtract(2), a

		it 'should do nothing when called without a summand', ->
			oldValue = a.value
			a.subtract()
			assert.strictEqual a.value, oldValue
			assert onChange.callCount is 0

		it 'should call `add` with the additive inverse', ->
			a.add = sinon.spy()
			a.subtract b
			assert a.add.calledOnce
			assert a.add.calledWithExactly -1 * b



	describe 'NumericValue::multiply', ->

		a = null
		b = null
		expected = null

		beforeEach ->
			a = new NumericValue 1, 'test'
			a.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.multiply(2), a

		it 'should do nothing when called without a factor', ->
			oldValue = a.value
			a.multiply()
			assert.strictEqual a.value, oldValue
			assert onChange.callCount is 0

		describe 'when multiplying with a `Number`', ->

			beforeEach ->
				b = 3
				expected = a * b

			it 'should set `value` correctly', ->
				a.multiply b
				assert.strictEqual a.value, expected

			it 'should emit a correct `change` event', ->
				oldValue = a.value
				a.multiply b
				assert onChange.calledOnce
				assert onChange.calledWithExactly oldValue, a.value

		describe 'when multiplying a `NumericValue`', ->

			beforeEach ->
				b = new NumericValue 3
				expected = a * b

			it 'should set `value` correctly', ->
				a.multiply b
				assert.strictEqual a.value, expected

			it 'should emit a correct `change` event', ->
				oldValue = a.value
				a.multiply b
				assert onChange.calledOnce
				assert onChange.calledWithExactly oldValue, a.value



	describe 'NumericValue::round', ->

		a = null

		beforeEach ->
			a = new NumericValue 1.5, 'test'
			a.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.round(), a

		it 'should correctly round `value`', ->
			oldValue = a.value
			a.round()
			assert.strictEqual a.value, Math.round oldValue

		it 'should do nothing if `value` can\'t be rounded', ->
			a.round()
			a.round()
			assert onChange.callCount is 1

		it 'should emit a correct `change` event', ->
			oldValue = a.value
			a.round()
			assert onChange.calledOnce
			assert onChange.calledWithExactly oldValue, a.value



	describe 'NumericValue::watch', ->

		a = null
		b = null

		beforeEach ->
			a = new NumericValue 2.5, 'test'
			b = new NumericValue 1, 'test'
			b.watch a
			b.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.watch(b), a

		it 'should apply all changes from another `NumericValue`', ->
			oldValue = b.value
			a.add 2
			assert.strictEqual b.value, oldValue + 2
			assert onChange.calledOnce
			assert onChange.calledWithExactly oldValue, b.value

			onChange.reset()

			oldValue = b.value
			a.subtract 1
			assert.strictEqual b.value, oldValue - 1
			assert onChange.calledOnce
			assert onChange.calledWithExactly oldValue, b.value



	describe 'NumericValue::unwatch', ->

		a = null
		b = null

		beforeEach ->
			a = new NumericValue 2, 'test'
			b = new NumericValue 1, 'test'
			b.on 'change', onChange

		it 'should return the instance', ->
			assert.strictEqual a.watch(b), a

		it 'should stop applying all changes', ->
			b.watch a

			a.subtract 1
			a.add 2
			assert onChange.calledTwice

			b.unwatch a

			a.subtract 1
			a.add 2
			assert onChange.calledTwice



	describe 'NumericValue::clone', ->

		a = null
		b = null

		beforeEach ->
			a = new NumericValue 2, 'test'
			b = a.clone()

		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isNumericValue, true
			assert b instanceof EventEmitter

		it 'should return a `NumericValue` with an equal `value`', ->
			assert.strictEqual a.value, b.value

		it 'should return a `NumericValue` with an equal `abbreviation`', ->
			assert.strictEqual a.abbreviation, b.abbreviation



	describe 'NumericValue::valueOf', ->

		a = null

		beforeEach ->
			a = new NumericValue 2.5, 'test'

		it 'should return `value`', ->
			assert.strictEqual a.valueOf(), a.value
			assert.strictEqual 0 + a, a.value



	describe 'NumericValue::toString', ->

		a = null

		beforeEach ->
			a = new NumericValue 2.5, 'test'

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
