class Admin::AdminHomeController < Admin::AdminBaseController
  load_and_authorize_resource :users

  def index
  end
end
