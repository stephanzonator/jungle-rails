require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should contain all required fields" do
      @user = User.new(:name => "test name", :email => "testmail", :password => "aaa", :password_confirmation => "aaa")
      @user.save

      expect(@user).to be_present
      expect(@user.password).to be_present
      expect(@user.password_confirmation).to be_present
      expect(@user.name).to be_present
      expect(@user.email).to be_present
      # expect(@user.password).to eq(@user.password_confirmation)
    end

    it "should throw an error if name is not present" do
      @user = User.new(:name => nil, :email => "testmail", :password => "aaa", :password_confirmation => "aaa")
      @user.save

      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should throw an error if email is not present" do
      @user = User.new(:name => "testname", :email => nil, :password => "aaa", :password_confirmation => "aaa")
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should throw an error if password is not present" do
      @user = User.new(:name => "testname", :email => "testmail", :password => nil, :password_confirmation => "aaa")
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should throw an error if password doesn't match password confirmation" do
      @user = User.new(:name => "testname", :email => "testmail", :password => "aab", :password_confirmation => "aaa")
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should throw an error if email isn't unique" do
      @user = User.new(:name => "testname", :email => "testmail", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user2 = User.new(:name => "testname2", :email => "testmail", :password => "aaaaaa2", :password_confirmation => "aaaaaa2")
      @user.save
      @user2.save
      
      # puts @user2.errors.full_messages
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should throw an error if email isn't unique, including case sensitivity" do
      @user = User.new(:name => "testname", :email => "testmail", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user2 = User.new(:name => "testname2", :email => "TESTMAIL", :password => "aaaaaa2", :password_confirmation => "aaaaaa2")
      @user.save
      @user2.save
      
      # puts @user2.errors.full_messages
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should throw an error if password isn't long enough" do
      @user = User.new(:name => "testname", :email => "testmail", :password => "a", :password_confirmation => "a")
      @user.save
      
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

  end

  describe ".authenticate_with_credentials" do
    it "should authenticate a user with correct credentials" do
      @user = User.new(:name => "test name", :email => "test@mail.com", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user.save

      expect(User.authenticate_with_credentials("test@mail.com", "aaaaaa")).to eq(@user) 
    end

    it "should not authenticate a user with incorrect credentials" do
      @user = User.new(:name => "test name", :email => "test@mail.com", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user.save

      expect(User.authenticate_with_credentials("test@mail.com", "aaaaab")).to eq(false) 
    end

    it "should authenticate a user with an email in the wrong case" do
      @user = User.new(:name => "test name", :email => "test@mail.com", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user.save

      expect(User.authenticate_with_credentials("TEST@mail.com", "aaaaaa")).to eq(@user) 
    end

    it "should authenticate a user with an email with whitespace" do
      @user = User.new(:name => "test name", :email => "test@mail.com", :password => "aaaaaa", :password_confirmation => "aaaaaa")
      @user.save

      expect(User.authenticate_with_credentials("   test@mail.com   ", "aaaaaa")).to eq(@user) 
    end

    
  end
end
