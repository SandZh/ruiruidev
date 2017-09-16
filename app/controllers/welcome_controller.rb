class WelcomeController < ApplicationController
  def index
    flash[:notice] = "～你好啊～"
  end
end
