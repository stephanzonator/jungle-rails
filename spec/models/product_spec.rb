require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    describe 'Happy path' do
      it 'should correctly add a product' do
        @category = Category.new(:name => "Test categorybb")
        @category.save
        @product = Product.new(:name => "Test product", :description => "test", :image => "/uploads/product/image/13/tiny_like.png", :price_cents => "200", :quantity => "1", :category_id => @category.id,)
        @product.save

        expect(@category).to be_present
        expect(@product).to be_present
        expect(@product.name).to be_present
        expect(@product.price_cents).to be_present
        expect(@product.quantity).to be_present
        expect(@product.category).to be_present
      end
    end

    describe 'Name' do
      it 'should correctly yield error if no product name present' do
        @category = Category.new(:name => "Test categorybb")
        @category.save
        @product = Product.new(:name => nil, :description => "test", :image => "/uploads/product/image/13/tiny_like.png", :price_cents => "200", :quantity => "1", :category_id => @category.id,)
        @product.save

        # puts "***************************************************************"
        # puts @product.errors.full_messages

        expect(@category).to be_present
        expect(@product).to be_present
        expect(@product.name).to be_nil
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end
  
    describe 'Price' do
      it 'should correctly yield error if no product price present' do
        @category = Category.new(:name => "Test categorybb")
        @category.save
        @product = Product.new(:name => "test name", :description => "test", :image => "/uploads/product/image/13/tiny_like.png", :price_cents => nil, :quantity => "1", :category_id => @category.id,)
        @product.save

        expect(@category).to be_present
        expect(@product).to be_present
        expect(@product.price).to be_nil
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    describe 'Quantity' do
      it 'should correctly yield error if no product quantity present' do
        @category = Category.new(:name => "Test categorybb")
        @category.save
        @product = Product.new(:name => "test name", :description => "test", :image => "/uploads/product/image/13/tiny_like.png", :price_cents => "200", :quantity => nil, :category_id => @category.id,)
        @product.save

        expect(@category).to be_present
        expect(@product).to be_present
        expect(@product.quantity).to be_nil
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'Category' do
      it 'should correctly yield error if no product category present' do
        @category = Category.new(:name => "Test categorybb")
        @category.save
        @product = Product.new(:name => nil, :description => "test", :image => "/uploads/product/image/13/tiny_like.png", :price_cents => "200", :quantity => "1", :category_id => nil,)
        @product.save

        # puts "***************************************************************"
        # puts @product.errors.full_messages

        expect(@category).to be_present
        expect(@product).to be_present
        expect(@product.category).to be_nil
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end
end
