require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }

  describe "associations" do
    # "it" refers to an instance of the BasketballTeam class here
    # because we have not explicitly specified a subject
    it { should have_many(:goals)}
    it { should have_many(:comments)}
  end

  let(:user) { User.create(username:"user",password:"password") }

  describe "::find_by_credentials" do
    it "finds a user" do
      user
      expect(User.find_by_credentials("user","password")).to eq(User.last)
    end
  end

  describe "password encryption" do
    it "encrypts a password" do
      user
      expect(User.find_by_credentials("user","password").password).to_not eq("password")
    end

    it "uses bcrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "jack_bruce", password: "abcdef")
    end
  end

  describe "session token" do
    it "assigns a session_token if one is not given" do
      expect(user.session_token).to_not eq(nil)
    end
  end

end
