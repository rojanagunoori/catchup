class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'
    validates :user_id, uniqueness: { scope: :friend_id, message: "Friend request already sent" }
  
    enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true

    def create
        friend = User.find(params[:friend_id])
        
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
        if friendship.update(status: "rejected")
          flash[:notice] = "Friend request rejected!"
        else
          flash[:alert] = "Unable to reject friend request."
        end
        redirect_to friends_path
      end
  end
  