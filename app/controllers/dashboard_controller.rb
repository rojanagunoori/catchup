class DashboardController < ApplicationController
    before_action :require_user # Ensure only logged-in users access this page
  
    def index
      @user = current_user
    end
  end
  