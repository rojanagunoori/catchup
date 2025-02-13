class FriendRequestsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  def create
    friend = User.find(params[:friend_id])
    if current_user.friend_requests.create(friend: friend)
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Unable to send friend request."
    end
    redirect_to friends_path
  end
end
