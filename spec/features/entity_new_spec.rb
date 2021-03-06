require 'rails_helper'

RSpec.feature 'Entity index', type: :feature do
  background do
    visit new_user_session_path

    @user = User.create(name: 'Kevin', email: 'koomekevo@gmail.com', password: '1234321', confirmed_at: Time.now)
    @group = Group.create(user_id: @user.id, name: 'Travel', icon: fixture_file_upload('railscash.png'))
    @entity = @group.entities.create(name: 'china', amount: 1500, user_id: @user.id)

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Log in'
    visit new_group_entity_path(@group.id)
  end

  scenario 'display My Entitys on page' do
    expect(page).to have_content('Please add your transaction')
    expect(page).to have_content('Name')
    expect(page).to have_content('Amount')
  end

  scenario 'display Add New Category button on page' do
    expect(page).to have_button 'Save'
  end
end
