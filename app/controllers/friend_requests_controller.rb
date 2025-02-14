class FriendRequestsController < ApplicationController
    #before_action :authenticate_user! # Ensure the user is logged in
    before_action :require_user  # Ensure the user is logged in
    
  
    def create
      friend = User.find(params[:friend_id])
      friend_request = current_user.sent_friend_requests.build(receiver: friend, status: :pending)
      #if current_user.sent_friend_requests.create(receiver_id: friend.id, status: :pending)
      if friend_request.save
      
      #if current_user.sent_friend_requests.create(friend: friend, status: :pending)
        redirect_to friends_path, notice: "Friend request sent to #{friend.name}."
      else
        redirect_to friends_path, alert: "Unable to send friend request."
      end
    end


    def create1
      friend = User.find(params[:friend_id])


      if friend.nil?
        flash[:alert] = "User not found."
        redirect_to friends_path and return
      end
    
      if friend == current_user
        flash[:alert] = "You cannot send a friend request to yourself."
        redirect_to friends_path and return
      end
    
      friend_request = current_user.sent_friend_requests.build(receiver: friend)
  
      if friend_request.save
        flash[:notice] = "Friend request sent!"
      else
        flash[:alert] = "Unable to send friend request: #{friend_request.errors.full_messages.join(", ")}"
      end
  
      redirect_to friends_path
    end

    def accept
      friend_request = FriendRequest.find_by(id: params[:id], receiver: current_user)
    
      if friend_request.nil?
        flash[:alert] = "Friend request not found."
      elsif friend_request.update(status: "accepted")
        flash[:notice] = "Friend request accepted!"
      else
        flash[:alert] = "Could not accept request: #{friend_request.errors.full_messages.join(", ")}"
      end
    
      redirect_to friends_path
    end


    def update
      request = FriendRequest.find(params[:id])
      
      if params[:status] == "accepted"
        request.update(status: :accepted)
        current_user.friends << request.sender
        request.sender.friends << current_user
        flash[:notice] = "Friend request accepted!"
      elsif params[:status] == "rejected"
        request.update(status: :rejected)
        flash[:alert] = "Friend request rejected."
      end
    
      redirect_to friends_path
    end
    
    

    def new
      @friend_request = FriendRequest.new
    end
    
  end
  