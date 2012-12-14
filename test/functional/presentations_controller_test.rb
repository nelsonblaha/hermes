require 'test_helper'

class PresentationsControllerTest < ActionController::TestCase
  setup do
    @presentation = create(:presentation)
  end

  # scaffold tests

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:presentations)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create presentation" do
      assert_difference('Presentation.count') do
        post :create, presentation: attributes_for(:presentation)
      end

      assert_redirected_to presentation_path(assigns(:presentation))
    end

    test "should show presentation" do
      get :show, id: @presentation
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @presentation
      assert_response :success
    end

    test "should update presentation" do
      put :update, id: @presentation, presentation: attributes_for(:presentation)
      assert_redirected_to presentation_path(assigns(:presentation))
    end

    test "should destroy presentation" do
      assert_difference('Presentation.count', -1) do
        delete :destroy, id: @presentation
      end

      assert_redirected_to presentations_path
    end

  test "should get index for rule" do
    rule = create(:rule)
    get :index_for_rule, id: rule
    assert_response :success
  end

end
