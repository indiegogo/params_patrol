require 'test_helper'

class DecoratesParamsActuallyLogsOnUnpermittedParamsTest < ActiveSupport::TestCase
  def setup
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
  end

  def teardown
    ActionController::Parameters.action_on_unpermitted_parameters = false
  end

  test 'does not raise on unexpected params and returns the params object' do
    params = ActionController::DecoratesParameters.new(ActionController::Parameters.new({
                                                                                          :book => { :pages => 65 },
                                                                                          :fishing => 'Turnips'
                                                                                        }))

    ParamsPatrol.expects(:handle)
    result = params.permit(:book => [:pages])
    assert_equal(params, result)
  end

  test 'does not raise on unexpected params after a require and returns the params object' do
    params = ActionController::DecoratesParameters.new(ActionController::Parameters.new({
                                                                                          :book => { :pages => 65, :fishing => 'Turnips' },
                                                                                        }))

    ParamsPatrol.expects(:handle)
    result = params.require(:book).permit(:pages)
    assert_equal(params[:book].to_s, result.to_s)
  end

  test 'does not raise on unexpected params after fetching a sub hash by key and returns the sub hash object' do
    params = ActionController::DecoratesParameters.new(ActionController::Parameters.new({
                                                                                          :book => { :pages => 65, :fishing => 'Turnips' },
                                                                                        }))

    ParamsPatrol.expects(:handle)
    result = params[:book].permit(:pages)
    assert_equal(params[:book].to_s, result.to_s)
  end

  test 'does not raise on unexpected nested params' do
    params = ActionController::DecoratesParameters.new(ActionController::Parameters.new({
                                                                                          :book => { :pages => 65, :title => 'Green Cats and where to find then.' }
                                                                                        }))

    ParamsPatrol.expects(:handle)
    params.permit(:book => [:pages])
  end
end
