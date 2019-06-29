require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  # ユーザーはサインアップに成功する
  scenario "user successfully signs up" do
    visit root_path
    click_link "Sign_up"

    perform_enqueued_jobs do
      expect{
        fill_in "First name", with: "First"
        fill_in "Last name", with: "Last"

        fill_in "Email", with: "test@exapmple.com"
        fill_in "Password", with: "test123"

        fill_in "Paassword confirmation", with: "test123"
        click_button "Sign up"
      }. to change(User, :count).by(1)
      
      expect(page).to have_content "Welcome! You have signed up successfully."
      expect(current_path).to eq root_path
      expect(page).to have_content "First Last"
    end

    mail = ActionMailer::Base.deliveries.last

    aggregate_failure do
      expect(mail.to).to eq ["test@exapmple.com"]
      expect(mail.from).to eq ["support@exapmple.com"]
      expect(mail.subject).to eq "Welcome to Project"
      expect(mail.body).to eq "Hello First,"
      expect(mail.body).to eq "test@example.com"
    end
  end
end