class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'
    validates :user_id, uniqueness: { scope: :friend_id, message: "Friend request already sent" }
  
    enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true

    def create1
      if params[:friend_id].present?
        friend = User.find(params[:friend_id])
        # Proceed with creating a friendship
      else
        flash[:alert] = "Friend ID is missing"
        redirect_back(fallback_location: root_path)
      end
        #friend = User.find(params[:friend_id])
        
        if current_user.friends.include?(friend) || current_user.pending_friend_requests.exists?(sender_id: friend.id)
          flash[:alert] = "Unable to send friend request: Friend request already sent."
        else
          @friendship = current_user.sent_friend_requests.build(friend: friend, status: "pending")
          if @friendship.save
            flash[:notice] = "Friend request sent!"
          else
            flash[:alert] = "Unable to send friend request."
          end
        end
    
        redirect_to friends_path
      end

      def show
        friendship = Friendship.find_by(id: params[:id])
        if friendship
          render json: friendship
        else
          render json: { error: "Friendship not found" }, status: 404
        end
      end
    
      def accept
        friendship = Friendship.find(params[:id])
        if friendship.update(status: "accepted")
          flash[:notice] = "Friend request accepted!"
        else
          flash[:alert] = "Unable to accept friend request."
        end
        redirect_to friends_path
      end
    
      def reject
        friendship = Friendship.find(params[:id])
        #if friendship.update(status: "rejected")
        if friendship && friendship.destroy
          flash[:notice] = "Friend request rejected!"
        else
          flash[:alert] = "Unable to reject friend request."
        end
        redirect_to friends_path
      end

      def destroy
        @friendship = Friendship.find_by(id: params[:id])  # ✅ Use `find_by` instead of `find`
    
        if @friendship
          @friendship.destroy
          redirect_to friendships_path, notice: "Friend removed successfully."
        else
          redirect_to friendships_path, alert: "Friend not found."
        end
      end

      def destroy1
        friendship = Friendship.find_by(id: params[:id]) # Ensure friendship exists
        if friendship
          friendship.destroy
          flash[:notice] = "Friend removed successfully"
        else
          flash[:alert] = "Friendship not found"
        end
        redirect_back(fallback_location: root_path)
      end

      def remove
        @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id]) ||
                      Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
        
        if @friendship
          @friendship.destroy
          respond_to do |format|
            format.html { redirect_to friendships_path, notice: "Friend removed successfully." }
            format.json { head :no_content }
            format.turbo_stream # For Turbo updates
          end
        else
          redirect_to friendships_path, alert: "Friend not found."
        end


        def status
          friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
          if friendship
            render json: { status: friendship.status }
          else
            render json: { error: "Friendship not found" }, status: 404
          end
        end
      end
      
      
  end
  