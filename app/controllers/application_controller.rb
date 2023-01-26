class ApplicationController < ActionController::Base
  private

  def current_identity
    cookies.permanent[:identity]
  end
end
