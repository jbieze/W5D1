# spec/features/auth_spec.rb
require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do

    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "million_ants"
      fill_in 'Password', :with => "long_live_the_queen"
      click_on "Create Account"
    end

    scenario "redirects to user's show page after signup" do
      expect(page).to have_content 'Account'
    end

  end

  feature "with an invalid user" do

    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "phoenixperson"
      click_on "Create Account"
    end

    scenario "re-renders the signup page after failed signup" do

    end

  end

end

#
# feature 'the signup process' do
#   scenario 'has a new user page'
#
#   feature 'signing up a user' do
#
#     scenario 'shows username on the homepage after signup'
#
#   end
# end
#
# feature 'logging in' do
#   scenario 'shows username on the homepage after login'
#
# end
#
# feature 'logging out' do
#   scenario 'begins with a logged out state'
#
#   scenario 'doesn\'t show username on the homepage after logout'
#
# end
