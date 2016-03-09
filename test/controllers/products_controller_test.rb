require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post :create, product: { active: @product.active, bar_code_type: @product.bar_code_type, brand_name: @product.brand_name, description_full: @product.description_full, description_short: @product.description_short, gtin: @product.gtin, information_provider_gln: @product.information_provider_gln, internal_supplier_code: @product.internal_supplier_code, unit_descriptor: @product.unit_descriptor }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test 'should show product' do
    get :show, id: @product
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @product
    assert_response :success
  end

  test 'should update product' do
    patch :update, id: @product, product: { active: @product.active, bar_code_type: @product.bar_code_type, brand_name: @product.brand_name, description_full: @product.description_full, description_short: @product.description_short, gtin: @product.gtin, information_provider_gln: @product.information_provider_gln, internal_supplier_code: @product.internal_supplier_code, unit_descriptor: @product.unit_descriptor }
    assert_redirected_to product_path(assigns(:product))
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
