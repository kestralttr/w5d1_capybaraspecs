require 'rails_helper'
require 'rails_helper'

RSpec.describe Goal, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of(:body)}
  end

  describe "associations" do
    it { should belong_to(:user)}
    it { should have_many(:comments)}
  end


end
