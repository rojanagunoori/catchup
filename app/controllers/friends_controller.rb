# app/controllers/friends_controller.rb
class FriendsController < ApplicationController
    before_action :require_user
    
    def index
      # List current friends and pending requests
      @friends = current_user.friends
      @pending_requests = current_user.friendships.where(status: 'pending')
    end
    
    def add
      friend = User.find_by(email: params[:email])
      if friend
        Friendship.create(user: current_user, friend: friend, status: 'pending')
        redirect_to friends_path, notice: "Friend request sent."
      else
        redirect_to friends_path, alert: "User not found."
      end
    end
    
    def accept
      friendship = Friendship.find(params[:id])
      if friendship.update(status: 'accepted')
        redirect_to friends_path, notice: "Friend request accepted."
      else
        redirect_to friends_path, alert: "Could not accept request."
      end
    end
    
    def reject
      friendship = Friendship.find(params[:id])
      if friendship.update(status: 'rejected')
        redirect_to friends_path, notice: "Friend request rejected."
      else
        redirect_to friends_path, alert: "Could not reject request."
      end
    end
  end
  

