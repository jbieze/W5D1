# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Test:
  # • Model validations: User shoulda-matchers
  # • Model associations
  # • Class scope methods (e.g. User::find_by_credentials)

  subject(:user) do
    User.create!(username: "butterbot", password: "what_is_my_purpose")
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:goals) }

  it "finds a user by credentials" do
    User.create!(username: "schnoopy_bloopers", password: "immortality_fields_rule")
    user = User.find_by_username("schnoopy_bloopers")
    expect(user.is_password?("immortality_fields_rule")).to be true
  end

  it "does not save actual passwords" do
    User.create!(username: "birdperson", password: "i_am_birdperson")
    user = User.find_by_username("birdperson")
    expect(user.password).not_to be("i_am_birdperson")
  end

  it "BCrypts passwords" do
    expect(BCrypt::Password).to receive(:create)
    User.new(username: "birdperson", password: "i_am_birdperson")
  end

end
