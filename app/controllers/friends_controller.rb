# app/controllers/friends_controller.rb
class FriendsController < ApplicationController
    before_action :require_user
    
    def index
      # List current friends and pending requests
      @friends = current_user.friends
      @pending_requests = Friendship.where(friend: current_user, status: 'pending')

      #@pending_requests = current_user.friendships.where(status: 'pending')
    end
    
    #def add
    #  friend = User.find_by(email: params[:email])
      #if friend
        #Friendship.create(user: current_user, friend: friend, status: 'pending')
        #redirect_to friends_path, notice: "Friend request sent."
      #else
        #redirect_to friends_path, alert: "User not found."
      #end
    #end

    def add
      friend = User.find(params[:friend_id])
      if friend && current_user != friend
        existing_request = Friendship.find_by(user: current_user, friend: friend)
        
        if existing_request.nil?
          Friendship.create(user: current_user, friend: friend, status: 'pending')
          redirect_to friends_path, notice: "Friend request sent."
        else
          redirect_to friends_path, alert: "Friend request already sent."
        end
      else
        redirect_to friends_path, alert: "Invalid user."
      end
    end
    
    
    def accept
      friendship = Friendship.find(params[:id])
      #if friendship.update(status: 'accepted')
      if friendship.friend == current_user && friendship.status == 'pending'
        friendship.update(status: 'accepted')
        redirect_to friends_path, notice: "Friend request accepted."
      else
        redirect_to friends_path, alert: "Could not accept request."
      end
    end
    
    def reject
      friendship = Friendship.find(params[:id])
      #if friendship.update(status: 'rejected')
      if friendship.friend == current_user && friendship.status == 'pending'
        friendship.update(status: 'rejected')
        redirect_to friends_path, notice: "Friend request rejected."
      else
        redirect_to friends_path, alert: "Could not reject request."
      end
    end
  end
  

