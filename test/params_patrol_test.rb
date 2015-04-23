require 'test_helper'

class ParamsPatrolTest <  Test::Unit::TestCase
  def test_handler=
    logger = lambda { |x| Logger.new(StringIO.new).info(x) }
    ParamsPatrol.handler = logger
    assert_equal(logger, ParamsPatrol.handler)
  end

  def test_handle
    logger = lambda { |x| Logger.new(StringIO.new).info(x) }
    ParamsPatrol.handler = logger
    logger.expects(:call)
    ParamsPatrol.handle('unpermitted params!')
  end
end
