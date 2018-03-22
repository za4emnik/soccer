module LoginControllerMacros
  def login_admin
    before(:each) do
      @logged_user = FactoryBot.create(:admin)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @logged_user
    end
  end

  def login_user
    before(:each) do
      @logged_user = FactoryBot.create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @logged_user
    end
  end
end
