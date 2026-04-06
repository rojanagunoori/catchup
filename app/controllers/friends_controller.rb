# # app/controllers/friends_controller.rb
# class FriendsController < ApplicationController
#     before_action :require_user
#     #before_action :require_user, only: [:index] # Protect the index action
#     #skip_before_action :authenticate_user!, only: [:index]
    
   

#     def index
      
#       @search_query = params[:search]
#       #@search_query = params[:query]
      
#       #if params[:query].present?
#         #@users = User.where("name ILIKE ?", "%#{params[:query]}%")
#       #else
#        # @users = User.all # Show all users by default
#       #end

#       if params[:query].nil? || params[:query].strip == ""
#         @users = User.all # Show all users when search input is empty
#       else
#         @users = User.where("name ILIKE ?", "%#{params[:query]}%") # Filter users
#       end
  
#       @friends = current_user.friends
#       #@users = User.where.not(id: current_user.id)
#       #@users = User.all
#       #@pending_requests = current_user.sent_friend_requests.pending || []
#       #@pending_requests = Friendship.where(friend: current_user, status: :pending) || []
#       #@received_requests = current_user.received_friend_requests.pending.includes(:sender)
#       @pending_requests = current_user.sent_friend_requests.pending || []
  
#        # ✅ Ensure @received_requests is always set
#        @received_requests = current_user.received_friend_requests.pending || []
#     end

#     def show
#       @user = User.find(params[:id]) # Show user profile
#       #render json: @friend # Ensure JSON response
#       @friend = User.find_by(id: params[:id])

#       #if @friend.nil?
#       rescue ActiveRecord::RecordNotFound
#         redirect_to root_path, alert: "Friend not found"
#       #else
#         #respond_to do |format|
#           #format.html # Renders show.html.erb (default behavior)
#           #format.json { render json: @friend } # API response
#         #end
#       #end

#     end


#     def create
#       friend = User.find(params[:friend_id])
#       current_user.send_friend_request(friend)
#       redirect_to users_path, notice: "Friend request sent."
#     end


#     def update
#       friendship = current_user.pending_requests.find(params[:id])
  
#       if params[:status] == "accepted"
#         friendship.update(status: "accepted")
#         notice_message = "Friend request accepted."
#       else
#         friendship.update(status: "rejected")
#         notice_message = "Friend request rejected."
#       end
  
#       redirect_to friend_requests_path, notice: notice_message
#     end
    
#     #def add
#     #  friend = User.find_by(email: params[:email])
#       #if friend
#         #Friendship.create(user: current_user, friend: friend, status: 'pending')
#         #redirect_to friends_path, notice: "Friend request sent."
#       #else
#         #redirect_to friends_path, alert: "User not found."
#       #end
#     #end

#     def add
#       friend = User.find_by(id: params[:id]) 
#       if friend.nil?
#         flash[:alert] = "Friend not found."
#         redirect_to users_path and return
#       end
    
#       current_user.sent_friend_requests.create(receiver: friend, status: "pending")
#       flash[:notice] = "Friend request sent to #{friend.name}"
      
#       redirect_to users_path
#     end

#     def add2
#       friend = User.find_by(id: params[:id]) # Change from params[:friend_id] to params[:id]
#       current_user.sent_requests.create(receiver: friend)
#       flash[:notice] = "Friend request sent to #{friend.name}"
#       if friend.nil?
#         flash[:alert] = "Friend not found."
#         redirect_to friends_path and return
#       end
    
#       if current_user != friend
#         existing_request = Friendship.find_by(user: current_user, friend: friend)
        
#         unless existing_request
#           Friendship.create(user: current_user, friend: friend, status: 'pending')
#           flash[:notice] = "Friend request sent."
#         else
#           flash[:alert] = "Friend request already exists."
#         end
#       else
#         flash[:alert] = "You cannot add yourself as a friend."
#       end
    
#       redirect_to friends_path
#     end
    
    

#     def add1
#       friend = User.find(params[:friend_id])
#       if friend && current_user != friend
#         existing_request = Friendship.find_by(user: current_user, friend: friend)
        
#         unless existing_request
#         #if existing_request.nil?
#           current_user.friendships.create(friend: friend)
#           #Friendship.create(user: current_user, friend: friend, status: 'pending')
#           redirect_to friends_path, notice: "Friend request sent to #{friend.name}"
#         else
#           redirect_to friends_path, alert: "Friend request already sent."
#         end
#       else
#         redirect_to friends_path, alert: "Invalid user."
#       end
#     end

