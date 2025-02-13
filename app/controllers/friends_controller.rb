# app/controllers/friends_controller.rb
class FriendsController < ApplicationController
    before_action :require_user
    #before_action :require_user, only: [:index] # Protect the index action
    #skip_before_action :authenticate_user!, only: [:index]
    
    #def index
      # List current friends and pending requests
      #@friends = current_user.friends
      #@pending_requests = Friendship.where(friend: current_user, status: 'pending')
      #@users = User.where.not(id: current_user.id) # Get all users except the current user
      
    #end

    def index
      # Ensure @pending_requests is initialized to an empty array or a valid collection
      #@pending_requests = current_user.pending_friend_requests || []
      #@pending_requests = FriendRequest.where(receiver: current_user, status: 'pending')
      #@pending_requests = current_user.pending_friend_requests || [] # Ensure it's not nil
      # If you have other instance variables like @users, @friends, etc., assign them here
      @search_query = params[:search]
      #if @search_query.present?
        #@users = User.where("name LIKE ?", "%#{@search_query}%").where.not(id: current_user.id)
      #else
        #@users = [] # or provide a default collection
      #end
  
      @friends = current_user.friends
      #@users = User.where.not(id: current_user.id)
      @users = User.all
      @pending_requests = current_user.sent_friend_requests.pending || []
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
      friend = User.find_by(id: params[:id]) # Change from params[:friend_id] to params[:id]
      if friend.nil?
        flash[:alert] = "Friend not found."
        redirect_to friends_path and return
      end
    
      if current_user != friend
        existing_request = Friendship.find_by(user: current_user, friend: friend)
        
        unless existing_request
          Friendship.create(user: current_user, friend: friend, status: 'pending')
          flash[:notice] = "Friend request sent."
        else
          flash[:alert] = "Friend request already exists."
        end
      else
        flash[:alert] = "You cannot add yourself as a friend."
      end
    
      redirect_to friends_path
    end
    
    

    def add1
      friend = User.find(params[:friend_id])
      if friend && current_user != friend
        existing_request = Friendship.find_by(user: current_user, friend: friend)
        
        unless existing_request
        #if existing_request.nil?
          current_user.friendships.create(friend: friend)
          #Friendship.create(user: current_user, friend: friend, status: 'pending')
          redirect_to friends_path, notice: "Friend request sent to #{friend.name}"
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


    def search
      @query = params[:query]
      @friends = User.where("name LIKE ?", "%#{@query}%")
      @pending_requests = current_user.pending_friend_requests || [] # Ensure it's not nil
      #respond_to do |format|
        #format.html { render :search } # Renders search.html.erb (Solution 1)
        #format.json { render json: @friends } # For API requests
      #end
      #redirect_to friends_path, notice: "Search completed."
      render :index

    end

    #def search
      # Getting the search query from the form
      #@search_query = params[:search].strip
      
      # Fetch users that match the query (excluding the current user)
      #@users = User.where("name LIKE ?", "%#{@search_query}%").where.not(id: current_user.id)
      
      # Render the index view with the filtered users
      #render :index
    #end
  end
  

