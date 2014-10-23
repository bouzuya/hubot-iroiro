{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'iroiro', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    describe 'valid patterns', ->
      beforeEach ->
        @tests = [
          message: '@hubot iroiro abc'
          matches: ['@hubot iroiro abc', 'abc']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[0].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot roiro abc"', ->
      beforeEach ->
        @send = @sinon.spy()
        @hello
          match: ['@hubot iroiro abc', 'abc']
          send: @send

      it 'send "http://synthsky.com/iroiro/embed?req=abc"', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'http://synthsky.com/iroiro/embed?req=abc'

  describe 'robot.helpCommands()', ->
    it 'should be ["hubot iroiro <keyword> - returns a iroiro url"]', ->
      assert.deepEqual @robot.helpCommands(), [
        'hubot iroiro <keyword> - returns a iroiro url'
      ]
