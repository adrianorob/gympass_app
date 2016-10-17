require 'rails_helper'

feature 'home page' do
  scenario 'list of gyms message' do
    visit('/')
    expect(page).to have_content('List of Gyms near your work address')
  end

  scenario 'see the login link' do
    visit('/')
    expect(page).to have_content('Login')
  end

  scenario 'visit user sign_up' do
    visit('/users/sign_up')
    expect(page).to have_content('Sign up')
  end

  scenario 'register user' do
    visit('/users/sign_up')

    fill_in('Email', with: 'adriano@gympass.com')
    fill_in('Name', with: 'Xará')

    find('input#user_admin', visible: false).set("true")

    fill_in('Work Address', with: 'São Paulo')
    choose('Gym Manager')

    fill_in('Password', with: '123123', :match => :first)
    fill_in('Password confirmation', with: '123123')

    click_button('Sign up')
    expect(page).to have_content('Hello Xará, you are currently signed as Admin')
    expect(page).to have_content('Get Daily Token')
  end

  scenario 'not logged user cannot retrieve daily token' do
    visit('/')
    expect(page).to have_no_content('Get Daily Token')
  end
end
