require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome mail" do
    let(:user){FactoryBot.create(:user)}
    let(:mail){UserMailer.welcome_email(user)}

    # ウェウカムメールをユーザーのメールアドレスに送信すること
    it "sends a welcome email to the user's email address" do
      expect(mail.to).to eq [user.email]
    end

    # サポート用のメールアドレスから送信すること
    it "sends from the support email address" do
      expect(mail.from).to eq ["support@example.com"]
    end

    # ユーザーにファーストネームであいさつすること
    it "greets the user by first name" do
      expect(mail.body).to match(/Hello #{user.first_name},/)
    end

    # 登録したユーザーのメールアドレスを残しておくこと
    it "reminds the user of the registered email address" do
      expect(mail.body).to match user.email
    end
  end
end
