require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Clicking the details link takes a user to the products page" do
    # ACT
    visit root_path
    # find('.product header').click
    # find_link('/products/1').trigger("click")
    find_link("Details").trigger("click")

    # visit '/products/1'

    # puts page.html

    # DEBUG
    # save_screenshot

    # VERIFY
    expect(page).to have_css '.product-detail'
  end
end
