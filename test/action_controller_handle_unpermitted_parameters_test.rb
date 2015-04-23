require 'test_helper'

class UsersController < ActionController::Base
  include ActionController::HandleUnpermittedParameters

  def create
    params.permit(:user)
    head :ok
  end
end

class ActionControllerHandleUnpermittedParamsTest < ActionController::TestCase
  tests UsersController

  def setup
    @log = StringIO.new
    ParamsPatrol.handler= lambda { |x| Logger.new(@log).info(x) }
  end

  test 'missing required parameters will not raise an exception' do
    post :create, { fishing: true }
    assert_response :ok
  end

  test 'missing required parameters will log' do
    post :create, { fishing: true }
    @log.rewind
    assert_block do
      /ActionController::UnpermittedParameters/.match(@log.read)
    end
  end
end
