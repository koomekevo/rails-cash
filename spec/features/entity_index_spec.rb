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
    visit group_entities_path(@group.id)
  end

  scenario 'display My Entitys on page' do
    expect(page).to have_content('Travel\'s transactions')
    expect(page).to have_content('Total spent:')
  end

  scenario 'display Entity details on page' do
    expect(page).to have_content @entity.name
    expect(page).to have_content @entity.amount
  end

  scenario 'display SCAN button on page' do
    expect(page).to have_link 'SCAN'
  end

  scenario 'When I click on SCAN, I am redirected to that Entity\'s new page.' do
    click_link('SCAN')
    expect(page).to have_current_path new_group_entity_path(@group.id)
  end
end