#     def accept
#       request = current_user.received_friend_requests.find_by(sender_id: params[:id])
#       if request
#         request.update(status: "accepted") # ✅ Proper way to update status
#         flash[:notice] = "Friend request accepted."
#       else
#         flash[:alert] = "Friend request not found."
#       end
#       redirect_to friends_path
#     end
    
    
    
#     def accept1
#       #friendship = Friendship.find(params[:id])
#       friendship = Friendship.find_by(id: params[:id], friend: current_user, status: 'pending')
#       #if friendship.update(status: 'accepted')
#       #if friendship.friend == current_user && friendship.status == 'pending'
#       if friendship
#         friendship.update(status: 'accepted')
#         redirect_to friends_path, notice: "Friend request accepted."
#       else
#         redirect_to friends_path, alert: "Could not accept request."
#       end
#     end
    
#     def reject
#       #friendship = Friendship.find(params[:id])
#       friendship = Friendship.find_by(id: params[:id], friend: current_user, status: 'pending')
#       #if friendship.update(status: 'rejected')
#       #if friendship.friend == current_user && friendship.status == 'pending'
#       if friendship
#         friendship.update(status: 'rejected')
#         redirect_to friends_path, notice: "Friend request rejected."
#       else
#         redirect_to friends_path, alert: "Could not reject request."
#       end
#     end


#     def search
#       @query = params[:query]  # Store the query in an instance variable
#       if @query.present?
#         @friends = User.where("name LIKE ?", "%#{@query}%")
#       else
#         @friends =User.all #User.none # Prevents loading all users when query is empty
#       end
#       @pending_requests = current_user.pending_friend_requests || [] # Ensure it's not nil
#       render :index
#     end

#     #def search
#       # Getting the search query from the form
#       #@search_query = params[:search].strip
      
#       # Fetch users that match the query (excluding the current user)
#       #@users = User.where("name LIKE ?", "%#{@search_query}%").where.not(id: current_user.id)
      
#       # Render the index view with the filtered users
#       #render :index
#     #end


#     def destroy
#       friendship = Friendship.find(params[:id])
#       if friendship.user == current_user || friendship.friend == current_user
#         friendship.destroy
#         redirect_to friends_path, notice: "Friend removed."
#       else
#         redirect_to friends_path, alert: "You cannot remove this friendship."
#       end
#     end
#   end
  

class FriendsController < ApplicationController
  before_action :require_user

  # Display all users, friends, and pending requests
  def index
    @query = params[:query]&.strip
    @users = if @query.present?
               User.where("name ILIKE ?", "%#{@query}%")
             else
               User.all
             end

    @friends = current_user.friends
    @pending_requests = current_user.sent_friend_requests.pending
    @received_requests = current_user.received_friend_requests.pending
  end

  # Show a user's profile
  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "User not found."
  end

  # Send a friend request
  def add
    friend = User.find_by(id: params[:id])
    return redirect_to users_path, alert: "Friend not found." unless friend
    return redirect_to users_path, alert: "You cannot add yourself as a friend." if current_user == friend

    existing_request = Friendship.find_by(user: current_user, friend: friend)
    if existing_request
      flash[:alert] = "Friend request already exists."
    else
      current_user.sent_friend_requests.create(friend: friend, status: "pending")
      flash[:notice] = "Friend request sent to #{friend.name}."
    end
    redirect_to users_path
  end

  # Accept a friend request
  def accept
    friendship = current_user.received_friend_requests.pending.find_by(id: params[:id])
    if friendship
      friendship.update(status: "accepted")
      flash[:notice] = "Friend request accepted."
    else
      flash[:alert] = "Friend request not found."
    end
    redirect_to friends_path
  end

  # Reject a friend request
  def reject
    friendship = current_user.received_friend_requests.pending.find_by(id: params[:id])
    if friendship
      friendship.update(status: "rejected")
      flash[:notice] = "Friend request rejected."
    else
      flash[:alert] = "Friend request not found."
    end
    redirect_to friends_path
  end

  # Remove a friend
  def destroy
    friendship = Friendship.find_by(id: params[:id])
    if friendship && (friendship.user == current_user || friendship.friend == current_user)
      friendship.destroy
      flash[:notice] = "Friend removed."
    else
      flash[:alert] = "Friendship not found or cannot remove."
    end
    redirect_to friends_path
  end

  # Search friends (optional)
  def search
    @query = params[:query]&.strip
    @friends = if @query.present?
                 User.where("name ILIKE ?", "%#{@query}%")
               else
                 User.all
               end
    @pending_requests = current_user.pending_friend_requests
    render :index
  end
end