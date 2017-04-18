require 'test_helper'

class IndexCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name:"reading")
    @category2 = Category.create(name: "programming")
  end

  test "should show categories index page" do
    get categories_path
    assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end