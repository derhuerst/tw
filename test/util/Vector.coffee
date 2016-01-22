assert = require 'assert'

container = require '../../src/container'
require '../../src/util/Vector'
Vector = container 'util.Vector'





describe 'Vector', ->

	a = null
	oldX = null
	oldY = null

	beforeEach ->
		a = new Vector 1.5, 2.5
		oldX = a.x
		oldY = a.y


	it '`isVector`', ->
		assert.strictEqual a.isVector, true



	describe 'Vector::constructor', ->

		it 'should set `x` and `y` to the given values', ->
			assert.strictEqual a.x, 1.5
			assert.strictEqual a.y, 2.5

		it 'should set `0` as default for `x` and `y`', ->
			a = new Vector()
			assert.strictEqual a.x, 0
			assert.strictEqual a.y, 0



	describe 'Vector::reset', ->

		it 'should return the instance', ->
			assert.strictEqual a.reset(), a

		it 'should set `x` and `y` to `0`', ->
			a.reset()
			assert.strictEqual a.x, 0
			assert.strictEqual a.y, 0



	describe 'Vector::add', ->

		it 'should return the instance', ->
			assert.strictEqual a.add(2), a

		it 'should do nothing when called without a summand', ->
			a.add()
			assert.strictEqual a.x, oldX
			assert.strictEqual a.y, oldY



		describe 'when adding a `Number`', ->

			b = null
			beforeEach -> b = 2


			it 'should add the number to `x` and `y`', ->
				a.add b
				assert.strictEqual a.x, oldX + b
				assert.strictEqual a.y, oldY + b



		describe 'when adding a `Vector`', ->

			b = null
			beforeEach -> b = new Vector 2, 3


			it 'should add the vector to `x` and `y`', ->
				a.add b
				assert.strictEqual a.x, oldX + b.x
				assert.strictEqual a.y, oldY + b.y



	describe 'Vector::subtract', ->

		it 'should return the instance', ->
			assert.strictEqual a.subtract(2), a

		it 'should do nothing when called without a summand', ->
			a.subtract()
			assert.strictEqual a.x, oldX
			assert.strictEqual a.y, oldY



		describe 'when subtracting a `Number`', ->

			b = null
			beforeEach -> b = 2


			it 'should subtract the number from `x` and `y`', ->
				a.subtract b
				assert.strictEqual a.x, oldX - b
				assert.strictEqual a.y, oldY - b



		describe 'when subtracting a `Vector`', ->

			b = null
			beforeEach -> b = new Vector 2, 3


			it 'should subtract the vector from `x` and `y`', ->
				a.subtract b
				assert.strictEqual a.x, oldX - b.x
				assert.strictEqual a.y, oldY - b.y



	describe 'Vector::multiply', ->

		it 'should return the instance', ->
			assert.strictEqual a.multiply(2), a

		it 'should do nothing when called without a summand', ->
			a.multiply()
			assert.strictEqual a.x, oldX
			assert.strictEqual a.y, oldY



		describe 'when multiplying with a `Number`', ->

			b = null
			beforeEach -> b = 2


			it 'should multiply `x` and `y` with the number', ->
				a.multiply b
				assert.strictEqual a.x, oldX * b
				assert.strictEqual a.y, oldY * b



		describe 'when multiplying with a `Vector`', ->

			b = null
			beforeEach -> b = new Vector 2, 3


			it 'should multiply `x` and `y` with the vector\'s components', ->
				a.multiply b
				assert.strictEqual a.x, oldX * b.x
				assert.strictEqual a.y, oldY * b.y



	describe 'Vector::round', ->

		it 'should return the instance', ->
			assert.strictEqual a.round(), a

		it 'should correctly round `x` and `y`', ->
			a.round()
			assert.strictEqual a.x, Math.round oldX
			assert.strictEqual a.y, Math.round oldY



	describe 'Vector::vectorTo', ->

		b = null
		d = null

		beforeEach ->
			b = new Vector 3, 4
			d = a.vectorTo b


		it 'should return the null vector when called without a target', ->
			d = a.vectorTo()
			assert.strictEqual d.x, 0
			assert.strictEqual d.y, 0

		it 'should return a properly instanciated vector', ->
			assert.strictEqual d.isVector, true

		it 'should correctly calculate the delta vector', ->
			assert.strictEqual d.x, b.x - a.x
			assert.strictEqual d.y, b.y - a.y



	describe 'Vector::distanceTo', ->

		b = null
		d = null


		beforeEach ->
			b = new Vector 4.5, 6.5
			d = a.distanceTo b

		it 'should correctly calculate the distance', ->
			assert.strictEqual d, 5



	describe 'Vector::clone', ->

		b = null
		beforeEach -> b = a.clone()


		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isVector, true

		it 'should return a `Vector` with equal `x` and `y`', ->
			assert.strictEqual b.x, a.x
			assert.strictEqual b.y, a.y



	describe 'Vector::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
