class HomeController < ApplicationController
  before_action :login_user,{only: :top}
  
  def top
  end

  def about
  end
end
